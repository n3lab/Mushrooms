//
//  StorageManagerType.swift
//  Mushrooms
//
//  Created by n3deep on 15/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

protocol StorageManagerType {
    func fetchMushrooms(completion: ([Mushroom]) -> ())
}
