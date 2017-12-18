//
//  News.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 09/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class News: NSObject, NSCoding, HasIdProtocol {

    @objc var text: String?
    @objc var image: UIImage?
    @objc var likesCount: String
    @objc var commentsCount: String
    @objc var repostsCount: String
    @objc var name: String
    @objc var surname: String
    @objc let date: String
    @objc var id: String
    var user_id: Int
    
    init(text: String?, image: UIImage?, likesCount: String, commentsCount: String, repostsCount: String, name: String, surname: String, date: String, id: String, user_id: Int) {
        
        self.text = text
        self.image = image
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.repostsCount = repostsCount
        self.name = name
        self.surname = surname
        self.date = date
        self.id = id
        self.user_id = user_id
    }
    
    init(text: String?, image: UIImage?, likesCount: String, commentsCount: String, repostsCount: String, name: String, surname: String, date: String, id: String) {
        
        self.text = text
        self.image = image
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.repostsCount = repostsCount
        self.name = name
        self.surname = surname
        self.date = date
        self.id = id
        self.user_id = 0
    }
    
    func toNews(with news: UserNews ) -> News {
        
        if let imageData = news.image {
            image = UIImage(data: imageData as Data)
        }
        
        let news =  News(text: news.text, image: image, likesCount: news.likesCount!, commentsCount: news.commentsCount!, repostsCount: news.repostsCount!, name: news.name!, surname: news.surname!, date: news.date!, id: "0")
        
        return news
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: #keyPath(News.text))
        aCoder.encode(image, forKey: #keyPath(News.image))
        aCoder.encode(likesCount, forKey: #keyPath(News.likesCount))
        aCoder.encode(commentsCount, forKey: #keyPath(News.commentsCount))
        aCoder.encode(repostsCount, forKey: #keyPath(News.repostsCount))
        aCoder.encode(name, forKey: #keyPath(News.name))
        aCoder.encode(surname, forKey: #keyPath(News.surname))
        aCoder.encode(date, forKey: #keyPath(News.date))
        aCoder.encode(id, forKey: #keyPath(News.id))
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObject(forKey: #keyPath(News.text)) as? String
        let image = aDecoder.decodeObject(forKey: #keyPath(News.image)) as? UIImage 
        guard let likesCount = aDecoder.decodeObject(forKey: #keyPath(News.likesCount)) as? String else { return nil }
        guard let commentsCount = aDecoder.decodeObject(forKey: #keyPath(News.commentsCount)) as? String else { return nil }
        guard let repostsCount = aDecoder.decodeObject(forKey: #keyPath(News.repostsCount)) as? String else { return nil }
        guard let name = aDecoder.decodeObject(forKey: #keyPath(News.name)) as? String else { return nil }
        guard let surname = aDecoder.decodeObject(forKey: #keyPath(News.surname)) as? String else { return nil }
        guard let date = aDecoder.decodeObject(forKey: #keyPath(News.date)) as? String else { return nil }
        guard let id = aDecoder.decodeObject(forKey: #keyPath(News.id)) as? String else { return nil }
        let user_id = 0
        
        
        self.init(
            text: text,
            image: image,
            likesCount: likesCount,
            commentsCount: commentsCount,
            repostsCount: repostsCount,
            name: name,
            surname: surname,
            date: date,
            id: id,
            user_id: user_id
        )
    }
    
}
