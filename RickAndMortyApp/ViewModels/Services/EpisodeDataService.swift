//
//  EpisodeDataService.swift
//  RickMortyGroupProject
//
//  Created by dan on 10.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class EpisodeDataService{
    
    private var dataTask: URLSessionDataTask?
    
    func episodeAPI(completion: @escaping(Result<[EpisodeResult], Error>) -> Void)
    {
        let url = URL(string: "https://rickandmortyapi.com/api/episode")
        
        var http = HttpManager()
        
        for index in 1...3 {
            http.request(url: "https://rickandmortyapi.com/api/episode/?page=\(index)", key: "\(index)")
        }
        
        http.addClosure {
            var jsonEpisodes = [EpisodeResult]();
            
            do {
                for (_, item) in http.dictonary {
                    let jsonEpisode = try JSONDecoder().decode(Episodes.self, from: item.data)
                    jsonEpisodes.append(contentsOf: jsonEpisode.results)
                }
                
                DispatchQueue.main.async {
                    completion(.success(jsonEpisodes))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
