//
//  LocationDataService.swift
//  RickMortyGroupProject
//
//  Created by dan on 10.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class LocationDataService{
    
    private var dataTask: URLSessionDataTask?
    
    func locationAPI(completion: @escaping(Result<[LocationResult], Error>) -> Void)
    {
        var http = HttpManager()
        
        for index in 1...7 {
            http.request(url: "https://rickandmortyapi.com/api/location/?page=\(index)", key: "\(index)")
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
}
