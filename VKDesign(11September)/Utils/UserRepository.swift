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
    
    lazy var persistentContainer : NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "VKDesign(11September)")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
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
        
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        let predicate = NSPredicate(format: "\(#keyPath(User.email)) == %@", email)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let user = try context.fetch(request)
            if user.first != nil {
                return true
            }
        } catch {
            print (error.localizedDescription)
        }
        return false
        
//        if manager.openDatabase() {
//
//            do {
//                let result = try manager.database.executeQuery(userCheckSQL, values: [email, password])
//                return result.next()
//            }
//            catch {
//                print("неудачная попытка проверки при логине")
//            }
//        }
//        return false
    }
    
    func getUser(with email: String) -> UserRegistration? {
        
        let context = persistentContainer.viewContext
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
        
//        var users = [UserRegistration]()
//
//        if manager.openDatabase() {
//
//            do {
//                let result = try manager.database.executeQuery(userGetSQL, values: [email])
//
//                while result.next() == true {
//                    guard let result_id = result.string(forColumn: "user_id"),
//                        let result_name = result.string(forColumn: "user_name"),
//                        let result_surname = result.string(forColumn: "user_surname"),
//                        let result_gender = result.string(forColumn: "user_gender"),
//                        let result_email = result.string(forColumn: "user_email"),
//                        let result_phoneNumber = result.string(forColumn: "user_phoneNumber"),
//                        let result_age = result.string(forColumn: "user_age"),
//                        let result_city = result.string(forColumn: "user_city"),
//                        let result_password = result.string(forColumn: "user_password") else { return nil }
//
//                    let user = UserRegistration(id: Int(result_id)!,name: result_name, surname: result_surname, gender: result_gender, email: result_email, phoneNumber: result_phoneNumber, age: result_age, city: result_city, password: result_password)
//                    users.append(user)
//                }
//            }
//            catch {
//                print("неудачаная попытка получить юзера при логине")
//            }
//
//        }
//        return users.first
    }
    
    func identifyCurrentUser(with email: String) -> User? {
        let context = persistentContainer.viewContext
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
