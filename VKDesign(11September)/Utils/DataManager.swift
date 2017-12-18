//
//  DataManager.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 27/11/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation
import FMDB
import CoreData

class DataManager: WorkWithDataProtocol {

    var users =  [User]()
    static var currentUser: User?
    
    let databaseFileName = "vk.sqlite"
    lazy var pathToDatabase: String = {
        
        let documentDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        return documentDirectory.appending("/\(databaseFileName)")
        
    }()
    
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
    
    let createNewsTableQuery = "create table news (news_id INTEGER PRIMARY KEY AUTOINCREMENT, news_text TEXT, news_image BLOB, news_likesCount TEXT, news_commentsCount TEXT, news_repostsCount TEXT, news_name TEXT, news_surname TEXT, news_date TEXT, news_user_id INTEGER)"
    let createUsersTableQuery = "create table user (user_id INTEGER PRIMARY KEY AUTOINCREMENT, user_name TEXT, user_surname TEXT, user_gender TEXT, user_email TEXT, user_phoneNumber TEXT, user_age TEXT, user_city TEXT, user_password TEXT)"
    
    
    var database: FMDatabase!
    
     init() {
       
        openDatabase()
        print("\(createDatabase()) СОЗДАНИЕ")
        print(pathToDatabase)
       
    }
    
    func createDatabase() -> Bool {
        
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase)
            
            if database != nil {
                
                if database.open() {
                    
                    do {
                        try database.executeUpdate(createNewsTableQuery, values: nil)
                        try database.executeUpdate(createUsersTableQuery, values: nil)
                        created = true
                    } catch {
                        print("Couldn't create table")
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                } else {
                    print("Couldn't open database")
                }
            }
        }
        
        return created
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    func syncSave<T>(with entity: T) where T : NSObject {
        
        if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "UserRegistration") {
            let user = entity as? UserRegistration
            
            let context = persistentContainer.viewContext
        
            let model = User(context: context)
        
            if let createdUser = user {
                model.name = createdUser.name
                model.surname = createdUser.surname
                model.email = createdUser.email
                model.age = createdUser.age
                model.city = createdUser.city
                model.gender = createdUser.gender
                model.password = createdUser.password
                model.phoneNumber = createdUser.phoneNumber
            }
            
            //currentUser = model
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "News") {
           
            let context = persistentContainer.viewContext
            
            let createdNews = entity as! News
            
            let news = UserNews(context: context)
        
            var imageData = Data()
        
            if let image = createdNews.image, let createdImageData = UIImageJPEGRepresentation(image, 1){
                imageData = createdImageData
            }
            
            news.commentsCount = createdNews.commentsCount
            news.date = createdNews.date
            news.image = imageData as NSData
            news.likesCount = createdNews.likesCount
            news.name = createdNews.name
            news.surname = createdNews.surname
            news.text = createdNews.text
            news.repostsCount = createdNews.repostsCount
            
            let request: NSFetchRequest<User> = User.fetchRequest()
            
            
//            do {
//                let user = try context.fetch(request)
//                currentUser = user.first
//            } catch {
//                print (error.localizedDescription)
//            }
//
            DataManager.currentUser?.addToNews(news)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        
//        if database.open() {
//
//            if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "News") {
//                let news = entity as? News
//                var imageData = Data()
//
//
//                if let createdNews = news {
//
//                    if let image = createdNews.image, let createdImageData = UIImageJPEGRepresentation(image, 1) {
//                        imageData = createdImageData
//                    }
//
//                    let insertSQL = "insert into news (news_text, news_image, news_likesCount, news_commentsCount, news_repostsCount, news_name, news_surname, news_date, news_user_id) VALUES (?, ?, '\(createdNews.likesCount)', '\(createdNews.commentsCount)', '\(createdNews.repostsCount)', '\(createdNews.name)', '\(createdNews.surname)', '\(createdNews.date)', '\(createdNews.user_id)')"
//                    database.executeUpdate(insertSQL, withArgumentsIn: [createdNews.text ,imageData])
//                    print("success news")
//                }
//
//            }
//
//            if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "UserRegistration") {
//                let user = entity as? UserRegistration
//
//                if let createdUser = user {
//
//                    let insertSql = "insert into user (user_name, user_surname, user_gender, user_email, user_phoneNumber, user_age, user_city, user_password) VALUES ('\(createdUser.name)', '\(createdUser.surname)', '\(createdUser.gender)', '\(createdUser.email)', '\(createdUser.phoneNumber)', '\(createdUser.age)', '\(createdUser.city)', '\(createdUser.password)')"
//                    database.executeUpdate(insertSql, withArgumentsIn: [])
//                    print("succes user")
//                }
//            }
//
//
//
//        }
    }
    
    func asyncSave<T>(with entity: T, completionBlock: @escaping (Bool) -> ()) where T : NSObject {
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            self.syncSave(with: entity)
            completionBlock(true)
        }
    }
    
    func syncGetAll<T>() -> [T]? where T : NSObject {
        
        var text: String?
        var image: UIImage?
        
        var dataArray = [T]()

        
        if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "News") {

            let context = persistentContainer.viewContext
            let request: NSFetchRequest<User> = User.fetchRequest()
        
            
//            do {
//                let user = try context.fetch(request)
//                currentUser = user.first
//            } catch {
//                print (error.localizedDescription)
//            }
            
            
            var news = Array((DataManager.currentUser?.news)!)

            var reallyNews = [News]()
            
            for n in news {
                reallyNews.append(toNews(with: n as! UserNews))
            }
            
            dataArray = reallyNews as! [T]
            
//            let context = persistentContainer.viewContext
//
//            let request: NSFetchRequest<User> = User.fetchRequest()
//
//            do {
//                let user = try context.fetch(request)
//
//                currentUser?.news
//
//                
//
//
//
//            } catch {
//                print (error.localizedDescription)
//            }
        

            
        }
        
//        if database.open() {
//
//            if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "News") {
//                let selectSQL = "SELECT * FROM news"
//
//                do {
//
//                    let result = try database.executeQuery(selectSQL, values: [])
//
//                    while result.next() == true {
//                        guard let result_likes = result.string(forColumn: "news_likesCount"),
//                        let result_comments = result.string(forColumn: "news_commentsCount"),
//                        let result_reposts = result.string(forColumn: "news_repostsCount"),
//                        let result_name = result.string(forColumn: "news_name"),
//                        let result_surname = result.string(forColumn: "news_surname"),
//                        let result_date = result.string(forColumn: "news_date"),
//                        let result_user_id = result.string(forColumn: "news_user_id") else { return nil }
//
//                        if let result_text = result.string(forColumn: "news_text") {
//                            text = result_text
//                        }
//
//                        if let result_image = result.data(forColumn: "news_image") {
//                            image = UIImage(data: result_image)
//                        }
//
//                        let news = News(text: text, image: image, likesCount: result_likes, commentsCount: result_comments, repostsCount: result_reposts, name: result_name, surname: result_surname, date: result_date, id: UUID().uuidString, user_id: Int (result_user_id)!) as! T
//
//                        dataArray.append(news)
//
//                    }
//                }
//                    catch {
//                        print("select error news")
//                    }
//                }
//
//            if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == "UserRegistration") {
//                let selectSQL = "SELECT * FROM user"
//
//                do {
//
//                    let result = try database.executeQuery(selectSQL, values: [])
//
//                    while result.next() == true {
//                        guard let result_id = result.string(forColumn: "user_id"),
//                        let result_name = result.string(forColumn: "user_name"),
//                        let result_surname = result.string(forColumn: "user_surname"),
//                        let result_gender = result.string(forColumn: "user_gender"),
//                        let result_email = result.string(forColumn: "user_email"),
//                        let result_phoneNumber = result.string(forColumn: "user_phoneNumber"),
//                        let result_age = result.string(forColumn: "user_age"),
//                        let result_city = result.string(forColumn: "user_city"),
//                        let result_password = result.string(forColumn: "user_password") else { return nil }
//
//                        let user = UserRegistration(id: Int(result_id)!,name: result_name, surname: result_surname, gender: result_gender, email: result_email, phoneNumber: result_phoneNumber, age: result_age, city: result_city, password: result_password) as! T
//
//                        dataArray.append(user)
//                    }
//                }
//                catch {
//                    print("select error user")
//                }
//            }
//
//            }
            return dataArray
        }
    
    
    func asyncGetAll<T>(completionBlock: @escaping ([T]) -> ()) where T : NSObject {
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            guard let currentEntityArray: [T] = self.syncGetAll() else { return }
            completionBlock(currentEntityArray)
        }
    }
    
    func syncFind<T: NSObject>(id: String) -> T? where T: HasIdProtocol {
        guard let currentEnities: [T] = syncGetAll() else { return nil }
        for entity in currentEnities {
            if entity.id == id {
                return entity
            }
        }
        return nil
    }
    
    func asyncFind<T: NSObject>(id: String, completionBlock: @escaping (T?) -> ()) where T: HasIdProtocol {
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            guard let currentEntities: [T] = self.syncGetAll() else { return }
            for entity in currentEntities {
                if entity.id == id {
                    completionBlock(entity)
                }
            }
            completionBlock(nil)
        }
    }
    
    func getUsersNews(with id: Int) -> [News]? {
        let selectSQL = "SELECT * FROM news where news_user_id = ?"
        
        var text: String?
        var image: UIImage?
        var dataArray = [News]()
        
        do {
            
            let result = try database.executeQuery(selectSQL, values: [id])
            
            while result.next() == true {
                guard let result_likes = result.string(forColumn: "news_likesCount"),
                    let result_comments = result.string(forColumn: "news_commentsCount"),
                    let result_reposts = result.string(forColumn: "news_repostsCount"),
                    let result_name = result.string(forColumn: "news_name"),
                    let result_surname = result.string(forColumn: "news_surname"),
                    let result_date = result.string(forColumn: "news_date"),
                    let result_user_id = result.string(forColumn: "news_user_id") else { return nil }
                
                if let result_text = result.string(forColumn: "news_text") {
                    text = result_text
                }
                
                if let result_image = result.data(forColumn: "news_image") {
                    image = UIImage(data: result_image)
                }
        
                
                let news = News(text: text, image: image, likesCount: result_likes, commentsCount: result_comments, repostsCount: result_reposts, name: result_name, surname: result_surname, date: result_date, id: UUID().uuidString, user_id: Int(result_user_id)!)
                
                dataArray.append(news)
                
            }
        }
        catch {
            print("select error news")
        }
        return dataArray
    }
    
    func toNews(with news: UserNews ) -> News {
        var image: UIImage?
        
        if let imageData = news.image {
            image = UIImage(data: imageData as Data)
        }
        
        let news =  News(text: news.text, image: image, likesCount: news.likesCount!, commentsCount: news.commentsCount!, repostsCount: news.repostsCount!, name: news.name!, surname: news.surname!, date: news.date!, id: "0")
        
        return news
    }
    
}

