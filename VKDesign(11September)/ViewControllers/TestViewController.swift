//
//  TestViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 31/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var news = News(text: "123", image: #imageLiteral(resourceName: "pharaoh"), likesCount: "1", commentsCount: "1", repostsCount: "1", name: "123", surname: "123", date: "123", id: "123", user_id: 0 )
    var id = "123"
    var manager: DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = DataManager()

        initID()
        initLabel()
    }
    
    func initID() {
        //news = manager.syncFind(id: id)!
    }
    
    func initLabel() {
        nameLabel.text = news.name
        surnameLabel.text = news.surname
        dateLabel.text = news.date
        noteLabel.text = news.text
        imageView.image = news.image
        likeCount.text = news.likesCount
        commentCount.text = news.commentsCount
        repostCount.text = news.repostsCount
    }

}
