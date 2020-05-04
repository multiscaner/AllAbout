//
//  AddViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
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
		var personArray = UserDefaults.standard.stringArray(forKey: "personArray") ?? []
		personArray.append(nameTextField.text!)
		UserDefaults.standard.set(personArray, forKey: "personArray")
		let personArrayget: [String] = UserDefaults.standard.stringArray(forKey: "personArray") ?? []
		print(personArrayget)
		navigationController?.popViewController(animated: true)
		dismiss(animated: false, completion: nil)
	}
}
