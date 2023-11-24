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

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    func initialize(){
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.register(UINib(nibName: "ConjugationTableViewCell", bundle: nil), forCellReuseIdentifier: "conjugationTableViewCell")

        btnPopTense.isEnabled = false
        setPopUpButtonType()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conjugations.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conjugationTableViewCell", for: indexPath) as! ConjugationTableViewCell;
        
        cell.setCellContent(conjugation: conjugations[indexPath.row])
        
        return cell;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93;
    }

    func setPopUpButtonType(){
        let optionClosure = { [weak self] (action: UIAction) in
                    guard let self = self else { return }
                    print(action.title)

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
        // Clear the existing menu for the second button
        // Create a new menu based on the selected conjugation type
        switch conjugationType {
        case ConjugationType.indicatif:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passeSimple, ConjugationTense.imparfait,
                ConjugationTense.passeCompose, ConjugationTense.futurSimple, ConjugationTense.passeAnterieur,
                ConjugationTense.plusQueParfait, ConjugationTense.futurAnterieur
            ])
            btnPopTense.isEnabled = true

        case ConjugationType.participe:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe
            ])
            btnPopTense.isEnabled = true

        case ConjugationType.infinitive:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe
            ])
            btnPopTense.isEnabled = true

        case ConjugationType.imperatif:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe
            ])
            btnPopTense.isEnabled = true

        case ConjugationType.subjonctif:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe, ConjugationTense.imparfait, ConjugationTense.plusQueParfait
            ])
            btnPopTense.isEnabled = true

        case ConjugationType.conditionnel:
            btnPopTense.menu = createTenseMenu(tenses: [
                ConjugationTense.present, ConjugationTense.passe1reForme, ConjugationTense.passe2eForme
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
        //todo
    }
    
    @IBAction func btnPopTenseValueChanged(_ sender: Any) {
        //todo
    }
    
}
