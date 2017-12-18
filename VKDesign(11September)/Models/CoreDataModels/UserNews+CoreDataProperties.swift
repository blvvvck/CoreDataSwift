//
//  UserNews+CoreDataProperties.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 17/12/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//
//

import Foundation
import CoreData


extension UserNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserNews> {
        return NSFetchRequest<UserNews>(entityName: "UserNews")
    }

    @NSManaged public var likesCount: String?
    @NSManaged public var repostsCount: String?
    @NSManaged public var commentsCount: String?
    @NSManaged public var text: String?
    @NSManaged public var image: NSData?
    @NSManaged public var date: String?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var user: User?

}
