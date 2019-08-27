//
//  SearchViewModel.swift
//  Mushrooms
//
//  Created by n3deep on 18/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

class SearchViewModel: SearchViewModelType {
    
    private var mushrooms: [Mushroom]?
    private var selectedIdentifier: IndexPath?
    private var foundIdentifier: Int?
    var storageManager: StorageManagerType?
    
    func fetchMushrooms(completion: @escaping () -> ()) {
        storageManager = PlainDataManager()
        storageManager?.fetchMushrooms { [weak self] mushrooms in
            self?.mushrooms = mushrooms
            completion()
        }
    }
    
    func viewModelForFoundMushroomIdentifier() -> MushroomViewModelType? {
        guard let mushrooms = mushrooms, let foundIdentifier = foundIdentifier else { return nil }
        for mushroom in mushrooms {
            if (mushroom.identifier == foundIdentifier) {
                return MushroomViewModel(mushroom: mushroom)
            }
        }
        return nil
    }
    
    func selectIdentifier(_ identifier: String) {
        self.foundIdentifier = Int(identifier)
    }
    
}
