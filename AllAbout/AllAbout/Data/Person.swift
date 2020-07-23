//
//  Person.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import UIKit

class UserSize {
	var name: String
	var value: String = ""
	
	init(name: String, value: String = "") {
		self.name = name
		self.value = value
	}
}

class Person {
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
	var userSizes: [UserSize] = [UserSize(name: "Цвет глаз"), UserSize(name: "Блюдо")]
	
	func addUserSize(name: String) {
		userSizes.append(UserSize(name: name))
	}
	
	func removeUserSize(index: Int) {
		userSizes.remove(at: index)
	}

	init(name: String, image: UIImage?, date: String) {
		self.name = name
		self.image = image
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		birthDate = dateFormatter.date(from: date) ?? Date()
	}

	init(id: String? = nil, name: String, imageUrlString: String?, date: Date?, height: Int?, weight: Int?, shoesSize: Int?, socksSize: Int?, userSizes: [UserSize]) {
		self.name = name
		self.imageUrlString = imageUrlString
		self.id = id
		self.birthDate = date
		self.height = height
		self.weight = weight
		self.shoesSize = shoesSize
		self.socksSize = socksSize
		self.userSizes = userSizes
	}
}
