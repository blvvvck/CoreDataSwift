//
//  RegistrationViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var genderPickerView: UIPickerView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    let genders = ["Мужской", "Женский"]
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    var gender = "Мужской"
    let registrationSequeIdentifier = "registrationSeque"
    @IBOutlet weak var activeTextField: UITextField?
    let errorMessage = "Заполните все поля"
    @IBOutlet weak var emailTextField: UITextField!
    var manager: WorkWithDataProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setNotificationKeyboard()
        manager = DataManager()

    }
        
    func setNotificationKeyboard()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height+10, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeTextField
        {
            if (!aRect.contains(activeField.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification){
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0,0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
    }

    @IBAction func registrationButtonTapped(_ sender: Any) {

        if let userName = nameTextField.text, !userName.isEmpty,
            let userSurname = surnameTextField.text, !userSurname.isEmpty,
            let userEmail = emailTextField.text, !userEmail.isEmpty,
            let userPhoneNumber = phoneNumberTextField.text, !userPhoneNumber.isEmpty,
            let userAge = ageTextField.text, !userAge.isEmpty,
            let userCity = cityTextField.text, !userCity.isEmpty,
            let userPassword = passwordTextField.text, !userPassword.isEmpty {
            
            let user = UserRegistration(name: userName, surname: userSurname, gender: gender, email: userEmail, phoneNumber: userPhoneNumber, age: userAge, city: userCity, password: userPassword)
            
            manager.syncSave(with: user)
            performSegue(withIdentifier: registrationSequeIdentifier, sender: nil)
            
        }
        else {
            errorLabel.text = errorMessage
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        activeTextField=textField;
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        activeTextField=nil;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender = genders[row]
    }
    

}
