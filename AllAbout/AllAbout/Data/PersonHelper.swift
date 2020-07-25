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
	
	var personsCollection: CollectionReference? {
		guard let currentUserId = currentUserId else {
			return nil
		}
		let userDocument = firestore.document("users/\(currentUserId)")
		return userDocument.collection("persons")
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
		guard let personsCollection = personsCollection else {
			completion([], nil)
			return
		}
		
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
				let userSizesDictinaries = dictionary["userSizes"] as? [[String: String]]
				let userSizes =  userSizesDictinaries?.map({ (item) -> UserSize in
					let size = UserSize(name: item["name"] ?? "", value: item["value"] ?? "")
					return size
				})
				let person = Person(id: document.documentID, name: name ?? "", imageUrlString: imageUrl, date: date?.dateValue(), userSizes: userSizes ?? [])
				return person
			})
			
			completion(persons ?? [], nil)
		}
	}
	
	func savePerson(person: Person, completion: @escaping (Bool, Error?) -> Void) {
		guard let personsCollection = personsCollection else {
			completion(false, nil)
			return
		}
		
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
		
		let userSizes = person.userSizes.map { (userData) -> [String: String] in
			let dic = ["name": userData.name, "value": userData.value]
			return dic
		}
		dictionary["userSizes"] = userSizes
		
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
	
	func deletePerson(person: Person, completion: @escaping (Bool, Error?) -> Void) {
		guard let personsCollection = personsCollection, let id = person.id  else {
			completion(false, nil)
			return
		}
		
		let personDocument = personsCollection.document(id)
		personDocument.delete { (error) in
			if let error = error {
				completion(false, error)
			} else {
				completion(true, nil)
			}
		}
	}
}
