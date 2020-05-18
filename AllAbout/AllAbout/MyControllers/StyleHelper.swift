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
	
	static func isPasswordValid(pass: String) -> Bool {
		let password = NSPredicate(format:
//			"SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z]\\d$@$#!%*?&]{8,}"
			"SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")
		return password.evaluate(with: pass)
	}
	
	static func createLine(textField: UITextField) {
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
		bottomLine.backgroundColor = UIColor(named: "MyGreen")?.cgColor
		textField.borderStyle = .none
		textField.layer.addSublayer(bottomLine)
	}
}
