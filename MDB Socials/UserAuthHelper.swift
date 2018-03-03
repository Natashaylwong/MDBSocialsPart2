//
//  UserAuthHelper.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/20/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit

import Foundation
import FirebaseAuth

class UserAuthHelper {
    
    static func logIn(email: String, password: String, withBlock: @escaping (User?)->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                withBlock(user)
            }
        })
    }
    
    static func logOut(withBlock: @escaping ()->()) {
        print("logging out")
        //TODO: Log out using Firebase!
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withBlock()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    static func createUser(email: String, password: String, withBlock: @escaping (String) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil && user != nil{
                print("User created")
                withBlock((user?.uid)!)
            }
            else {
                print("Failed to create a user: \(error.debugDescription)")
            }
        })
    }
}

