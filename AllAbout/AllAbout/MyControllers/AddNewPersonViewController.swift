//
//  AddViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit
import JGProgressHUD

class AddNewPersonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	let hud = JGProgressHUD(style: .dark)
	var personImage: UIImage?
	let personHelper = PersonHelper()
	let imagePickerController = UIImagePickerController()
	@IBOutlet weak var photoImageView: UIImageView!
	@IBOutlet weak var dateTextField: UITextField!
	@IBOutlet weak var nameTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imagePickerController.delegate = self
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
		dateTextField.inputView = datePicker
	}
	
	@objc func handleDatePicker(sender: UIDatePicker) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		dateTextField.text = dateFormatter.string(from: sender.date)
	}
		
	@IBAction func choosePhoto(_ sender: UIButton) {
		imagePickerController.allowsEditing = false
		imagePickerController.sourceType = .photoLibrary
		present(imagePickerController, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			photoImageView.contentMode = .scaleAspectFill
			photoImageView.image = pickedImage
			personImage = pickedImage
		}
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func cancelAddPerson(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func savePerson(_ sender: UIButton) {
		guard let personName = nameTextField.text, !personName.isEmpty else {
			let alert = UIAlertController(title: "Введите", message: "Имя", preferredStyle: UIAlertController.Style.alert)
			alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			return
		}
		
		guard let personDate = dateTextField.text, !personDate.isEmpty else {
			let alert = UIAlertController(title: "Введите", message: "Дату", preferredStyle: UIAlertController.Style.alert)
			alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			return
		}
		
		let person = Person(name: personName, image: personImage, date: personDate)
		hud.show(in: self.view)
		personHelper.savePerson(person: person, completion: { success, error in
			self.hud.dismiss()
			if success {
				self.dismiss(animated: true, completion: nil)
			} else if let error = error {
				let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
				alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
				self.present(alert, animated: true, completion: nil)
			}
		})
	}
}
