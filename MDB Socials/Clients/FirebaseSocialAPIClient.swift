//
//  FirebaseSocialAPIClient.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/21/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import Foundation
import Firebase

class FirebaseSocialAPIClient {
    // Retrieving data from Firebase for a post
//    static func fetchPosts(withBlock: @escaping ([Post]) -> ()) {
//        let ref = Database.database().reference()
//        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
//            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
//            withBlock([post])
//        })
//    }
    
    // Retrieving data from Firebase for a user
    static func fetchUser(id: String, withBlock: @escaping (Users) -> ()) {
        let ref = Database.database().reference()
        ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = Users(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            withBlock(user)
            
        })
    }
    // Creating a new post and saving it into Firebase
    static func createNewPost(name: String, description: String, date: String, imageData: Data, host: String, hostId: String, interested: Int) {
        let postsRef = Database.database().reference().child("Posts")
        let key = postsRef.childByAutoId().key
        let storage = Storage.storage().reference().child("Event Images/\(key)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.putData(imageData, metadata: metadata).observe(.success) {(snapshot) in print("image stored")
            let interested = [String]()
            let imageURL = snapshot.metadata?.downloadURL()?.absoluteString as! String
            let newPost = ["name": name, "description": description, "date": date, "imageURL": imageURL, "host": host, "hostId": hostId, "postId": key, "interested": interested ] as [String: Any]
            let childUpdates = ["\(key)": newPost]
            postsRef.updateChildValues(childUpdates)
        }
//        if let postDict = snapshot.value as? [String: Any] {
//            postDict["postId"] = snapshot.key
//            let post = Post(JSON: postDict)
//        }
    }
    
    
    // Creating a new user and updating the user node in Firebase
    static func createNewUser(id: String, name: String, email: String, username: String, profilePic: Data) {
//        let usersRef = Database.database().reference().child("Users")
//                let newUser = ["name": name, "email": email, "username": username, "imageURL": imageURL]
//        let childUpdates = ["/\(id)/": newUser]
//        usersRef.updateChildValues(childUpdates)
        let usersRef = Database.database().reference().child("Users")
        let storage = Storage.storage().reference().child("User Images/\(id)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storage.putData(profilePic, metadata: metadata).observe(.success) {(snapshot) in print("image stored")
            let imageURL = snapshot.metadata?.downloadURL()?.absoluteString as! String
            print(imageURL)
            let newUser = ["name": name, "email": email, "username": username, "imageUrl": imageURL] as [String: Any]
            let childUpdates = ["\(id)": newUser]
            usersRef.updateChildValues(childUpdates)
        }
    }
    
    func storeProfileImage(image: Data) {
    }
}

