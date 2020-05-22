//
//  MainViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class PersonTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	var persons: [Person]?
	let personHelper = PersonHelper()
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var table: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		personHelper.readPersons { (persons) in
			self.persons = persons
			self.tableView.reloadData()
		}
		
	}
	override func viewWillAppear(_ animated: Bool) {
		table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0;//Choose your custom row height
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return persons?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let person = persons?[indexPath.row] else {
			return UITableViewCell()
		}
		if let image = person.image,
			let cell = tableView.dequeueReusableCell(withIdentifier: "personImageCell", for: indexPath) as? PersonImageViewCell {
			cell.personImage.image = image
			return cell
		} else if let cell = tableView.dequeueReusableCell(withIdentifier: "personLabelCell", for: indexPath) as? LabelTableViewCell {
			cell.nameLabel.text = person.name
			return cell
		}
		return UITableViewCell()
	}
}
