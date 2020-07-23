//
//  PersonDetailsViewController.swift
//  AllAbout
//
//  Created by UjiN on 7/21/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailsViewController: UIViewController {
	var person: Person!

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let profileViewController = segue.destination as? PersonEditViewController {
			profileViewController.person = person
		}
	}
}
