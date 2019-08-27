//
//  ViewController.swift
//  Mushrooms
//
//  Created by n3deep on 08/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

private enum NavBarEnum: String {
    case title = "Грибы Подмосковья"
    case back = " "
}

private enum MushroomNameEnum: String {
    case unknownMushroom = "Грибы Подмосковья"
    case defaultMessage = "Найди гриб!"
}

private enum ControllerEnum: String {
    case searchSegue = "mushroomSegue"
    case captureQueue = "captureQueue"
}

class SearchViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultView: UIView!
    @IBOutlet weak var selectMushroomButton: UIButton!
    
    @IBAction func selectMushroomButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: ControllerEnum.searchSegue.rawValue, sender: nil)
    }
    
    let session = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer!
    let captureQueue = DispatchQueue(label: ControllerEnum.captureQueue.rawValue)
    var visionRequests = [VNRequest]()
    
    var mushrooms = [Mushroom]()
    var viewModel: SearchViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NavBarEnum.title.rawValue
        self.navigationItem.backBarButtonItem?.title = NavBarEnum.back.rawValue
        
        selectMushroomButton.isEnabled = false
        
        viewModel = SearchViewModel()
        viewModel?.fetchMushrooms {}
        
        guard let camera = AVCaptureDevice.default(for: .video) else {
            return
        }
        do {
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            resultView.layer.addSublayer(previewLayer)
            
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: captureQueue)
            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            
            session.sessionPreset = .high
            session.addInput(cameraInput)
            session.addOutput(videoOutput)
            
            let connection = videoOutput.connection(with: .video)
            connection?.videoOrientation = .portrait

            setupVision()
        } catch {
            let alertController = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        session.stopRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        session.startRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = resultView.frame
        
        //портретный режим
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        
        switch (orientation) {
        case .portrait:
            previewLayer.connection?.videoOrientation = .portrait
        case .landscapeRight:
            previewLayer.connection?.videoOrientation = .landscapeLeft
        case .landscapeLeft:
            previewLayer.connection?.videoOrientation = .landscapeRight
        default:
            previewLayer.connection?.videoOrientation = .portrait
        }

    }
    
    func setupVision() {
        guard let visionModel = try? VNCoreMLModel(for: mushrooms04().model)
            else { fatalError("Can't load VisionML model") }
        
        let request = VNCoreMLRequest(model: visionModel) { (request, error) in
            guard let results = request.results else { return }
            self.handleRequestResults(results)
        }
        
        visionRequests = [request]
    }
    
    func handleRequestResults(_ results: [Any]) {
        let categoryText: String?
        
        defer {
            DispatchQueue.main.async {
                self.resultLabel.text = categoryText
            }
        }
        
        guard let foundObject = results
            .compactMap({ $0 as? VNClassificationObservation })
            .first(where: { $0.confidence > 0.7 })
            else {
                categoryText = MushroomNameEnum.defaultMessage.rawValue
                
                DispatchQueue.main.async {
                    self.selectMushroomButton.isEnabled = false
                }
                
                return
        }
        
        
        viewModel?.selectIdentifier(foundObject.identifier)
        let mushroom = viewModel?.viewModelForFoundMushroomIdentifier()
        
        let confidence = "\(round(foundObject.confidence * 100 * 100) / 100)%"
        categoryText = "\(mushroom?.name ?? MushroomNameEnum.unknownMushroom.rawValue) \(confidence)"
        
        DispatchQueue.main.async {
            self.selectMushroomButton.isEnabled = true
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        
        if identifier == ControllerEnum.searchSegue.rawValue {
            if let dvc = segue.destination as? MushroomViewController {
                dvc.viewModel = viewModel.viewModelForFoundMushroomIdentifier()
            }
        }
    }

}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension SearchViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        var requestOptions: [VNImageOption: Any] = [:]
        if let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics: cameraIntrinsicData]
        }
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 1)!, options: requestOptions)
        do {
            try imageRequestHandler.perform(visionRequests)
        } catch {
            print(error)
        }
    }
}

