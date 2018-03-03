//
//  SignupViewController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/20/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    let picker = UIImagePickerController()
    var titleApp: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nameTextField: UITextField!
    var usernameTextField: UITextField!
    var signupButton: UIButton!
    var imagePost: UIImageView!
    var imageText: UILabel!
    var selectFromLibraryButton: UIButton!
    var selectFromCameraButton: UIButton!
    
    var color = Constants.appColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupTextFields()
        setupButtons()
        setupEventImageView()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // Setting up MDB Social's title
    func setupTitle() {
        navigationController?.navigationBar.tintColor = UIColor.white;
        navigationController?.navigationBar.barTintColor = color

        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "clouds")
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        imageViewBackground.alpha = 0.5
        view.addSubview(imageViewBackground)
        
//        titleApp = UILabel(frame: CGRect(x: 0, y: 80, width: view.frame.width, height: 100))
//        titleApp.font = UIFont(name: "Strawberry Blossom", size: 80)
//        titleApp.backgroundColor = UIColor(red: 0.5882, green: 0.8157, blue: 0.9686, alpha: 1.0)
//        titleApp.layer.borderColor = UIColor.white.cgColor
//        titleApp.textColor = .white
//        titleApp.textAlignment = .center
//        titleApp.text = "MDB Socials"
//        view.addSubview(titleApp)
        self.navigationItem.title = "MDB Socials: Sign Up"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Strawberry Blossom", size: 45)!, NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    
    // Setting up all the textfields required to sign up
    func setupTextFields() {
        usernameTextField = UITextField(frame: CGRect(x: 10, y: 0.5 * UIScreen.main.bounds.height + 70, width: UIScreen.main.bounds.width - 20, height: 40))
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.font = UIFont(name: "Strawberry Blossom", size: 30)
        usernameTextField.placeholder = "Username"
        usernameTextField.textAlignment = .center
        usernameTextField.layoutIfNeeded()
        usernameTextField.layer.borderColor = color?.cgColor
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.layer.backgroundColor = UIColor.white.cgColor
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.masksToBounds = true
        usernameTextField.textColor = UIColor.black
        view.addSubview(usernameTextField)
        
        nameTextField = UITextField(frame: CGRect(x: 10, y: 0.5 * UIScreen.main.bounds.height + 10, width: UIScreen.main.bounds.width - 20, height: 40))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.font = UIFont(name: "Strawberry Blossom", size: 30)
        nameTextField.placeholder = "Name"
        nameTextField.textAlignment = .center
        nameTextField.borderStyle = .roundedRect
        nameTextField.layer.borderColor = color?.cgColor
        nameTextField.layer.backgroundColor = UIColor.white.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.masksToBounds = true
        nameTextField.textColor = UIColor.black
        view.addSubview(nameTextField)
        
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.5 * UIScreen.main.bounds.height + 130, width: UIScreen.main.bounds.width - 20, height: 40))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.font = UIFont(name: "Strawberry Blossom", size: 30)
        emailTextField.placeholder = "Email"
        emailTextField.textAlignment = .center
        emailTextField.layoutIfNeeded()
        emailTextField.isEnabled = true
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = color?.cgColor
        emailTextField.layer.backgroundColor = color?.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = .black
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: 0.5 * UIScreen.main.bounds.height + 190, width: UIScreen.main.bounds.width - 20, height: 40))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.font = UIFont(name: "Strawberry Blossom", size: 30)
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = color?.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.backgroundColor = color?.cgColor
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = .black
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
    
    }
    // Setting up buttons such as the sign up button
    func setupButtons() {
        signupButton = UIButton(frame: CGRect(x: 10, y: 0.9 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 30))
        signupButton.layoutIfNeeded()
        signupButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size: 30)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 3.0
        signupButton.layer.backgroundColor = color?.cgColor
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        view.addSubview(signupButton)
    }
    
    func setupEventImageView() {

        imagePost = UIImageView(frame: CGRect(x: 35, y: 80, width: 300, height: 180))
        
        imagePost.layer.borderWidth = 2
        imagePost.layer.masksToBounds = false
        imagePost.layer.cornerRadius = imagePost.frame.height/2
        imagePost.clipsToBounds = true
        
        imagePost.layer.backgroundColor = UIColor.white.cgColor
        imagePost.layer.borderColor = color?.cgColor
        imageText = UILabel(frame: CGRect(x: 30, y: 150, width: view.frame.width - 60, height: 50))
        imageText.text = "Profile Picture"
        imageText.textAlignment = .center
        imageText.font = UIFont(name: "Strawberry Blossom", size: 40)
        imageText.textColor = UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1.0)
        imagePost.contentMode = .scaleToFill
        imagePost.clipsToBounds = true
        
        selectFromLibraryButton = UIButton(frame: CGRect(x: 55, y: 280, width: UIScreen.main.bounds.width * 0.3, height: 40))
        selectFromLibraryButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size: 35)
        selectFromLibraryButton.setTitle("Library", for: .normal)
        selectFromLibraryButton.layer.borderColor =  color?.cgColor
        selectFromLibraryButton.layer.borderWidth = 1
        selectFromLibraryButton.layer.backgroundColor = UIColor.white.cgColor
        selectFromLibraryButton.setTitleColor(UIColor(red: 0.8078, green: 0.8078, blue: 0.8078, alpha: 1.0), for: .normal)
        selectFromLibraryButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        view.bringSubview(toFront: selectFromLibraryButton)
        
        selectFromCameraButton = UIButton(frame: CGRect(x: 210, y: 280, width: UIScreen.main.bounds.width * 0.3, height: 40))
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

    @objc func signupButtonClicked() {
        //TODO: Implement this method with Firebase!
        let email = emailTextField.text!
        print("\(email)")
        let password = passwordTextField.text!
        print("password")
        let name = nameTextField.text!
        print("name")
        let username = usernameTextField.text!
        print("username")
        let imageData = UIImageJPEGRepresentation(imagePost.image!, 0.9)
        if imagePost.image == nil || email == "" || password == "" || username == "" || name  == "" {
            let alert = UIAlertController(title: "Not all information inputted", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if password.count < 6 {
            let alert = UIAlertController(title: "Not long enough password", message: "Password must be at least 6 characters", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case.default:
                    print("default")
                case.cancel:
                    print("cancel")
                case.destructive:
                    print("destructive")
                }
            }))
        } else {
            UserAuthHelper.createUser(email: email, password: password, withBlock: { (id) in
                print(id)
                FirebaseSocialAPIClient.createNewUser(id: id, name: name, email: email, username: username, profilePic: imageData!)
                self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
            })
            
        }
    }
}

extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - Delegates
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePost.contentMode = .scaleAspectFill
        imagePost.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
}
