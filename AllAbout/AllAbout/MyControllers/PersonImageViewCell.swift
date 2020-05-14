//
//  PersonImageViewCell.swift
//  AllAbout
//
//  Created by UjiN on 5/13/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class PersonImageViewCell: UITableViewCell {

	@IBOutlet weak var personImage: UIImageView!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
