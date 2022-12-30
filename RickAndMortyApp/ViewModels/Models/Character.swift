//
//  Characters.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit

struct Characters : Decodable{
    let results: [CharacterResult]
}

struct CharacterResult: Decodable {
    let id: Int
    let name: String
    let status: String
    let gender: String
    let image: String
}
