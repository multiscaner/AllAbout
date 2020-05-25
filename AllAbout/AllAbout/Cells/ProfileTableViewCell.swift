//
//  ProfileTableViewCell.swift
//  AllAbout
//
//  Created by UjiN on 5/24/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
	
	@IBOutlet weak var profileCellTextField: UITextField!
	@IBOutlet weak var profileCellLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
