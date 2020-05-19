//
//  AddViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class AddNewPersonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var personImage: UIImage?
	
	let personHelper = PersonHelper()
	
	@IBOutlet weak var photoImageView: UIImageView!
	
	@IBOutlet weak var nameTextField: UITextField!
	
	let imagePickerController = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePickerController.delegate = self
		
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
		personHelper.savePerson(person: Person(name: personName, image: personImage))
		self.navigationController?.popViewController(animated: true)
		self.dismiss(animated: true, completion: nil)
	}

}
