//
//  RegistrationViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/13/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import JGProgressHUD

class RegistrationViewController: UIViewController {
	
	let hud = JGProgressHUD(style: .dark)
	
	@IBOutlet weak var errorLabel: UILabel!
	@IBOutlet weak var eMailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpElements()
	}
	
	func setUpElements() {
		StyleHelper.createLine(textField: eMailTextField)
		StyleHelper.createLine(textField: passwordTextField)
		errorLabel.alpha = 0
		passwordTextField.disableAutoFill()
	}
	
	func validateFields() -> String? {
		if eMailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
			passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
			return "Заполните все поля"
		}
		
		let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		if Validator.isPasswordValid(pass: cleanedPassword) == false {
			return "Пароль должен содержать минимум 6 символов - буквы и цифры."
		}
		return nil
	}
	
	@IBAction func cancelSignUp(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func signUp(_ sender: UIButton) {
		let error = validateFields()
		if let error = error {
			showError(error)
		} else {
			
			let email = eMailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			hud.show(in: self.view)
			Auth.auth().createUser(withEmail: email, password: pass) { (_, error) in
				self.hud.dismiss()
				if let error = error {
					self.showError(error.localizedDescription)
				} else {
					let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
					let viewController = storyboard.instantiateViewController(withIdentifier: "Navigation")
					self.view.window?.rootViewController = viewController
					
				}
			}
		}
	}
	
	func showError (_ message: String) {
		errorLabel.text = message
		errorLabel.alpha = 1
	}
}
