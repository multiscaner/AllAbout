//
//  PersonImageViewCell.swift
//  AllAbout
//
//  Created by UjiN on 5/13/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class PersonImageViewCell: UITableViewCell {
	
	@IBOutlet weak var firstLetterLabel: UILabel!
	@IBOutlet weak var personImage: UIImageView!
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		StyleHelper.makeShadow(view: shadowView)
		StyleHelper.makeRounded(image: personImage)
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}
