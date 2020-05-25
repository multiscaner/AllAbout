//
//  Person.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import UIKit

struct Person {
	let name: String
	var id: String?
	var image: UIImage?
	var imageUrlString: String?
	var birthDate: Date
	
	init(name: String, image: UIImage?, date: String) {
		self.name = name
		self.image = image
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		birthDate = dateFormatter.date(from: date) ?? Date()
	}

	init(id: String? = nil, name: String, imageUrlString: String?, date: String) {
		self.name = name
		self.imageUrlString = imageUrlString
		self.id = id
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		birthDate = dateFormatter.date(from: date) ?? Date()
	}
}
