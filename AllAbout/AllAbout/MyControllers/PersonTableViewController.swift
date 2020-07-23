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
import FirebaseAuth

class PersonTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let hud = JGProgressHUD(style: .dark)
	var persons: [Person]?
	let personHelper = PersonHelper()
	@IBOutlet weak var tableView: UITableView!
	
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
				self.tableView.isHidden = persons.isEmpty
				self.tableView.reloadData()
			}
			self.hud.dismiss()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return persons?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let person = persons?[indexPath.row],
			let cell = tableView.dequeueReusableCell(withIdentifier: "personImageCell", for: indexPath) as? PersonImageViewCell else {
				return UITableViewCell()
		}
		
		cell.nameLabel.text = person.name
		if let birthDateString = person.birthDateString {
			cell.dateLabel.text = birthDateString
		}
		
		if let imageUrlString = person.imageUrlString,
			let url = URL(string: imageUrlString) {
			cell.personImage.af.setImage(withURL: url)
			cell.firstLetterLabel.text = ""
		} else {
			cell.personImage.image = nil
			cell.firstLetterLabel.text = String((person.name.first?.uppercased())!)
		}
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let profileViewController = segue.destination as? PersonDetailsViewController,
			let person = sender as? Person {
			profileViewController.person = person
		}
	}
	
	@IBAction func logOut(_ sender: UIBarButtonItem) {
		do {
			try Auth.auth().signOut()
			let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
			let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
			self.view.window?.rootViewController = viewController
		} catch let error {
			print(error)
		}
	}
}
extension PersonTableViewController {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let person = persons?[indexPath.row]
		performSegue(withIdentifier: "detailsSegue", sender: person)
	}
}
