//
//  MainViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	let personHelper = PersonHelper()
	
	@IBOutlet weak var table: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	override func viewWillAppear(_ animated: Bool) {
		table.reloadData()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200.0;//Choose your custom row height
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let result = personHelper.readPersons()
		return result.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let persons = personHelper.readPersons()
		let person = persons[indexPath.row]
		if let imageData = person.imageData,
			let cell = tableView.dequeueReusableCell(withIdentifier: "personImageCell", for: indexPath) as? PersonImageViewCell {
			cell.personImage.image = UIImage(data: imageData)
			return cell
		} else if let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell {
			cell.firstLetterLabel.text = person.name
			return cell
		}
		return UITableViewCell()
	}
}
