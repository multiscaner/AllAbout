//
//  PersonHelper.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase
import FirebaseAuth

class PersonHelper {
	let firestore = Firestore.firestore()
	var currentUserId: String? {
		return Auth.auth().currentUser?.uid
	}

	func upload(name: String, photo: UIImage, completion: @escaping (URL?, Error?) -> Void) {
		let refer = Storage.storage().reference().child("avatars").child(name)
		
		guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
		
		let metadata = StorageMetadata()
		metadata.contentType = "image/jpeg"
		
		refer.putData(imageData, metadata: metadata) { (metadata, error) in
			guard metadata != nil else {
				completion(nil, error)
				return
			}
			refer.downloadURL { (url, error) in
				guard let url = url else {
					completion(nil, error)
					return
				}
				completion(url, nil)
			}
		}
	}
	
	func readPersons(completion: @escaping ([Person], Error?) -> Void) {
		guard let currentUserId = currentUserId else {
			completion([], nil)
			return
		}
		
		let userDocument = firestore.document("users/\(currentUserId)")
		let personsCollection = userDocument.collection("persons")
		personsCollection.getDocuments { (shapshot, error) in
			if let error = error {
				completion([], error)
				return
			}
			
			let persons = shapshot?.documents.map({ (document) -> Person in
				let dictionary = document.data()
				let name = dictionary["name"] as? String
				let imageUrl = dictionary["imageUrl"] as? String
				let date = dictionary["date"] as? Timestamp
				let height = dictionary["height"] as? Int
				let weight = dictionary["weight"] as? Int
				let shoesSize = dictionary["shoesSize"] as? Int
				let socksSize = dictionary["socksSize"] as? Int
				let person = Person(id: document.documentID, name: name ?? "", imageUrlString: imageUrl, date: date?.dateValue(), height: height, weight: weight, shoesSize: shoesSize, socksSize: socksSize)
				return person
			})
			
			completion(persons ?? [], nil)
		}
	}
	
	func savePerson(person: Person, completion: @escaping (Bool, Error?) -> Void) {
		guard let currentUserId = currentUserId else {
			completion(false, nil)
			return
		}
		
		let userDocument = firestore.document("users/\(currentUserId)")
		let personsCollection = userDocument.collection("persons")
		
		var personDocument: DocumentReference!
		if let id = person.id {
			personDocument = personsCollection.document(id)
		} else {
			personDocument = personsCollection.addDocument(data: [:])
		}
		
		var dictionary: [String: Any] = ["name": person.name]
		if let date = person.birthDate {
			dictionary["date"] = Timestamp(date: date)
		}
		dictionary["height"] = person.height
		dictionary["weight"] = person.weight
		dictionary["shoesSize"] = person.shoesSize
		dictionary["socksSize"] = person.socksSize
		personDocument.setData(dictionary, merge: true)
		
		if let image = person.image {
			upload(name: personDocument.documentID, photo: image) { (url, error) in
				guard let url = url else {
					completion(false, error)
					return
				}

				personDocument.setData(["imageUrl": url.absoluteString], merge: true)
				completion(true, nil)
			}
		} else {
			completion(true, nil)
		}
	}
}
