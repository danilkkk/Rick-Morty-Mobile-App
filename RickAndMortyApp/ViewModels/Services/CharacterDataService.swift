//
//  CharacterDataService.swift
//  RickMortyGroupProject
//
//  Created by dan on 09.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation


class CharacterDataService {
    
    private var dataTask: URLSessionDataTask?
    
    func characterAPI(completion: @escaping(Result<[CharacterResult], Error>) -> Void)
    {
        
        var http = HttpManager()
        
        for index in 1...42 {
            http.request(url: "https://rickandmortyapi.com/api/character/?page=\(index)", key: "\(index)")
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
