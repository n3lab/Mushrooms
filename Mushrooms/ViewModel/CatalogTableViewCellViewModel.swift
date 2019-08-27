//
//  CatalogTableViewCellViewModel.swift
//  Mushrooms
//
//  Created by n3deep on 14/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

class CatalogTableViewCellViewModel: CatalogTableViewCellViewModelType {
    private var mushroom: Mushroom
    
    var name: String {
        return mushroom.name
    }
    
    var type: Int {
        return mushroom.type
    }
    
    init(mushroom: Mushroom) {
        self.mushroom = mushroom
    }
}
