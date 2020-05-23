//
//  MainViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit
import AlamofireImage
import JGProgressHUD

class PersonTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	let hud = JGProgressHUD(style: .dark)
	var persons: [Person]?
	let personHelper = PersonHelper()
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var table: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		hud.show(in: self.view)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		personHelper.readPersons { (persons, error) in
			
			if let error = error {
				let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
				alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: nil))
				self.present(alert, animated: true, completion: nil)
			} else {
				self.persons = persons
				self.tableView.reloadData()
			}
			self.hud.dismiss()
		}
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return persons?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let person = persons?[indexPath.row] else {
			return UITableViewCell()
		}
		if let imageUrlString = person.imageUrlString,
			let url = URL(string: imageUrlString),
			let cell = tableView.dequeueReusableCell(withIdentifier: "personImageCell", for: indexPath) as? PersonImageViewCell {
			cell.personImage.af.setImage(withURL: url)
			return cell
		} else if let cell = tableView.dequeueReusableCell(withIdentifier: "personLabelCell", for: indexPath) as? LabelTableViewCell {
			cell.nameLabel.text = person.name
			return cell
		}
		return UITableViewCell()
	}
}
