//
//  InterestedViewController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 3/2/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class MyEventsViewController: UIViewController {
    var color = Constants.appColor
    
    var selectedCell: Int?
    var newPostView: UITextField!
    var newPostButton: UIButton!
    var postCollectionView: UICollectionView!
    var posts: [Post] = []
    var postsRef: DatabaseReference = Database.database().reference().child("Posts")
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: Users?
    var navBar: UINavigationBar!
    var interestedModal: InterestedModal!
    var filteredPosts: [Post] = []
    var id = String()
    override func viewDidAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
      //  self.setupNavBar()
        self.setupCollectionView()
        Users.getCurrentUser(withId: (Auth.auth().currentUser?.uid)!).then{(cUser) -> Void in
            self.currentUser = cUser
            print("\(self.currentUser)")
        }
        FirebaseSocialAPIClient.fetchPosts(withBlock: { (posts) in
            self.posts.append(contentsOf: posts)
            //            if posts.count > 1 {
            //                posts = Utils.sortPosts(posts: posts)
            //            }
            self.id = (Auth.auth().currentUser?.uid)!
            for post in posts {
                if post.posterId == self.id {
                    self.filteredPosts.append(post)
                } else if post.interested != nil {
                    if (post.interested?.contains(self.id))! {
                        self.filteredPosts.append(post)
                    }
                }
            }
            for post in self.filteredPosts {
                Post.getEventPic(withUrl: (post.imageUrl)!).then { img in
                    post.image = img
                    } .then {_ in
                        DispatchQueue.main.async {
                            self.postCollectionView.reloadData()
                            
                        }
                }
                //                let imageUrl = post.imageUrl
                //                Post.getEventPic(withUrl: imageUrl) {
                //                    self.postCollectionView.reloadData()
                //                }
            }
            activityIndicator.stopAnimating()
            
        })
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = color
        
//            let addButton = UIBarButtonItem(image: UIImage(named: "adds"), style: .done, target: self, action: #selector(addButtonPressed))
        //        navigationItem.rightBarButtonItem  = addButton
//            navigationController?.viewControllers[1].navigationItem.rightBarButtonItem = addButton
        
//            let logOutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(logOut))
        //        navigationItem.leftBarButtonItem  = logOutButton
//            navigationController?.viewControllers[1].navigationItem.leftBarButtonItem = logOutButton
        //navigationItem.title = "MDB Socials: Feed"
        self.navigationController?.viewControllers[1].navigationItem.title = "MDB Socials: My Events"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Strawberry Blossom", size: 35)!]
    //    self.navigationController?.viewControllers[1].navigationItem.leftBarButtonItem = 
    }
    
    func setupCollectionView() {
        let frame = CGRect(x: 0, y: 50, width: view.frame.width, height: view.frame.height-50)
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.minimumLineSpacing = 10
        postCollectionView = UICollectionView(frame: frame, collectionViewLayout: cvLayout)
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
        postCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "post")
        postCollectionView.backgroundColor = UIColor.white
        view.addSubview(postCollectionView)
    }

}

extension MyEventsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! PostCollectionViewCell
        cell.awakeFromNib()
        
        //Retrieving information from a post based on the indexPath.item
        let postInQuestion = filteredPosts[indexPath.item]
        cell.postText.text = "Event: \n" + postInQuestion.eventName!
        cell.posterText.text = "Host: " + postInQuestion.poster!
        cell.profileImage.image = postInQuestion.image
        if postInQuestion.interested == nil {
            cell.numberInterested.text = "\(0)"
        } else {
            cell.numberInterested.text = "\(postInQuestion.interested!.count)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
