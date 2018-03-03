//
//  NewSocialViewController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/20/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController {
    var nameEvent: UITextField!
    var descriptionTextField: UITextField!
    var nameEventTextField: UITextField!
    var usernameTextField: UITextField!
    var newPostButton: UIButton!
    var imagePost: UIImageView!
    var selectFromLibraryButton: UIButton!
    var selectFromCameraButton: UIButton!
    let picker = UIImagePickerController()
    var date: String!
    let datePicker: UIDatePicker = UIDatePicker()
    var currentUser: Users!
    var exitButton: UIButton!
    var imageText: UILabel!
    
    var color = Constants.appColor

    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        setupButtons()
        setupTextFields()
        setupEventImageView()
        setupCalendar()
        if let currUser = Auth.auth().currentUser {
//            Users.getCurrentUser(withId: currUser.uid).then { (currentUser) in
//                self.currentUser = currentUser
//            }
            FirebaseSocialAPIClient.fetchUser(id: currUser.uid).then { (currentUser) in
                self.currentUser = currentUser
            }
        }
        setupExit()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func setupExit() {
        exitButton = UIButton(frame: CGRect(x: 310, y: 20, width: 30, height: 30))
        exitButton.setImage(UIImage(named: "exit"), for: .normal)
        exitButton.addTarget(self, action: #selector(exitScreen), for: .touchUpInside)
        view.addSubview(exitButton)
    }
    @objc func exitScreen(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupTextFields() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "clouds")
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        imageViewBackground.alpha = 0.5
        view.addSubview(imageViewBackground)
        
        nameEventTextField = UITextField(frame: CGRect(x: 10, y: 0.6 * UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width - 20, height: 40))
        nameEventTextField.adjustsFontSizeToFitWidth = true
        nameEventTextField.font = UIFont(name: "Strawberry Blossom", size: 30)
        nameEventTextField.placeholder = "Event Name"
        nameEventTextField.textAlignment = .center
        nameEventTextField.layoutIfNeeded()
        nameEventTextField.layer.borderColor = color?.cgColor
        nameEventTextField.borderStyle = .roundedRect
        nameEventTextField.layer.backgroundColor = UIColor.white.cgColor
        nameEventTextField.layer.borderWidth = 1.0
        nameEventTextField.layer.masksToBounds = true
        nameEventTextField.textColor = UIColor.black
        view.addSubview(nameEventTextField)
        
        descriptionTextField = UITextField(frame: CGRect(x: 10, y: 0.6 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 60))
        descriptionTextField.adjustsFontSizeToFitWidth = true
        descriptionTextField.font = UIFont(name: "Strawberry Blossom", size: 30)
        descriptionTextField.placeholder = "Short Description of the Event"
        descriptionTextField.textAlignment = .center
        descriptionTextField.borderStyle = .roundedRect
        descriptionTextField.layer.borderColor = color?.cgColor
        descriptionTextField.layer.backgroundColor = UIColor.white.cgColor
        descriptionTextField.layer.borderWidth = 1.0
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.textColor = UIColor.black
        view.addSubview(descriptionTextField)
    }
    func setupEventImageView() {
        imagePost = UIImageView(frame: CGRect(x: 25, y: 60, width: view.frame.width - 50, height: 200))
        imagePost.layer.backgroundColor = UIColor.white.cgColor
        imagePost.layer.borderColor = color?.cgColor
        imagePost.layer.borderWidth = 2
        imageText = UILabel(frame: CGRect(x: 30, y: 140, width: view.frame.width - 60, height: 50))
        imageText.text = "Insert a Picture of the Event"
        imageText.textAlignment = .center
        imageText.font = UIFont(name: "Strawberry Blossom", size: 40)
        imageText.textColor = UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1.0)
        imagePost.layer.cornerRadius = 5.0
        imagePost.contentMode = .scaleToFill
        imagePost.clipsToBounds = true
        
        selectFromLibraryButton = UIButton(frame: CGRect(x: 50, y: 280, width: UIScreen.main.bounds.width * 0.3, height: 40))
        selectFromLibraryButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size: 35)
        selectFromLibraryButton.setTitle("Library", for: .normal)
        selectFromLibraryButton.layer.borderColor =  color?.cgColor
        selectFromLibraryButton.layer.borderWidth = 1
        selectFromLibraryButton.layer.backgroundColor = UIColor.white.cgColor
        selectFromLibraryButton.setTitleColor(UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1.0), for: .normal)
        selectFromLibraryButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        view.bringSubview(toFront: selectFromLibraryButton)
        
        selectFromCameraButton = UIButton(frame: CGRect(x: 200, y: 280, width: UIScreen.main.bounds.width * 0.3, height: 40))
        selectFromCameraButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size: 35)
        selectFromCameraButton.setTitle("Camera", for: .normal)
        selectFromCameraButton.layer.borderColor =  color?.cgColor
        selectFromCameraButton.layer.borderWidth = 1
        selectFromCameraButton.layer.backgroundColor = UIColor.white.cgColor
        selectFromCameraButton.setTitleColor(UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1.0), for: .normal)
        selectFromCameraButton.addTarget(self, action: #selector(takeImage), for: .touchUpInside)
       
        view.addSubview(selectFromCameraButton)
        view.addSubview(selectFromLibraryButton)
        view.addSubview(imagePost)
        view.addSubview(imageText)
        
    }
    
    @objc func pickImage(sender: UIButton!) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.delegate = self
        imageText.removeFromSuperview()
        present(picker, animated: true, completion: nil)
    }
    @objc func takeImage(sender: UIButton!) {
        picker.allowsEditing = false
        picker.sourceType = .camera
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        imageText.removeFromSuperview()
        present(picker, animated: true, completion: nil)
    }
    
    func setupButtons() {
        newPostButton = UIButton(frame: CGRect(x: 10, y: 0.9 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 30))
        newPostButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size: 35)
        newPostButton.setTitle("Create New Post", for: .normal)
        newPostButton.setTitleColor(.white, for: .normal)
        newPostButton.layer.borderWidth = 2.0
        newPostButton.layer.cornerRadius = 5.0
        newPostButton.layer.backgroundColor = color?.cgColor
        newPostButton.layer.borderColor = UIColor.white.cgColor
        newPostButton.layer.masksToBounds = true
        newPostButton.addTarget(self, action: #selector(addNewPost), for: .touchUpInside)
        view.addSubview(newPostButton)
        
    }
    func setupCalendar() {
        // Posiiton date picket within a view
        datePicker.frame = CGRect(x: 10, y: 480, width: self.view.frame.width-20, height: 100)
        
        // Set some of UIDatePicker properties
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.alpha = 0.7
        
        // Add DataPicker to the view
        self.view.addSubview(datePicker)
    }

    @objc func addNewPost() {
        let currentUser = self.currentUser
        let description = descriptionTextField.text!
        let name = nameEventTextField.text!
        let date = datePicker.date
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: date)

        if imagePost.image == nil || description == "" || name == "" {
            let alert = UIAlertController(title: "Not all information inputted", message: "Unable to create a new post", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let currentUser = self.currentUser
            let imageData = UIImageJPEGRepresentation(imagePost.image!, 0.9)
            let description = descriptionTextField.text!
            print("\(description)")
            let name = nameEventTextField.text!
            print("\(name)")
            let date = datePicker.date
            print("\(date)")
            let dateFormatter: DateFormatter = DateFormatter()
            let interested = ["help"]
            
            // Set date format
            dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
           
            // Apply date format
            let selectedDate: String = dateFormatter.string(from: date)
            print("Selected value \(selectedDate)")
            
            FirebaseSocialAPIClient.createNewPost(name: name, description: description, date: selectedDate, imageData: imageData!, host: (currentUser?.name)!, hostId: (currentUser?.id)!, interested: interested)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - Delegates

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePost.contentMode = .scaleAspectFill
        imagePost.image = chosenImage
        dismiss(animated:true, completion: nil)
    }

}


