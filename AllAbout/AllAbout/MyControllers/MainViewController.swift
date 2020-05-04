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
		let name = UserDefaults.standard.string(forKey: "name")
		if  name != nil {
			return 1
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let name = UserDefaults.standard.string(forKey: "name")
		if let name = name,
			let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? PersonTableViewCell, let oneLetter = name.first {
			cell.firstLetterLabel.text = String(oneLetter)
			return cell
		} else {
			return UITableViewCell()
		}
	}
}
