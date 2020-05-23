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
	
	init(name: String, image: UIImage?) {
		self.name = name
		self.image = image
	}

	init(id: String? = nil, name: String, imageUrlString: String?) {
		self.name = name
		self.imageUrlString = imageUrlString
		self.id = id
	}
}
