//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit

struct Episodes: Decodable{
    let results: [EpisodeResult]
}

struct EpisodeResult: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
}
