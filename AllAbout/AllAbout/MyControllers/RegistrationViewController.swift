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

class RegistrationViewController: UIViewController {
	
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
	@IBAction func cancelSignUp(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func signUp(_ sender: UIButton) {
		
		let error = validateFields()
		
		if error != nil {
			
			showError(error!)
		} else {
			
			let email = eMailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			let pass = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
			
			Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
				
				if err != nil {
					self.showError("Не могу создать юзера.")
				} else {
					let db = Firestore.firestore()
					db.collection("users").addDocument(data: ["uid": result!.user.uid]) { (error) in
						if error != nil {
							self.showError("Попробуйте попозже.")
						}
					}
					self.navigationController?.popViewController(animated: true)
					self.dismiss(animated: true, completion: nil)
				}
			}
		}
	}
	func showError (_ message: String) {
		
		errorLabel.text = message
		errorLabel.alpha = 1
	}
}
