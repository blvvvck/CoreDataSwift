//
//  UserRepository.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation
import CoreData

class UserRepository {
    
    static let sharedInstance = UserRepository()
    private init() {}
    
    var users =  [UserRegistration]()
    var manager = DataManager()
    let userCheckSQL = "select * from user where user_email = ? and user_password = ?"
    let userGetSQL = "select * from user where user_email = ?"
    
    func save(with user: UserRegistration) {
        users.append(user)
    }
    
    func get() -> UserRegistration? {
        if let user = users.first {
            return user
        }
        return nil
    }
    
    func check(with email: String, and password: String) -> Bool {
        
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(User.email)) == %@", email)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let user = try context.fetch(request)
            if user.first != nil {
                DataManager.currentUser = user.first
                return true
            }
        } catch {
            print (error.localizedDescription)
        }
        return false
    }
    
    func getUser(with email: String) -> UserRegistration? {
        
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(User.email)) == %@", email)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let user = try context.fetch(request)
            guard let findedUser = user.first else { return nil }
            guard let user_name = findedUser.name,
            let user_surname = findedUser.surname,
            let user_gender = findedUser.gender,
            let user_email = findedUser.email,
            let user_age = findedUser.age,
            let user_city = findedUser.city,
            let user_password = findedUser.password,
                let user_phoneNumber = findedUser.phoneNumber else { return nil }
            
            let userRegistration = UserRegistration(name: user_name, surname: user_surname, gender: user_gender, email: user_email, phoneNumber: user_phoneNumber, age: user_age, city: user_city, password: user_password)
            return userRegistration
            
             
        } catch {
            print (error.localizedDescription)
        }
        return nil
        
    }
    
    func identifyCurrentUser(with email: String) -> User? {
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(User.email)) == %@", email)
        request.predicate = predicate
        request.fetchLimit = 1
        var identifiedUser: User?
        
        do {
            let user = try context.fetch(request)
            identifiedUser = user.first!
        } catch {
            print(error.localizedDescription)
        }
        return identifiedUser
    }
}
