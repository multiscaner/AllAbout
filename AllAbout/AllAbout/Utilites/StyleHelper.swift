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
		bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
		bottomLine.backgroundColor = UIColor(named: "MyGreen")?.cgColor
		textField.borderStyle = .none
		textField.layer.addSublayer(bottomLine)
	}
}
