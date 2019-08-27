//
//  CatalogViewModel.swift
//  Mushrooms
//
//  Created by n3deep on 14/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

class CatalogViewModel: CatalogViewModelType {
    
    private var mushrooms: [Mushroom]?
    private var selectedIndexPath: IndexPath?
    var storageManager: StorageManagerType?
    
    func fetchMushrooms(completion: @escaping() -> ()) {
        storageManager = PlainDataManager()
        storageManager?.fetchMushrooms { [weak self] mushrooms in
            self?.mushrooms = mushrooms
            completion()
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return mushrooms?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CatalogTableViewCellViewModelType? {
        guard let mushroom = mushrooms?[indexPath.row] else {
            return nil
        }
        return CatalogTableViewCellViewModel(mushroom: mushroom)
    }
    
    func viewModelForSelectedRow() -> MushroomViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return MushroomViewModel(mushroom: mushrooms![selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
