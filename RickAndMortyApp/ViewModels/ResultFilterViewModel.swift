//
//  ResultFilterModel.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class ResultFilterViewModel{
    private var resultFilter = [CharacterResult]()
    
    func resultFilterList() -> [CharacterResult] {
        return resultFilter
    }
    
    func reloadResultFilter(newResult: [CharacterResult]) {
        self.resultFilter = newResult
    }
}
