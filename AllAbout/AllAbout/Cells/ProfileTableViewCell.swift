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
	@IBOutlet weak var MinusButton: UIButton!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		StyleHelper.createLine(textField: profileCellTextField)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
