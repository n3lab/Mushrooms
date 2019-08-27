//
//  MushroomViewModelType.swift
//  Mushrooms
//
//  Created by n3deep on 15/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

protocol MushroomViewModelType {
    var identifier: String { get }
    
    var name: String { get }
    var type: Int { get }
    var photoURL: String { get }
    
    var specification: String { get }
    
    var hat: String { get }
    var leg: String { get }
    var flesh: String { get }
    
    var beginDate: Int { get }
    var endDate: Int { get }
    var dateDescription: String { get }
}
