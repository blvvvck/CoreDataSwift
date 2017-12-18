//
//  FollowersTableViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 18/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class FollowersTableViewController: UITableViewController {
    
    var followers = [Follower]()
    let cellIdentifier = "followerCell"
    let namesArray = ["Sasha", "Misha", "Petya", "Vlad", "Anton"]
    let surnsmesArray = ["Petrov", "Ivanov", "Sidorov", "Antonov", "Shlyakov"]
    let followersAvatarArray: [UIImage] = [UIImage(named: "followerAvatar1")!, UIImage(named: "followerAvatar2")!, UIImage(named: "followerAvatar3")!, UIImage(named: "followerAvatar4")!, UIImage(named: "followerAvatar5")!, UIImage(named: "followerAvatar6")!, UIImage(named: "followerAvatar7")!, UIImage(named: "followerAvatar8")!, UIImage(named: "followerAvatar9")!]
    let onlineArray: [UIImage] = [UIImage(named: "onlineIcon")!, UIImage(named: "phoneOnlineIcon")!, UIImage(named: "offlineIcon")!]
    
    let followerCellHeight: CGFloat = 48
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateFollowers()
        registrationCell()
    }
    
    func generateFollowers() {
        
        for _ in 0 ..< 25 {
            let follower = Follower(name: "\(namesArray[Int(arc4random_uniform(UInt32(namesArray.count)))])",
                surname: "\(surnsmesArray[Int(arc4random_uniform(UInt32(surnsmesArray.count)))])",
                avatar: followersAvatarArray[Int(arc4random_uniform(UInt32(followersAvatarArray.count)))], online: (onlineArray[Int(arc4random_uniform(UInt32(onlineArray.count)))]))
            followers.append(follower)
        }
    }
    
    func registrationCell() {
        let followerCellNib = UINib(nibName: "FollowerTableViewCell", bundle: nil)
        tableView.register(followerCellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FollowerTableViewCell
     
        let model = followers[indexPath.row]
        
        cell.prepareCell(with: model)
     
        return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return followerCellHeight
    }
}
