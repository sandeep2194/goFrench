//
//  ThirdViewController.swift
//  GoFrench
//
//  Created by xi gao on 2023-11-22.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var btnPopType: UIButton!
    
    @IBOutlet weak var btnPopTense: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var conjugations = [Conjugation]()
    var filteredConjugations = [Conjugation]()
    var currentConjugationType: String?
    var currentConjugationTense: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    func initialize(){
        filteredConjugations = conjugations  // Show all initially
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.register(UINib(nibName: "ConjugationTableViewCell", bundle: nil), forCellReuseIdentifier: "conjugationTableViewCell")

        setPopUpButtonType()
        updatePopUpButtonTenseMenu(conjugationType: ConjugationType.indicatif)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredConjugations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conjugationTableViewCell", for: indexPath) as! ConjugationTableViewCell;
        
        cell.setCellContent(conjugation: filteredConjugations[indexPath.row])
        
        return cell;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93;
    }

    func setPopUpButtonType(){
        let optionClosure = { [weak self] (action: UIAction) in
                    guard let self = self else { return }
                    // Update the menu for the second button based on the selection of the first button
                    self.updatePopUpButtonTenseMenu(conjugationType: action.title)
                }
            
        btnPopType.menu = UIMenu(children: [
            UIAction(title: ConjugationType.infinitive, state: .on, handler: optionClosure),
            UIAction(title: ConjugationType.participe, state: .on, handler: optionClosure),
            UIAction(title: ConjugationType.indicatif, state: .on, handler: optionClosure),
            UIAction(title: ConjugationType.subjonctif, state: .on, handler: optionClosure),
            UIAction(title: ConjugationType.conditionnel, state: .on, handler: optionClosure),
            UIAction(title: ConjugationType.imperatif, state: .on, handler: optionClosure),
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
        
        currentConjugationType = conjugationType

        // Create a new menu based on the selected conjugation type
        switch conjugationType {
        case ConjugationType.indicatif:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passeSimple, ConjugationTense.imparfait,
                ConjugationTense.passeCompose, ConjugationTense.futurSimple, ConjugationTense.passeAnterieur,
                ConjugationTense.plusQueParfait, ConjugationTense.futurAnterieur
            ])
            btnPopTense.isEnabled = true
            currentConjugationTense = ConjugationTense.present;
            filterConjugations()

        case ConjugationType.participe:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe
            ])
            btnPopTense.isEnabled = true
            currentConjugationTense = ConjugationTense.present;
            filterConjugations()

        case ConjugationType.infinitive:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe
            ])
            btnPopTense.isEnabled = true
            currentConjugationTense = ConjugationTense.present;
            filterConjugations()

        case ConjugationType.imperatif:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe
            ])
            btnPopTense.isEnabled = true
            currentConjugationTense = ConjugationTense.present;
            filterConjugations()

        case ConjugationType.subjonctif:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe, ConjugationTense.imparfait, ConjugationTense.plusQueParfait
            ])
            btnPopTense.isEnabled = true
            currentConjugationTense = ConjugationTense.present;
            filterConjugations()

        case ConjugationType.conditionnel:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe1reForme, ConjugationTense.passe2eForme
            ])
            btnPopTense.isEnabled = true
            currentConjugationTense = ConjugationTense.present;
            filterConjugations()

        default:
            btnPopTense.isEnabled = false
            currentConjugationTense = ConjugationTense.present;
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
        currentConjugationTense = action.title
        filterConjugations()
    }

    func filterConjugations() {
        if let type = currentConjugationType, let tense = currentConjugationTense {
            filteredConjugations = conjugations.filter { conjugation in
                return conjugation.type.lowercased() == type.lowercased() && conjugation.tense.lowercased() == tense.lowercased()
            }
        tableView.reloadData()
        } else {
            // show toast
        }
    }
   
    @IBAction func btnPopTenseValueChanged(_ sender: Any) {
        filterConjugations()
    }
    
    
}
