//
//  Person.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import UIKit

struct Person: Codable {
	let name: String
	private let imageData: Data?
	var image: UIImage? {
		if let data = imageData {
			return UIImage(data: data)
		}
		return nil
	}
	
	init(name: String, image: UIImage?) {
		self.name = name
		let imageData = image?.pngData()
		self.imageData = imageData
	}
}
