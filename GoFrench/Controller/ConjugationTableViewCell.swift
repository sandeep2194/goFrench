//
//  ConjugationTableViewCell.swift
//  GoFrench
//
//  Created by xi gao on 2023-11-22.
//

import UIKit

class ConjugationTableViewCell: UITableViewCell {
    private var conjugation: Conjugation?;

    @IBOutlet weak var lblConjugatedForm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setCellContent(conjugation: Conjugation){
        self.conjugation = conjugation;
        
        lblConjugatedForm.text = conjugation.conjugatedForm;
        
        
    }
    
}
