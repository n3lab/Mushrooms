//
//  SearchViewModelType.swift
//  Mushrooms
//
//  Created by n3deep on 18/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import Foundation

protocol SearchViewModelType {

    func fetchMushrooms(completion: @escaping() -> ()) 
    func viewModelForFoundMushroomIdentifier() -> MushroomViewModelType?
    func selectIdentifier(_ identifier: String)

}
