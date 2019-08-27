//
//  MushroomViewController.swift
//  Mushrooms
//
//  Created by n3deep on 08/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import UIKit

class MushroomViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hatLabel: UILabel!
    @IBOutlet weak var legLabel: UILabel!
    @IBOutlet weak var fleshLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel: MushroomViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "Название гриба"
        photoImageView.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel else { return }
        
        self.navigationItem.title = viewModel.name
        descriptionLabel.text = viewModel.specification
        hatLabel.text = viewModel.hat
        legLabel.text = viewModel.leg
        fleshLabel.text = viewModel.flesh
        dateLabel.text = viewModel.dateDescription
        
        photoImageView.image = UIImage(named: String(viewModel.identifier))

        if viewModel.type == 2 {
            self.navigationController?.navigationBar.barTintColor = UIColor.systemRed
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.navBarGreen
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
