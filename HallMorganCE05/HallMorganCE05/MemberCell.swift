//
//  MemberCell.swift
//  HallMorganCE05
//
//  Created by Morgan Hall on 11/7/21.
//  Modified by Morgan Hall on 12/5/21.

import UIKit

class MemberCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var partyState: UILabel!
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
