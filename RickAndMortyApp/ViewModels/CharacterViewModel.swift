//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Kobylkin Daniil on 08.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import Foundation

class CharacterViewModel{
    private var apiService = ApiService()
    private var filteredCharacters = [CharacterResult]()
    private var allCharacters = [CharacterResult]()
    
    func getAllCharacters(completion: @escaping () -> ()){
        apiService.getAllCharacters {
            [weak self] (result) in
                switch result{
                    case .success(let dictCharacters):
                        self?.filteredCharacters = dictCharacters
                        self?.allCharacters = dictCharacters
                        completion()
                    
                    case .failure(let error): print(error)
                }
        }
    }
    
    func getFilteredCharacters() -> [CharacterResult]{
        return filteredCharacters
    }
    
    func getAllCharacters() -> [CharacterResult]{
        return allCharacters
    }
    
    func getFilteredCharactersCount(section: Int) -> Int{
        return filteredCharacters.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> CharacterResult {
        return filteredCharacters[indexPath.row]
    }
    
    func removeAllFilteredCharacters(){
        self.filteredCharacters.removeAll()
    }
    
    func appendNewCharacter(newCharacter: CharacterResult) {
        self.filteredCharacters.append(newCharacter)
    }
    
    func reloadFilteredCharacters(newCharacters: [CharacterResult]) {
        self.filteredCharacters = newCharacters
    }
}
