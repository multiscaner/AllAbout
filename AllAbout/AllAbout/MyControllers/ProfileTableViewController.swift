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

class ProfileTableViewController: UITableViewController {
	var person: Person!
	let hud = JGProgressHUD(style: .dark)
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var firstLetterLabel: UILabel!
	
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
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	// swiftlint:disable cyclomatic_complexity
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell else {
			return UITableViewCell()
		}
		
		switch indexPath.row {
		case 0:
			cell.profileCellLabel.text = "Имя:"
			cell.profileCellTextField.text = person.name
		case 1:
			cell.profileCellLabel.text = "Дата рождения:"
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd MMM yyyy"
			cell.profileCellTextField.text = dateFormatter.string(from: person.birthDate)
		case 2:
			cell.profileCellLabel.text = "Рост:"
			if let height = person.height {
				cell.profileCellTextField.text = String(height)
			}
		case 3:
			cell.profileCellLabel.text = "Вес:"
			if let weight = person.weight {
				cell.profileCellTextField.text = String(weight)
			}
		case 4:
			cell.profileCellLabel.text = "Обувь:"
			if let shoesSize = person.shoesSize {
				cell.profileCellTextField.text = String(shoesSize)
			}
		case 5:
			cell.profileCellLabel.text = "Носки:"
			if let socksSize = person.socksSize {
				cell.profileCellTextField.text = String(socksSize)
			}
		default: break
		}
		return cell
	}
}
