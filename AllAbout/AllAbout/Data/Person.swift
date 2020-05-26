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
	var name: String
	var id: String?
	var image: UIImage?
	var imageUrlString: String?
	var birthDate: Date?
	var height: Int?
	var weight: Int?
	var shoesSize: Int?
	var socksSize: Int?
	var birthDateString: String? {
		guard let date = birthDate else { return nil }
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		return dateFormatter.string(from: date)
	}

	init(name: String, image: UIImage?, date: String) {
		self.name = name
		self.image = image
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		birthDate = dateFormatter.date(from: date) ?? Date()
	}

	init(id: String? = nil, name: String, imageUrlString: String?, date: Date?, height: Int?, weight: Int?, shoesSize: Int?, socksSize: Int?) {
		self.name = name
		self.imageUrlString = imageUrlString
		self.id = id
		self.birthDate = date
		self.height = height
		self.weight = weight
		self.shoesSize = shoesSize
		self.socksSize = socksSize
	}
}
