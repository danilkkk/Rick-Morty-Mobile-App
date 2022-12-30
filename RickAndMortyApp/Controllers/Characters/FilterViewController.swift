//
//  FilterViewController.swift
//  RickAndMortyApp
//
//  Created by MacStud on 16.11.2022.
//  Copyright © 2022 MacStud. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {  
    
    @IBOutlet weak var btnAlive: UIButton!
    @IBOutlet weak var btnDead: UIButton!
    @IBOutlet weak var btnStatusUnknown: UIButton!
    
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnGenderless: UIButton!
    @IBOutlet weak var btnGenderUnknown: UIButton!
    
    
    let radioButton1: RadioButton = RadioButton()
    let radioButton2: RadioButton = RadioButton()
    var characterViewModel: CharacterViewModel!
    
    var resultFilterViewModel = ResultFilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButton1.buttonsArray = [btnAlive, btnDead, btnStatusUnknown]
        radioButton2.buttonsArray = [btnFemale, btnMale, btnGenderless, btnGenderUnknown]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let resultView = segue.destination as? FilterResultController {
               resultView.resultFilterViewModel = resultFilterViewModel
           }
       }
    
    @IBAction func btnAliveAction(_ sender: UIButton) {
        radioButton1.buttonArrayUpdated(buttonSelected: sender)
    }    
    
    @IBAction func btnDeadAction(_ sender: UIButton) {
        radioButton1.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func btnStatusUnknownAction(_ sender: UIButton) {
        radioButton1.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func ResetBotton(_ sender: UIButton) {
        radioButton1.buttonArrayDelete(buttonSelected: sender)
    }
    
    @IBAction func Reset2Botton(_ sender: UIButton) {
        radioButton2.buttonArrayDelete(buttonSelected: sender)
    }
    
    @IBAction func btnFemaleAction(_ sender: UIButton) {
        radioButton2.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func btnMaleAction(_ sender: UIButton) {
        radioButton2.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func btnGenderlessAction(_ sender: UIButton) {
        radioButton2.buttonArrayUpdated(buttonSelected: sender)
    }
    
    @IBAction func btnGenderUnknownAction(_ sender: UIButton) {
        radioButton2.buttonArrayUpdated(buttonSelected: sender)
    }
    
    func filterButton() -> [CharacterResult] {
        var status: String?
        var gender: String?
        let dictStatus: Dictionary<String,String> = [
            "btnAlive": "Alive",
            "btnDead": "Dead",
            "btnUnknownS": "Unknown"
        ]
        
        let dictGender: Dictionary<String, String> = [
            "btnMale": "Male",
            "btnFemale": "Female",
            "btnUnknownG": "Unknown",
            "btnGenderless": "Genderless"
        ]
        
        for button in radioButton1.buttonsArray {
            if button.isSelected {
                status = dictStatus[button.restorationIdentifier!]
            }
        }
        
        for button in radioButton2.buttonsArray {
            if button.isSelected {
                gender = dictGender[button.restorationIdentifier!]
            }
        }
        
        let list = characterViewModel.getFilteredCharacters()
        
        if status == nil && gender == nil{
            return list
        }
        
        var filterCharacters = [CharacterResult]()
        
        for chr in list {
            if status == chr.status && gender == nil {
                filterCharacters.append(chr)
            } else if gender == chr.gender && status == nil {
                filterCharacters.append(chr)
            } else if gender == chr.gender && status == chr.status {
                filterCharacters.append(chr)
            }
        }
        
        return filterCharacters
    }
   
        
    @IBAction func applyFilters(_ sender: Any){
        let characters = filterButton()
        resultFilterViewModel.reloadResultFilter(newResult: characters)
        dismiss(animated: true, completion: nil)        
    }
    
}
