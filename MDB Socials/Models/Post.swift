//
//  Post.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/21/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import ObjectMapper
import PromiseKit
import Haneke


class Post: Mappable {
    var text: String?
    var imageUrl: String?
    var posterId: String?
    var eventName: String?
    var interested: [String]?
    var poster: String?
    var id: String?
    var image: UIImage?
    var date: String?
    var location: String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        text                        <- map["description"]
        imageUrl                    <- map["imageURL"]
        posterId                    <- map["hostId"]
        eventName                   <- map["name"]
        interested                  <- map["interested"]
        poster                      <- map["host"]
        id                          <- map["postId"]
        image                       <- map[""]
        date                        <- map["date"]
        location                    <- map["location"]
    }
    
//    init(id: String, postDict: [String:Any]?) {
//        self.id = id
//        if postDict != nil {
//            if let id = postDict!["postId"] as? String {
//                self.id = id
//            }
//            if let text = postDict!["description"] as? String {
//                self.text = text
//            }
//            if let imageUrl = postDict!["imageUrl"] as? String {
//                self.imageUrl = imageUrl
//            }
//            if let posterId = postDict!["hostId"] as? String {
//                self.posterId = posterId
//            }
//            if let poster = postDict!["host"] as? String {
//                self.poster = poster
//            }
//            if let eventName = postDict!["name"] as? String {
//                self.eventName = eventName
//            }
//            if let interested = postDict!["interested"] as? [String] {
//                self.interested = interested
//            }
//        }
//    }

//    func getEventPic(withBlock: @escaping () -> ()) {
//        //TODO: Get Picture from Storage
//        let ref = Storage.storage().reference().child("Event Images/\(id!)")
//        ref.getData(maxSize: 5 * 2048 * 2048) { data, error in
//            if let error = error {
//                print(error)
//            } else {
//                self.image = UIImage(data: data!)
//                withBlock()
//            }
//        }
//    }
    static func getEventPic(withUrl: String) -> Promise<UIImage> {
        return Promise { fulfill, _ in
            let cache = Shared.imageCache
            if let imageUrl = URL(string: withUrl) {
                cache.fetch(URL: imageUrl as URL).onSuccess({ img in
                    fulfill(img)
                })
            }
        }
    }
}

