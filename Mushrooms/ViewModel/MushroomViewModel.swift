//
//  MushroomViewModel.swift
//  Mushrooms
//
//  Created by n3deep on 15/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

class MushroomViewModel: MushroomViewModelType {
    var identifier: String {
        return String(mushroom.identifier)
    }
    
    var name: String {
        return mushroom.name
    }
    
    var type: Int {
        return mushroom.type
    }
    
    var photoURL: String {
        return mushroom.photoURL
    }
    
    var specification: String {
        return mushroom.specification
    }
    
    var hat: String {
        return mushroom.hat
    }
    
    var leg: String {
        return mushroom.leg
    }
    
    var flesh: String {
        return mushroom.flesh
    }
    
    var beginDate: Int {
        return mushroom.beginDate
    }
    
    var endDate: Int {
        return mushroom.endDate
    }
    
    var dateDescription: String {
        return mushroom.dateDescription
    }
        
    private var mushroom: Mushroom
    
    init(mushroom: Mushroom) {
        self.mushroom = mushroom
    }
}
