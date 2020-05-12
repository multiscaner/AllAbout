//
//  PersonHelper.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation

class PersonHelper {
	
	func readPersons() -> [Person] {
		if let data = UserDefaults.standard.value(forKey: "persons") as? Data,
			let personArray = try? PropertyListDecoder().decode(Array<Person>.self, from: data) {
			return personArray
		}
		return []
	}
	
	func savePerson(person: Person) {
		var persons = readPersons()
		persons.append(person)
		UserDefaults.standard.set(try? PropertyListEncoder().encode(persons), forKey: "persons")
	}
}
