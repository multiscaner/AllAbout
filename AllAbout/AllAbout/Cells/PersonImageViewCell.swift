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
	@IBOutlet weak var shadowView: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		shadowView.makeShadow()
			personImage.makeRounded()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		
	}

}
extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 3
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor(named: "MyGreen")?.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

extension UIView {
	
	func makeShadow() {
		self.layer.cornerRadius = self.frame.height / 2
		self.layer.shadowColor = UIColor.darkGray.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 0)
		self.layer.shadowRadius = 5
		self.layer.shadowOpacity = 1
	}
}
