//
//  ViewController.swift
//  AllAbout
//
//  Created by UjiN on 3/12/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LoginController: UIViewController {
	
	let hud = JGProgressHUD(style: .dark)
	
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var eMailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpElements()
		errorLabel.alpha = 0
		passwordTextField.disableAutoFill()
	}
	
	@IBAction func toComeIn(_ sender: UIButton) {

		let error = validateFields()
		
		if error != nil {
			
			showError(error!)
		} else {
			
			let email = eMailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			hud.show(in: self.view)
			Auth.auth().signIn(withEmail: email, password: pass) { (_, error) in
				self.hud.dismiss()
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
		
		if Validator.isPasswordValid(pass: cleanedPassword) == false {
			return "Пароль должен содержать буквы и цифры."
		}
		
		return nil
	}
	
	func showError (_ message: String) {
		
		errorLabel.text = message
		errorLabel.alpha = 1
	}
	
}
