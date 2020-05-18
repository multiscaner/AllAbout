//
//  ViewController.swift
//  AllAbout
//
//  Created by UjiN on 3/12/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {
	
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var eMailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpElements()
		errorLabel.alpha = 0
		
	}
	@IBAction func toComeIn(_ sender: UIButton) {
		
		let error = validateFields()
		
		if error != nil {
			
			showError(error!)
		} else {
			
			let email = eMailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			
			Auth.auth().signIn(withEmail: email, password: pass) { (_, error) in
				if let error = error {
					self.showError(error.localizedDescription)
				} else {
					self.performSegue(withIdentifier: "personTableSegue", sender: nil)
				}
			}
		}
	}
	func setUpElements() {
		
		StyleHelper.createLine(textField: eMailTextField)
		StyleHelper.createLine(textField: passwordTextField)
		
	}
	
	func validateFields() -> String? {
		
		if eMailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
			
			return "Заполните все поля"
		}
		
		let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		
		if StyleHelper.isPasswordValid(pass: cleanedPassword) == false {
			return "Пароль должен содержать буквы и цифры."
		}
		
		return nil
	}
	
	func showError (_ message: String) {
		
		errorLabel.text = message
		errorLabel.alpha = 1
	}
	
}
