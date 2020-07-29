//
//  PersonDetailsViewController.swift
//  AllAbout
//
//  Created by UjiN on 7/21/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var tableView: UITableView!
	var person: Person!
	let personHelper = PersonHelper()
	
	override func viewWillAppear(_ animated: Bool) {
		personHelper.readPerson(id: person.id!) { (person, error) in
			if let person = person {
				self.person = person
			}
			self.tableView.reloadData()
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let profileViewController = segue.destination as? PersonEditViewController {
			profileViewController.person = person
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return person.userSizes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "parameterCell", for: indexPath) as? ParameterCell else {
				return UITableViewCell()
		}
		let userSize = person.userSizes[indexPath.row]
		cell.parameterNameLabel.text = userSize.name
		cell.parameterValueLabel.text = userSize.value
		return cell
	}
}
