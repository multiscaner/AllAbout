//
//  AddViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	let personHelper = PersonHelper()
	
	@IBOutlet weak var photoPlace: UIImageView!
	
	@IBOutlet weak var nameTextField: UITextField!
	
	let imagePicker = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePicker.delegate = self
		
	}
	@IBAction func choosePhoto(_ sender: UIButton) {
		imagePicker.allowsEditing = false
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)
	}
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			photoPlace.contentMode = .scaleAspectFill
			photoPlace.image = pickedImage
		}
		
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveName(_ sender: UIButton) {
		guard let personName = nameTextField.text, !personName.isEmpty else {
			let alert = UIAlertController(title: "Введите", message: "Имя", preferredStyle: UIAlertController.Style.alert)
			alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			return
		}
		personHelper.savePerson(person: Person(name: personName))
		navigationController?.popViewController(animated: false)
	}
}
