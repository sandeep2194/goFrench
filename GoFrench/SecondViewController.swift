//
//  SecondViewController.swift
//  GoFrench
//
//  Created by xi gao on 2023-11-13.
//

import UIKit

class SecondViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var txtWord: UITextField!
    
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var txtWordVerbType: UITextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //todo
    }
    @IBAction func btnConjugate(_ sender: UIButton) {
        //todo
    }

}
