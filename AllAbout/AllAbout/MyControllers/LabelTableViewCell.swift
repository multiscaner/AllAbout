//
//  LabelTableViewCell.swift
//  AllAbout
//
//  Created by UjiN on 5/14/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {
	
	@IBOutlet weak var personImage: UIImageView!
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var nameLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		shadowView.makeShadow()
		personImage.makeRounded()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
	}
}
