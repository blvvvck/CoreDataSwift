//
//  UserRegistration.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class UserRegistration: NSObject {

    var id: Int
    var name: String
    var surname: String
    var gender: String
    var email: String
    var phoneNumber: String
    var age: String
    var city: String
    var password: String
    
    init(name: String, surname: String, gender: String, email: String, phoneNumber: String, age: String, city: String, password: String) {
        self.id = 0
        self.name = name
        self.surname = surname
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.city = city
        self.password = password
    }
    
    init(id: Int, name: String, surname: String, gender: String, email: String, phoneNumber: String, age: String, city: String, password: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.city = city
        self.password = password
    }
    
    func encode(with aCoder: NSCoder) {
        
    }
}
