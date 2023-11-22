//
//  ConjugationTableViewCell.swift
//  GoFrench
//
//  Created by xi gao on 2023-11-22.
//

import UIKit

class ConjugationTableViewCell: UITableViewCell {
    

    @IBOutlet weak var LblWordType: UILabel!
    
    @IBOutlet weak var LblWordTense: UILabel!
    
    @IBOutlet weak var LblSubject: UILabel!
    
    @IBOutlet weak var lblSelectedWordConjugation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
