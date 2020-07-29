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
}

class PersonEditViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
	
	func savePerson(_ sender: Any) {
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
		return PersonCell.allCases.count + person.userSizes.count
	}
	
	// swiftlint:disable cyclomatic_complexity
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell else {
			return UITableViewCell()
		}
		cell.profileCellTextField.delegate = self
		cell.profileCellTextField.tag = indexPath.row
		cell.profileCellTextField.inputView = nil
		
		let cellType = PersonCell(rawValue: indexPath.row)
		cell.MinusButton.tag = indexPath.row - PersonCell.allCases.count
		switch cellType {
		case .name:
			cell.MinusButton.isHidden = true
			cell.profileCellLabel.text = "Имя:"
			cell.profileCellTextField.text = person.name
			cell.profileCellTextField.keyboardType = .default
			cell.profileCellTextField.isEnabled = false
		case .birthDate:
			cell.MinusButton.isHidden = true
			cell.profileCellTextField.inputView = datePicker
			cell.profileCellLabel.text = "Дата рождения:"
			dateTextField = cell.profileCellTextField
			if let birthDateString = person.birthDateString {
				cell.profileCellTextField.text = birthDateString
			}
			cell.profileCellTextField.isEnabled = false
		default:
			let userSize = person.userSizes[indexPath.row - PersonCell.allCases.count]
			cell.profileCellLabel.text = userSize.name
			cell.profileCellTextField.text = userSize.value
			cell.profileCellTextField.keyboardType = .default
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
		let cellType = PersonCell(rawValue: textField.tag)
		switch cellType {
		case .name:
			person.name = text
		case .birthDate:
			break
		default:
			let userSize = person.userSizes[textField.tag - PersonCell.allCases.count]
			userSize.value = text
			tableView.reloadData()
			personHelper.savePerson(person: self.person) { (result, error) in
			}
		}
	}
	
	@IBAction func addCell(_ sender: UIButton) {
		let alertController = UIAlertController(title: "Добавьте", message: "Новый параметр", preferredStyle: UIAlertController.Style.alert)
		alertController.addTextField { (textField) in
			textField.placeholder = ""
			alertController.addAction(UIAlertAction(title: "da", style: .default, handler: { (_ : UIAlertAction!) in
				guard let text = textField.text else { return }
				self.person.addUserSize(name: text)
				self.tableView.reloadData()
				self.personHelper.savePerson(person: self.person) { (result, error) in
				}
			}))
		}
		self.present(alertController, animated: true, completion: nil)
	}
	
	@IBAction func deleteProfile(_ sender: UIButton) {
		let alert = UIAlertController(title: "Внимание!", message: "Вы действительно хотите удалить все данные \(person.name)?", preferredStyle: UIAlertController.Style.alert)
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
	
	@IBAction func deleteRow(_ sender: UIButton) {
		let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in",         preferredStyle: UIAlertController.Style.alert)
		
		alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
			//Cancel Action
		}))
		alert.addAction(UIAlertAction(title: "Sign out",
									  style: UIAlertAction.Style.default,
									  handler: {(_: UIAlertAction!) in
										self.person.removeUserSize(index: sender.tag)
										self.tableView.reloadData()
										self.personHelper.savePerson(person: self.person) { (result, error) in
										}
		}))
        self.present(alert, animated: true, completion: nil)
		tableView.reloadData()
		self.personHelper.savePerson(person: self.person) { (result, error) in
		}
	}
}
