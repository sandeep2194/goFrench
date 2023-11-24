//
//  ThirdViewController.swift
//  GoFrench
//
//  Created by xi gao on 2023-11-22.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var btnPopType: UIButton!
    
    @IBOutlet weak var btnPopTense: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpButtonType()
        btnPopTense.isEnabled = false
        //setPopUpButtonTense()
        // Do any additional setup after loading the view.
       
    }
    func setPopUpButtonType(){
        let optionClosure = { [weak self] (action: UIAction) in
                    guard let self = self else { return }
                    print(action.title)

                    // Update the menu for the second button based on the selection of the first button
                    self.updatePopUpButtonTenseMenu(conjugationType: action.title)
                }
            
        btnPopType.menu = UIMenu(children: [
            UIAction(title: Segue.infinitive, state: .on, handler: optionClosure),
            UIAction(title: Segue.participe, state: .on, handler: optionClosure),
            UIAction(title: Segue.indicatif, state: .on, handler: optionClosure),
            UIAction(title: Segue.subjonctif, state: .on, handler: optionClosure),
            UIAction(title: Segue.conditionnel, state: .on, handler: optionClosure),
            UIAction(title: Segue.imperatif, state: .on, handler: optionClosure),
        ])
    }
    func setPopUpButtonTense() {
            // Initial setup for the second button
            btnPopTense.menu = UIMenu(children: [])
    }
    func updatePopUpButtonTenseMenu(conjugationType: String?) {
        if(conjugationType==nil){
            return;
        }
        // Clear the existing menu for the second button
        // Create a new menu based on the selected conjugation type
        switch conjugationType {
        case Segue.indicatif:
            btnPopTense.menu = createTenseMenu(tenses: [
                Segue.present, Segue.passeSimple, Segue.imparfait,
                Segue.passeCompose, Segue.futurSimple, Segue.passeAnterieur,
                Segue.plusQueParfait, Segue.futurAnterieur
            ])
            btnPopTense.isEnabled = true

        case Segue.participe:
            btnPopTense.menu = createTenseMenu(tenses: [
                Segue.present, Segue.passe
            ])
            btnPopTense.isEnabled = true

        case Segue.infinitive:
            btnPopTense.menu = createTenseMenu(tenses: [
                Segue.present, Segue.passe
            ])
            btnPopTense.isEnabled = true

        case Segue.imperatif:
            btnPopTense.menu = createTenseMenu(tenses: [
                Segue.present, Segue.passe
            ])
            btnPopTense.isEnabled = true

        case Segue.subjonctif:
            btnPopTense.menu = createTenseMenu(tenses: [
                Segue.present, Segue.passe, Segue.imparfait, Segue.plusQueParfait
            ])
            btnPopTense.isEnabled = true

        case Segue.conditionnel:
            btnPopTense.menu = createTenseMenu(tenses: [
                Segue.present, Segue.passe1reForme, Segue.passe2eForme
            ])
            btnPopTense.isEnabled = true

        default:
            btnPopTense.isEnabled = false
            break
        }
    }

    func createTenseMenu(tenses: [String]) -> UIMenu {
        // Create a menu based on the provided tenses
        let tenseOptions: [UIAction] = tenses.map { tense in
            return UIAction(title: tense, state: .on, handler: tenseOptionClosure)
        }

        return UIMenu(children: tenseOptions)
    }

    func tenseOptionClosure(action: UIAction) {
        print(action.title)
    }
    
    
    @IBAction func btnPopTypeValueChanged(_ sender: Any) {
        //todo test 01
                
    }
    
    @IBAction func btnPopTenseValueChanged(_ sender: Any) {
        //todo
    }
    
    


}
