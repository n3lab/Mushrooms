//
//  CatalogTableViewCellViewModelType.swift
//  Mushrooms
//
//  Created by n3deep on 14/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

protocol CatalogTableViewCellViewModelType: class {
    var name: String { get }
    var type: Int { get }
}
