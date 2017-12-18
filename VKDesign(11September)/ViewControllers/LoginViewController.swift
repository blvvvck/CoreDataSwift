//
//  LoginViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let loginSegueIdentifier = "loginSeque"
    @IBOutlet weak var errorLabel: UILabel!
    let errorMessage = "Заполните все поля"
    let adminPassword = "admin"
    let adminEmail = "admin"
    var user_password = ""
    var user_email = ""
    var manager: DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = DataManager()
        hideKeyboardWhenTappedAround()
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        if let password = passwordTextField.text {
            user_password = password
        }
        
        if let email = emailTextField.text {
            user_email = email
        }
        
        if (passwordTextField.text == adminPassword && emailTextField.text == adminEmail) {
            performSegue(withIdentifier: loginSegueIdentifier, sender: nil)
        } else if (passwordTextField.text == "" && emailTextField.text == "") {
            errorLabel.text = errorMessage
        } else if UserRepository.sharedInstance.check(with: user_email, and: user_password) {
            //DataManager.currentUser = UserRepository.sharedInstance.identifyCurrentUser(with: user_email)
            performSegue(withIdentifier: loginSegueIdentifier, sender: nil)
        }
        else {
            errorLabel.text = errorMessage
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == loginSegueIdentifier {
            let nav = segue.destination as! UINavigationController
            let profileVC = nav.topViewController as! ViewController
            profileVC.userRegistration = UserRepository.sharedInstance.getUser(with: user_email)!
        }
    }
}
