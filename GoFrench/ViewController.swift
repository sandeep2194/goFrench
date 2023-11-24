//
//  ViewController.swift
//  GoFrench
//
//  Created by Lingfang He on 2023-11-06.
//

import UIKit

class ViewController: UIViewController {

    
    var conjugationService = ConjugationService()
    var conjugations: [ConjugationObject] = []
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // fetchConjugationData()
    }
    
//    func fetchConjugationData() {
//            conjugationService.fetchConjugationData { [weak self] result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .some(let conjugationData):
//                        self?.conjugations = conjugationData
//                        self?.displayConjugations()
//                    case .none:
//                        print("Failed to fetch conjugation data")
//                    }
//                }
//            }
//        }
//
//        func displayConjugations() {
//            // Update your UI with the conjugations
//            // This is just an example. You might be updating a table view or other components.
//            for conjugation in conjugations {
//                //print("\(conjugation.type) - \(conjugation.tense) - \(conjugation.subject): \(conjugation.word)")
//            }
//        }

}

