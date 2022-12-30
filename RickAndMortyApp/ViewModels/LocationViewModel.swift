//
//  LocationViewModel.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class LocationViewModel{
    private var apiService = ApiService()
    private var locations = [LocationResult]()
    
    func getAllLocations(completion: @escaping () -> ()){
        apiService.getAllLocations{
            [weak self] (result) in
                switch result {
                    case .success(let dictLocations):
                        self?.locations = dictLocations
                        completion()
                    
                    case .failure(let error): print(error)
                }
        }
    }
    
    func getLocationsCount(section: Int) -> Int{
        return locations.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> LocationResult{
        return locations[indexPath.row]
    }
}
