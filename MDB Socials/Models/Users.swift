//
//  User.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/21/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Firebase
import PromiseKit
import Haneke

class Users: Mappable {
    var name: String?
    var email: String?
    var username: String?
    var password: String?
    var id: String?
    var image: UIImage?
    var imageUrl: String?

//    init(id: String, userDict: [String:Any]?) {
//        self.id = id
//        if userDict != nil {
//            if let name = userDict!["name"] as? String {
//                self.name = name
//            }
//            if let username = userDict!["username"] as? String {
//                self.username = username
//            }
//            if let email = userDict!["email"] as? String {
//                self.email = email
//            }
//            if let password = userDict!["password"] as? String {
//                self.password = password
//            }
//            if let imageUrl = userDict!["imageUrl"] as? String {
//                self.imageUrl = imageUrl
//            }
//        }
//    }
    
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        name                            <- map["name"]
        email                           <- map["email"]
        username                        <- map["username"]
        password                        <- map["password"]
        id                              <- map["id"]
        imageUrl                        <- map["imageUrl"]
    }

    static func getCurrentUser(withId: String) -> Promise<Users> {
        return Promise {fulfill, error in
            FirebaseSocialAPIClient.fetchUser(id: withId).then { user in
                fulfill(user)
            }
        }
    }
//    static func getCurrentUser(withId: String, block: @escaping (Users) -> ()) {
//        FirebaseSocialAPIClient.fetchUser(id: withId, withBlock: {(user) in
//            print("\(withId)")
//            block(user)
//        })
////    }
    
//    func getProfilePic(withBlock: @escaping () -> ()) {
//        //TODO: Get Picture from Storage
//        let ref = Storage.storage().reference().child("User Images/\(id!)")
//        ref.getData(maxSize: 5 * 2048 * 2048) { data, error in
//            if let error = error {
//                print(error)
//            } else {
//                self.image = UIImage(data: data!)
//                withBlock()
//            }
//        }
//    }
    static func getProfilePic(withUrl: String) -> Promise<UIImage> {
        return Promise { fulfill, _ in
            let cache = Shared.imageCache
            if let imageUrl = URL(string: withUrl) {
                cache.fetch(URL: imageUrl as URL).onSuccess({ img in
                    fulfill(img)
                })
            }
        }
    }
//
    
}
