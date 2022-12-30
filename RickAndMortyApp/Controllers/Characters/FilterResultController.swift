//
//  FilterResultController.swift
//  RickAndMortyApp
//
//  Created by Vekshin Vladislav on 14.12.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit

class FilterResultController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var filterResultCollectionView: UICollectionView!

    var resultFilterViewModel: ResultFilterViewModel!

    private var filterResult = [CharacterResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        filterResultCollectionView.dataSource = self
        self.filterResult = resultFilterViewModel.resultFilterList()
        self.filterResultCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterResult.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! FilterResultCollectionViewCell

        cell.resultImageView.contentMode = .scaleAspectFill
        cell.resultImageView.downloadedFrom(link: filterResult[indexPath.row].image)

        cell.resultLbl.text = filterResult[indexPath.row].name.capitalized
        return cell
    }
}
