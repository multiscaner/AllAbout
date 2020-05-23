//
//  Validator.swift
//  AllAbout
//
//  Created by UjiN on 5/23/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation

class Validator {
	static func isPasswordValid(pass: String) -> Bool {
		let password = NSPredicate(format:
			"SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")
		return password.evaluate(with: pass)
	}
}
