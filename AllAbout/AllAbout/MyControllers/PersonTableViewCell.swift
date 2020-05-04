//
//  PersonTableViewCell.swift
//  AllAbout
//
//  Created by UjiN on 5/3/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

	@IBOutlet weak var firstLetterLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
