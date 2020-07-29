//
//  ParameterCell.swift
//  AllAbout
//
//  Created by UjiN on 7/29/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class ParameterCell: UITableViewCell {

	@IBOutlet weak var parameterNameLabel: UILabel!
	@IBOutlet weak var parameterValueLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
