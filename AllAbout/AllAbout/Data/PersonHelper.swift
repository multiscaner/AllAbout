//
//  PersonHelper.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PersonHelper {
	lazy var ref: DatabaseReference? = Database.database().reference()
	
	func readPersons(successHandler: @escaping ([Person]) -> Void) {
		ref?.child("persons").observeSingleEvent(of: .value, with: { (snapshot) in
			
			var persons: [Person] = []
			for child in snapshot.children {
				guard let snapshot = child as? DataSnapshot, let value = snapshot.value as? [String: Any] else { return }
				guard let name = value["name"] as? String else { return }
				
				let person = Person(id: snapshot.key, name: name, image: nil)
				persons.append(person)
			}
			
			successHandler(persons)
		})
		
	}
	
	func savePerson(person: Person) {
		self.ref?.child("persons").childByAutoId().setValue(["name": person.name])
	}
}
