//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit

struct Locations: Decodable{
    let results: [LocationResult]
}

struct LocationResult: Decodable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}
