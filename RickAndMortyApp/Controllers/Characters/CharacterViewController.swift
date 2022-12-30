//
//  CharacterViewController.swift
//  RickAndMortyApp
//
//  Created by MacStud on 07.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit


class CharacterViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate{

    var characterViewModel = CharacterViewModel()
   
    @IBOutlet weak var collectView: UICollectionView!
    
    
    private func loadAllCharacters(){
        characterViewModel.getAllCharacters { [weak self] in
            self?.collectView.dataSource = self
            self?.collectView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllCharacters()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let filterView = segue.destination as? FilterViewController{
               filterView.characterViewModel = characterViewModel
           }
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterViewModel.getFilteredCharactersCount(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as!
        CharacterCollectionViewCell
        
        let index = characterViewModel.cellForRowAt(indexPath: indexPath)
        cell.imageView.contentMode = UIView.ContentMode.scaleAspectFill
        cell.imageView.downloadedFrom(link: index.image)
        cell.nameView.text = index.name.capitalized
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchV: UICollectionReusableView = collectView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "searchBar", for: indexPath)
        
        return searchV
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let realData = characterViewModel.getAllCharacters()
        
        characterViewModel.removeAllFilteredCharacters()
        
        for item in realData {
            if (item.name.lowercased().contains(searchBar.text!.lowercased())){
                characterViewModel.appendNewCharacter(newCharacter: item)
            }
        }
        
        if (searchBar.text!.isEmpty){
            characterViewModel.reloadFilteredCharacters(newCharacters: realData)
        }
        self.collectView.reloadData()
    }
   
}
