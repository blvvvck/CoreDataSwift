//
//  User+CoreDataProperties.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 17/12/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: String?
    @NSManaged public var city: String?
    @NSManaged public var email: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var surname: String?
    @NSManaged public var news: NSSet?

}

// MARK: Generated accessors for news
extension User {

    @objc(addNewsObject:)
    @NSManaged public func addToNews(_ value: UserNews)

    @objc(removeNewsObject:)
    @NSManaged public func removeFromNews(_ value: UserNews)

    @objc(addNews:)
    @NSManaged public func addToNews(_ values: NSSet)

    @objc(removeNews:)
    @NSManaged public func removeFromNews(_ values: NSSet)

}
