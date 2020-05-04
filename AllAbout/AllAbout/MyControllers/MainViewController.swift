//
//  MainViewController.swift
//  AllAbout
//
//  Created by UjiN on 5/1/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		let personArray = UserDefaults.standard.stringArray(forKey: "personArray")
		let name = personArray![indexPath.row]
		let firstLetter = name.first
		let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell
		cell?.firstLetterLabel.text = String(firstLetter!)
		return cell!
	}
}
