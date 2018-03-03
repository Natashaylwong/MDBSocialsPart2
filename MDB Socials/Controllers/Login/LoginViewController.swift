//
//  ViewController.swift
//  MDB Socials
//
//  Created by Natasha Wong on 2/20/18.
//  Copyright © 2018 Natasha Wong. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var titleApp: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var signupButton: UIButton!
    var color = Constants.appColor

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        setupTitle()
        setupTextFields()
        setupButtons()
        //TODO: Checks if a user is already signed in, then the app automatically goes to the FeedVC
        // BTW, this isn't correct!!!!! Where do you check for authentication??
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "toFeedFromLogin", sender: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    
    }
    
    func setupTitle() {
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: "clouds")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        imageViewBackground.alpha = 0.4
        
        view.addSubview(imageViewBackground)
        
        titleApp = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 100))
        titleApp.font = UIFont(name: "Strawberry Blossom", size: 100)
        titleApp.backgroundColor = color
        titleApp.layer.borderColor = UIColor.white.cgColor
        titleApp.textColor = .white
        titleApp.textAlignment = .center
        titleApp.text = "MDB Socials"
        view.addSubview(titleApp)
    
    }
    
    func setupTextFields() {
        
        emailTextField = UITextField(frame: CGRect(x: 10, y: 0.5 * UIScreen.main.bounds.height, width: UIScreen.main.bounds.width - 20, height: 40))
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
        
        
        passwordTextField = UITextField(frame: CGRect(x: 10, y: 0.5 * UIScreen.main.bounds.height + 60, width: UIScreen.main.bounds.width - 20, height: 40))
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
    
    func setupButtons() {
        
        loginButton = UIButton(frame: CGRect(x: 10, y: 0.8 * UIScreen.main.bounds.height, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        loginButton.layoutIfNeeded()
        loginButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size:30)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.cornerRadius = 3.0
        loginButton.layer.backgroundColor = color?.cgColor
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signupButton = UIButton(frame: CGRect(x: 0.5 * UIScreen.main.bounds.width + 10, y: 0.8 * UIScreen.main.bounds.height, width: 0.5 * UIScreen.main.bounds.width - 20, height: 30))
        signupButton.layoutIfNeeded()
        signupButton.titleLabel?.font = UIFont(name: "Strawberry Blossom", size: 30)
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.layer.borderWidth = 2.0
        signupButton.layer.cornerRadius = 3.0
        signupButton.layer.backgroundColor = color?.cgColor
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        view.addSubview(signupButton)
    }
    @objc func loginButtonClicked(sender: UIButton!) {
        //TODO: Implement this function using Firebase calls!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if email == "" || password == "" {
            let alert = UIAlertController(title: "Not all information inputted", message: "Please fill out all fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        UserAuthHelper.logIn(email: email, password: password, withBlock: {(user) in
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
        })

    }
    
    @objc func signupButtonClicked(sender: UIButton!) {
        self.performSegue(withIdentifier: "toSignup", sender: self)
    }
    
}
