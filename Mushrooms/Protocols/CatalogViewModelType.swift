//
//  CatalogViewModelType.swift
//  Mushrooms
//
//  Created by n3deep on 14/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

protocol CatalogViewModelType {
    func fetchMushrooms(completion: @escaping() -> ()) 
    func numberOfRowsInSection() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CatalogTableViewCellViewModelType?
    
    func viewModelForSelectedRow() -> MushroomViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
