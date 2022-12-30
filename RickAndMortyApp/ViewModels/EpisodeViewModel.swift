//
//  EpisodeViewModel.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class EpisodeViewModel{
    private var apiService = ApiService()
    private var episodes = [EpisodeResult]()
    
    func getAllEpisodes(completion: @escaping () -> ()){
        apiService.getAllEpisodes {
            [weak self] (result) in
                switch result {
                    case .success(let dictEpisodes):
                        self?.episodes = dictEpisodes
                        completion()
                        
                    case .failure(let error): print(error)
                }
        }
    }
    
    func getEpisodesCount(section: Int) -> Int{
        return episodes.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> EpisodeResult{
        return episodes[indexPath.row]
    }
}
