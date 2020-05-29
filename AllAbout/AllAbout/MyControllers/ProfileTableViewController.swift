//
//  ProfileTableViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/24/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit
import AlamofireImage
import JGProgressHUD
import FirebaseAuth

enum PersonCell: Int, CaseIterable {
	case name
	case birthDate
	case height
	case weight
	case shoesSize
	case socksSize
}

class ProfileTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	let imagePickerController = UIImagePickerController()
	var person: Person!
	let hud = JGProgressHUD(style: .dark)
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var firstLetterLabel: UILabel!
	let personHelper = PersonHelper()
	var dateTextField: UITextField?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imagePickerController.delegate = self
		StyleHelper.makeRounded(image: image)
		StyleHelper.makeShadow(view: shadowView)
		
		if let imageUrlString = person.imageUrlString,
			let url = URL(string: imageUrlString) {
			image.af.setImage(withURL: url)
			firstLetterLabel.text = ""
		} else {
			person.image = nil
			firstLetterLabel.text = String(person.name.first!)
		}
	}
	@IBAction func choosePhoto(_ sender: UIButton) {
		imagePickerController.allowsEditing = false
		imagePickerController.sourceType = .photoLibrary
		present(imagePickerController, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			image.contentMode = .scaleAspectFill
			image.image = pickedImage
			person.image = pickedImage
			firstLetterLabel.text = ""
		}
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func savePerson(_ sender: Any) {
		view.endEditing(true)
		hud.show(in: self.view)
		personHelper.savePerson(person: person, completion: { success, error in
			self.hud.dismiss()
			if success {
				self.navigationController?.popViewController(animated: true)
			} else if let error = error {
				let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
				alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
				self.present(alert, animated: true, completion: nil)
			}
		})
	}
	
	@objc func handleDatePicker(sender: UIDatePicker) {
		person.birthDate = sender.date
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		dateTextField?.text = dateFormatter.string(from: sender.date)
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return PersonCell.allCases.count
	}
	
	// swiftlint:disable cyclomatic_complexity
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell else {
			return UITableViewCell()
		}
		cell.profileCellTextField.delegate = self
		cell.profileCellTextField.tag = indexPath.row
		cell.profileCellTextField.inputView = nil
		
		switch PersonCell(rawValue: indexPath.row) {
		case .name:
			cell.profileCellLabel.text = "Имя:"
			cell.profileCellTextField.text = person.name
			cell.profileCellTextField.keyboardType = .default
		case .birthDate:
			cell.profileCellTextField.inputView = datePicker
			cell.profileCellLabel.text = "Дата рождения:"
			dateTextField = cell.profileCellTextField
			if let birthDateString = person.birthDateString {
				cell.profileCellTextField.text = birthDateString
			}
		case .height:
			cell.profileCellLabel.text = "Рост:"
			if let height = person.height {
				cell.profileCellTextField.text = String(height)
			}
			cell.profileCellTextField.keyboardType = .numberPad
		case .weight:
			cell.profileCellLabel.text = "Вес:"
			if let weight = person.weight {
				cell.profileCellTextField.text = String(weight)
			}
			cell.profileCellTextField.keyboardType = .numberPad
		case .shoesSize:
			cell.profileCellLabel.text = "Обувь:"
			if let shoesSize = person.shoesSize {
				cell.profileCellTextField.text = String(shoesSize)
			}
			cell.profileCellTextField.keyboardType = .numberPad
		case .socksSize:
			cell.profileCellLabel.text = "Носки:"
			if let socksSize = person.socksSize {
				cell.profileCellTextField.text = String(socksSize)
			}
			cell.profileCellTextField.keyboardType = .numberPad
		default: break
		}
		return cell
	}
	
	var datePicker: UIDatePicker {
		let datePicker = UIDatePicker()
		datePicker.datePickerMode = .date
		datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
		return datePicker
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let text = textField.text else { return }
		switch PersonCell(rawValue: textField.tag) {
		case .name:
			person.name = text
		case .height:
			person.height = Int(text)
		case .weight:
			person.weight = Int(text)
		case .shoesSize:
			person.shoesSize = Int(text)
		case .socksSize:
			person.socksSize = Int(text)
		default: break
		}
	}
	
	@IBAction func deleteProfile(_ sender: UIButton) {
		let alert = UIAlertController(title: "Внимание!", message: "Вы действительно хотите удалить?", preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "Да", style: UIAlertAction.Style.default, handler: { (_ : UIAlertAction!) in
			self.hud.show(in: self.view)
			self.personHelper.deletePerson(person: self.person, completion: { success, error in
				self.hud.dismiss()
				if success {
					self.navigationController?.popViewController(animated: true)
				} else if let error = error {
					let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
					alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
					self.present(alert, animated: true, completion: nil)
				}
			})
		}))
		alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
