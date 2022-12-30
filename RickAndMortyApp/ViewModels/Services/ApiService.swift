//
//  ApiService.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 28.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class ApiService{
    private var dataTask: URLSessionDataTask?
    
    func getAllEpisodes(completion: @escaping(Result<[EpisodeResult], Error>) -> Void)
    {
        let http = HttpManager()
        
        for index in 1...3 {
            http.sendRequest(url: "https://rickandmortyapi.com/api/episode/?page=\(index)", key: "\(index)")
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
    
    func getAllLocations(completion: @escaping(Result<[LocationResult], Error>) -> Void)
    {
        let http = HttpManager()
        
        for index in 1...7 {
            http.sendRequest(url: "https://rickandmortyapi.com/api/location/?page=\(index)", key: "\(index)")
        }
        
        http.addClosure {
            var jsonLocations = [LocationResult]();
            
            do {
                for (_, item) in http.dictonary {
                    let jsonLocation = try JSONDecoder().decode(Locations.self, from: item.data)
                    jsonLocations.append(contentsOf: jsonLocation.results)
                }
                
                DispatchQueue.main.async {
                    completion(.success(jsonLocations))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    func getAllCharacters(completion: @escaping(Result<[CharacterResult], Error>) -> Void)
    {
        let http = HttpManager()
        
        for index in 1...42 {
            http.sendRequest(url: "https://rickandmortyapi.com/api/character/?page=\(index)", key: "\(index)")
        }
        
        http.addClosure {
            var jsonCharacters = [CharacterResult]();
            
            do {
                for (_, item) in http.dictonary {
                    let jsonCharacter = try JSONDecoder().decode(Characters.self, from: item.data)
                    jsonCharacters.append(contentsOf: jsonCharacter.results)
                }
                
                DispatchQueue.main.async {
                    completion(.success(jsonCharacters))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
