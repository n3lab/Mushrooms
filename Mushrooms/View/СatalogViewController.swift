//
//  СatalogViewController.swift
//  Mushrooms
//
//  Created by n3deep on 08/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import UIKit

private enum ControllerEnum: String {
    case catalogSegue = "mushroomSegue"
    case cellIdentifier = "CatalogTableViewCell"
}

private enum NavBarEnum: String {
    case title = "Справочник грибов"
    case back = " "
}

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CatalogViewModelType?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NavBarEnum.title.rawValue
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = CatalogViewModel()
        viewModel?.fetchMushrooms { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let viewModel = viewModel else { return }
        
        if identifier == ControllerEnum.catalogSegue.rawValue {
            if let dvc = segue.destination as? MushroomViewController {
                dvc.viewModel = viewModel.viewModelForSelectedRow()
            }
        }
    }
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ControllerEnum.cellIdentifier.rawValue, for: indexPath) as? CatalogTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        performSegue(withIdentifier: ControllerEnum.catalogSegue.rawValue, sender: nil)
    }
}

