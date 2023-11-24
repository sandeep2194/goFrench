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
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conjugations.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conjugationTableViewCell", for: indexPath) as! ConjugationTableViewCell;
        
        cell.setCellContent(conjugation: conjugations[indexPath.row])
        
        return cell;
        
    }
    
    @IBAction func btnPopTypeValueChanged(_ sender: Any) {
        //todo
    }
    
    @IBAction func btnPopTenseValueChanged(_ sender: Any) {
        //todo
    }
    
}
