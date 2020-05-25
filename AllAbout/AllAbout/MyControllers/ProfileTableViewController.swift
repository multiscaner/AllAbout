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
		// #warning Incomplete implementation, return the number of rows
		return 2
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell {
			
			cell.profileCellLabel.text = "Дата рождения"
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd MMM yyyy"
			cell.profileCellTextField.text = dateFormatter.string(from: person.birthDate)
			return cell
		}
		return UITableViewCell()
	}
}
