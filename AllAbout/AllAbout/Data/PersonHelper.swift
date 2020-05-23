//
//  PersonHelper.swift
//  AllAbout
//
//  Created by UjiN on 5/7/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class PersonHelper {
	lazy var ref: DatabaseReference? = Database.database().reference()
	
	func upload(currentUserId: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
		let refer = Storage.storage().reference().child("avatars").child(currentUserId)
		
		guard let imageData = photo.jpegData(compressionQuality: 0.4) else { return }
		
		let metadata = StorageMetadata()
		metadata.contentType = "image/jpeg"
		
		refer.putData(imageData, metadata: metadata) { (metadata, error) in
			guard metadata != nil else {
				completion(.failure(error!))
				return
			}
			refer.downloadURL { (url, error) in
				guard let url = url else {
					completion(.failure(error!))
					return
				}
				completion(.success(url))
			}
		}
	}
	
	func readPersons(successHandler: @escaping ([Person]) -> Void) {
		ref?.child("persons").observeSingleEvent(of: .value, with: { (snapshot) in
			
			var persons: [Person] = []
			for child in snapshot.children {
				guard let snapshot = child as? DataSnapshot, let value = snapshot.value as? [String: Any] else { continue }
				guard let name = value["name"] as? String else { continue }
				let imageUrlString = value["imageUrl"] as? String
				let person = Person(id: snapshot.key, name: name, imageUrlString: imageUrlString)
				persons.append(person)
			}
			
			successHandler(persons)
		})
		
	}
	
	func savePerson(person: Person, completion: @escaping (Bool, Error?) -> Void) {
		guard let personRef = self.ref?.child("persons").childByAutoId(), let personId = personRef.key else { return }
		personRef.setValue(["name": person.name])
		if let image = person.image {
			upload(currentUserId: personId, photo: image) { (result) in
				switch result {
				case .success(let url):
					personRef.setValue(["name": person.name, "imageUrl": url.absoluteString])
					completion(true, nil)
				case .failure(let error):
					completion(false, error)
				}
			}
		}
	}
}
