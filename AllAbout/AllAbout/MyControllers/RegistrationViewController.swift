//
//  RegistrationViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/13/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
	@IBOutlet weak var eMailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		createLine(textField: eMailTextField)
		createLine(textField: passwordTextField)

    }
	
	@IBAction func signUp(_ sender: UIButton) {
		
	}
	
	func createLine(textField: UITextField) {
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
		bottomLine.backgroundColor = UIColor(named: "MyGreen")?.cgColor
		textField.borderStyle = .none
		textField.layer.addSublayer(bottomLine)
	}
}
