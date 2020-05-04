//
//  MainViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
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
		let personArray: [String] = UserDefaults.standard.stringArray(forKey: "personArray") ?? []
		if  personArray.isEmpty {
			return 0
		} else {
			return personArray.count
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let personArray = UserDefaults.standard.stringArray(forKey: "personArray") {
			let name = personArray[indexPath.row]
			if let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell {
				cell.firstLetterLabel.text = String(name)
				return cell
			}
		}
		return UITableViewCell()
	}
}
