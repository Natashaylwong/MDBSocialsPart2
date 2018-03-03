//
//  FeedViewController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/20/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import Firebase
import PromiseKit

class FeedViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setupNavBar()
//        FirebaseSocialAPIClient.fetchPosts(withBlock: { (posts) in
//            self.posts.append(contentsOf: posts)
//            for post in posts {
//                Post.getEventPic(withUrl: (post.imageUrl)!).then { img in
//                    post.image = img
//                    } .then {_ in
//                        DispatchQueue.main.async {
//                            self.postCollectionView.reloadData()
//
//                        }
//                }
//            }
//        })
    }
    var modalView: AKModalView!
    var itemDetailView: InterestedModal!
    
    var selectedCell: Int?
    var newPostView: UITextField!
    var newPostButton: UIButton!
    var postCollectionView: UICollectionView!
    var posts: [Post] = []
    var postsRef: DatabaseReference = Database.database().reference().child("Posts")
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: Users?
    var navBar: UINavigationBar!
    var color = Constants.appColor
    var interestedModal: InterestedModal!

//    var orderedPost:

    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
//        delegate = self.MyTabBarController
        self.setupNavBar()
        self.setupCollectionView()
        Users.getCurrentUser(withId: (Auth.auth().currentUser?.uid)!).then{(cUser) in
            self.currentUser = cUser
        }
        
        FirebaseSocialAPIClient.fetchPosts(withBlock: { (posts) in
            self.posts.append(contentsOf: posts)
//            if posts.count > 1 {
//                posts = Utils.sortPosts(posts: posts)
//            }
            for post in posts {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    
    func setupNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationController?.navigationBar.barTintColor = color
        
        let addButton = UIBarButtonItem(image: UIImage(named: "adds"), style: .done, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem  = addButton
//        self.tabBarController?.viewControllers![0].navigationItem.rightBarButtonItem = addButton

        let logOutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem  = logOutButton
//        self.tabBarController?.viewControllers![0].navigationItem.leftBarButtonItem = logOutButton
        navigationItem.title = "MDB Socials: Feed"
   //     self.tabBarController?.viewControllers![0].navigationItem.title = "MDB Socials: Feed"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Strawberry Blossom", size: 40)!]

    }
    
    // Logging out the current user
    @objc func logOut() {
//        UserAuthHelper.logOut {
//            self.dismiss(animated: true, completion: nil)
//            self.navigationController!.popToRootViewController(animated: true)
//        }
        
    }

    // Creating a new post
    @objc func addButtonPressed() {
        self.performSegue(withIdentifier: "toNewPost", sender: self)
    }
    
    @objc func addNewPost(sender: UIButton!) {
        self.performSegue(withIdentifier: "toNewPost", sender: self)
    }
    
    // Pressing Heart Button
//    @objc func showInterested() {
//        let navBarHeight = navigationController?.navigationBar.frame.height
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        let
//        firstly {
//            if post?.interested != nil {
//                return fetchUsers(uids: post.interested!)
//            }
//            }.then { users in
//                self.interestedModal = InterestedModal(frame: CGRect(x: 0, y: 70, width: self.view.frame.width - 60, height: self.view.frame.height - 75 - (110 - navBarHeight! - statusBarHeight)), users: users)
//                self.modalView = AKModalView(view: self.interestedModal)
//                self.modalView.dismissAnimation = .FadeOut
//                self.navigationController?.view.addSubview(self.modalView)
//                self.modalView.show()
//        }
//    }
    
//    func fetchUsers(uids: [String]) -> Promise<[Users]> {
//        return Promise { fulfill, _ in
//            let group = DispatchGroup()
//            var users: [Users] = []
//            for uid in uids {
//                group.enter()
//                firstly {
//                    return FirebaseSocialAPIClient.fetchUser(id: uid)
//                    }.then { user in
//                        users.append(user)
//                        firstly {
//                            return Users.getProfilePic(withUrl: user.imageUrl!)
//                            }.then { image in
//                                user.image = image
//                                group.leave()
//                        }
//                }
//            }
//            group.notify(queue: DispatchQueue.main, execute: { () in
//                fulfill(users)
//            })
//        }
//    }
    // Setting up the Collection View
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

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "post", for: indexPath) as! PostCollectionViewCell
        cell.awakeFromNib()
        
        //Retrieving information from a post based on the indexPath.item
        let postInQuestion = posts[indexPath.item]
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = indexPath.item
        self.performSegue(withIdentifier: "toDetail", sender: self)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    // Preparing information for segue into the DVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let details = segue.destination as! DetailViewController
            let postInQuestion = posts[selectedCell!]
            details.post = postInQuestion
            details.interested = postInQuestion.interested
            print("\(postInQuestion.interested?.count)")
            details.poster = postInQuestion.poster
            details.eventName = postInQuestion.eventName
            details.descrip = postInQuestion.text
            details.eventImage = postInQuestion.image
            details.posterId = postInQuestion.posterId
            details.currentUser = currentUser
            if postInQuestion.interested != nil {
                print("\(postInQuestion.interested?.count)")
            }
        }
        
    }
    
}




