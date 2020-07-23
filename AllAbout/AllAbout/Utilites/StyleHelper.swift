//
//  StyleHelper.swift
//  AllAbout
//
//  Created by UjiN on 5/16/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import UIKit

class StyleHelper {
	
	static func createLine(textField: UITextField) {
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 1)
		bottomLine.backgroundColor = UIColor(named: "MyGreen")?.cgColor
		textField.borderStyle = .none
		textField.layer.addSublayer(bottomLine)
	}
	
	static 	func makeRounded(image: UIImageView) {
		image.layer.borderWidth = 3
		image.layer.masksToBounds = false
		image.layer.borderColor = UIColor(named: "MyPink")?.cgColor
		image.layer.cornerRadius = image.frame.height / 2
		image.clipsToBounds = true
	}
	
	static 	func makeShadow(view: UIView) {
		view.layer.cornerRadius = view.frame.height / 2
		view.layer.shadowColor = UIColor.systemGray.cgColor
		view.layer.shadowOffset = CGSize(width: 0, height: 0)
		view.layer.shadowRadius = 10
		view.layer.shadowOpacity = 1
	}
}
