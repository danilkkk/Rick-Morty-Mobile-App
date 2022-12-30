//
//  LocationViewController.swift
//  RickAndMortyApp
//
//  Created by Vekshin Vladislav on 20.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    private var locationViewModel = LocationViewModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    private func loadAllLocations() {
        locationViewModel.getAllLocations { [weak self] in
            self?.collectionView.dataSource = self
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllLocations()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationViewModel.getLocationsCount(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as! LocationCollectionViewCell
        
        let index = locationViewModel.cellForRowAt(indexPath: indexPath)
        
        cell.nameLbl.text = index.name.capitalized
        cell.typeLbl.text = index.type.capitalized
        cell.dimensionLbl.text = index.dimension.capitalized
        return cell
    }
}
