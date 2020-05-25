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

enum PersonCell: Int {
	case name
	case birthDate
	case height
	case weight
	case shoesSize
	case socksSize
}

class ProfileTableViewController: UITableViewController, UITextFieldDelegate {
	var person: Person!
	let hud = JGProgressHUD(style: .dark)
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var firstLetterLabel: UILabel!
	let personHelper = PersonHelper()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		StyleHelper.makeRounded(image: image)
		StyleHelper.makeShadow(view: shadowView)
		
		if let imageUrlString = person.imageUrlString,
			let url = URL(string: imageUrlString) {
			image.af.setImage(withURL: url)
			firstLetterLabel.text = ""
		} else {
			firstLetterLabel.text = String(person.name.first!)
		}
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
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	// swiftlint:disable cyclomatic_complexity
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell else {
			return UITableViewCell()
		}
		
		cell.profileCellTextField.delegate = self
		cell.profileCellTextField.tag = indexPath.row
		
		switch PersonCell(rawValue: indexPath.row) {
		case .name:
			cell.profileCellLabel.text = "Имя:"
			cell.profileCellTextField.text = person.name
			cell.profileCellTextField.keyboardType = .default
		case .birthDate:
			cell.profileCellLabel.text = "Дата рождения:"
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd MMM yyyy"
			cell.profileCellTextField.text = dateFormatter.string(from: person.birthDate)
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
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let text = textField.text else { return }
		switch PersonCell(rawValue: textField.tag) {
		case .name:
			person.name = text
		case .birthDate:
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd MMM yyyy"
			person.birthDate = dateFormatter.date(from: text) ?? Date()
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
}
