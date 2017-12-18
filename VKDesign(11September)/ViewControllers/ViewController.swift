//
//  ViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 11/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

enum InformationAboutUserType {
    case friends
    case followers
    case groups
    case photos
    case videos
    case audios
    case gifts
    case docs
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataTransferProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let types: [InformationAboutUserType] = [.friends, .followers, .groups, .photos, .videos, .audios, .gifts, .docs]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var noteButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var userPhotosCollectionView: UICollectionView!
    @IBOutlet weak var aboutCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let navigationBarColor = UIColor.init(red: 89/255.0, green: 125/255.0, blue: 163/255.0, alpha: 1.0)
    let borderColor = UIColor.init(red: 184/255.0, green: 184/255.0, blue:184/255.0, alpha: 1.0).cgColor
    let surnameArray = ["Ivanov","Petrov","Sidorov"]
    let nameArray = ["Ivan", "Anton", "Vlad"]
    let ageArray = ["18 years old,", "21 years old,", "35 years old,"]
    let locationArray = ["Kirov", "Kazan", "Moscow"]
    let borderThickness : CGFloat = 0.5
    let avatarCornersMultiply : CGFloat = 10
    let friendsConst = "friends"
    let followersConst = "followers"
    let groupsConst = "groups"
    let photosConst = "photos"
    let videosConst = "videos"
    let audiosConst = "audios"
    let giftsConst = "gifts"
    let docsConst = "docs"
    let randomConst : UInt32 = 100
    let infoSequeIdentifier = "infoIdentifier"
    let noteSequeIdentifier = "noteSequeIdentifier"
    let followersSequeIdentifier = "followerSequeIdentifier"
    let testSugueIdentifir = "testSegue"
    let radiusRoundCorner: CGFloat = 50
    var notesArray: [String] = []
    let noteCellIdentifier = "noteIdentifier"
    let estimatedNewsCellHeight: CGFloat = 100
    var news = [News]()
    let newsTextArray = ["Dolor", "PHOSPHOR", "PINK PHLOYD"]
    let newsLikesArray = ["21", "16", "7"]
    let newsCommentsArray = ["12", "32", "1"]
    let newsRepostsArray = ["43", "34", "12"]
    let newsImageArray = [UIImage(named: "Dolor1")!, UIImage(named: "Phosphor1")!, UIImage(named: "PinkPhloyd1")!]
    let newsDateArray = ["4 сен в 21:52", "3 янв в 2:53", "12 янв в 20:57", "18 июня в 18:00", "21 июня в 16:21"]
    let aboutCollectionViewSections = 8
    let aboutCellIdentifier = "aboutIdentifier"
    let userPhotosCellIdentifier = "userPhotosCellIdentifier"
    let userPhotosArray = [UIImage(named: "Dolor1")!, UIImage(named: "Phosphor1")!, UIImage(named: "PinkPhloyd1")!, UIImage(named: "pharaoh")!, UIImage(named: "lezha")!]
    let userPhotosCount = 9
    var testID = "0"
    var newsManager: DataManager!
    var userRegistration = UserRegistration(id: 0, name: "", surname: "", gender: "", email: "", phoneNumber: "", age: "", city: "", password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        newsManager = DataManager()
        photoButtonBorder()
        noteButtonBorder()
        setNavigationBarColorAndFont()
        avatar.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: radiusRoundCorner)
        cellRegistration()
        prepareForDynamicCellSize()
        topAboutCollectionViewBorder()
        bottomAboutCollectionViewBorder()
        bottomUserPhotosCollectionViewBorder()
        initInfo()
        randomNews()
        initNews()
    }
    
    func initInfo() {
        if  userRegistration.name != ""  {
            nameLabel.text = userRegistration.name
            surnameLabel.text = userRegistration.surname
            locationLabel.text = userRegistration.city
            ageLabel.text = "\(userRegistration.age) years old,"
        } else {
            randomAge()
            randomName()
            randomSurname()
            randomLocation()
        }
    }
    
    func initNews() {
        guard let currentNews: [News] = newsManager.getUsersNews(with: userRegistration.id) else { return }
        news = currentNews
    }
    
    func prepareForDynamicCellSize() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimatedNewsCellHeight
    }
    
    func randomNews() {
        let keyForRandomNews = "isAlreadyCreated"
        
        let checker =  UserDefaults.standard.bool(forKey: keyForRandomNews)
        
        guard checker == false else { return }
        
        let news1 = News(text: nil, image: newsImageArray[0], likesCount: newsLikesArray[0], commentsCount:newsCommentsArray[0], repostsCount: newsRepostsArray[0], name: nameLabel.text!, surname: surnameLabel.text!, date: newsDateArray[Int(arc4random_uniform(UInt32(newsDateArray.count)))], id: UUID().uuidString, user_id: userRegistration.id )
        let news2 = News(text: newsTextArray[1], image: nil, likesCount: newsLikesArray[1], commentsCount:newsCommentsArray[1], repostsCount: newsRepostsArray[1], name: nameLabel.text!, surname: surnameLabel.text!, date: newsDateArray[Int(arc4random_uniform(UInt32(newsDateArray.count)))], id: UUID().uuidString, user_id: userRegistration.id)
        let news3 = News(text: newsTextArray[2], image: newsImageArray[2], likesCount: newsLikesArray[2], commentsCount:newsCommentsArray[2], repostsCount: newsRepostsArray[2], name: nameLabel.text!, surname: surnameLabel.text!, date: newsDateArray[Int(arc4random_uniform(UInt32(newsDateArray.count)))], id: UUID().uuidString, user_id: userRegistration.id)
        
        testID = news3.id
        
        UserDefaults.standard.set(true, forKey: keyForRandomNews)
    }
    
    //MARK: Register custom cell
    
    func cellRegistration() {
        
        let newsCellNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        tableView.register(newsCellNib, forCellReuseIdentifier: noteCellIdentifier)
        
        let aboutCellNib = UINib(nibName: "AboutUserCollectionViewCell", bundle: nil)
        aboutCollectionView.register(aboutCellNib, forCellWithReuseIdentifier: aboutCellIdentifier)
        
        let userPhotoCellNib = UINib(nibName: "UserPhotoCollectionViewCell", bundle: nil)
        userPhotosCollectionView.register(userPhotoCellNib, forCellWithReuseIdentifier: userPhotosCellIdentifier)
        
        
    }

    @IBAction func moreInfoButtonPressed(_ sender: Any) {
        
        present(showMoreInfoAlert(), animated: true, completion: nil)
    }
    
    func setNavigationBarColorAndFont(){
        navigationController?.navigationBar.barTintColor = navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    //MARK: Random fill arrays
    
    func randomName() {
        
        nameLabel.text = nameArray[Int(arc4random_uniform(UInt32(nameArray.count)))]
        navigationItem.title = nameLabel.text
        nameLabel.sizeToFit()
        
    }
    
    func randomSurname() {
        
        surnameLabel.text = surnameArray[Int(arc4random_uniform(UInt32(surnameArray.count)))]
        surnameLabel.sizeToFit()
        
    }
    
    func randomAge() {
        
        ageLabel.text = ageArray[Int(arc4random_uniform(UInt32(ageArray.count)))]
        ageLabel.sizeToFit()
        
    }
    
    func randomLocation() {
        
        locationLabel.text = locationArray[Int(arc4random_uniform(UInt32(locationArray.count)))]
        locationLabel.sizeToFit()
        
    }
    
    //MARK: Button and Scroll Borders
    
    func topAboutCollectionViewBorder() {
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: 0, y: 0, width: aboutCollectionView.frame.width, height: borderThickness)
        aboutCollectionView.layer.addSublayer(border)
    }
    
    func bottomAboutCollectionViewBorder() {
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: 0, y: aboutCollectionView.frame.height - borderThickness, width: aboutCollectionView.frame.width, height: borderThickness)
        aboutCollectionView.layer.addSublayer(border)
    }
    
    func bottomUserPhotosCollectionViewBorder() {
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: 0, y: userPhotosCollectionView.frame.height - borderThickness, width: userPhotosCollectionView.frame.width, height: borderThickness)
        userPhotosCollectionView.layer.addSublayer(border)
    }
    
    func photoButtonBorder() {
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: photoButton.frame.width - borderThickness, y: 0, width: borderThickness, height: photoButton.frame.height)
        
        photoButton.layer.addSublayer(border)
    }
    
    func noteButtonBorder() {
        
        let border = CALayer()
        border.backgroundColor = borderColor
        border.frame = CGRect(x: noteButton.frame.width - borderThickness, y: 0, width: borderThickness, height: noteButton.frame.height)
        
        noteButton.layer.addSublayer(border)
        
    }
    
    //MARK: DataTransferProtocol
    
    func didPressDone(with note: String) {
        let tempNews = News(text: note, image: newsImageArray[Int(arc4random_uniform(UInt32(newsImageArray.count)))], likesCount: newsLikesArray[Int(arc4random_uniform(UInt32(newsLikesArray.count)))], commentsCount: newsCommentsArray[Int(arc4random_uniform(UInt32(newsCommentsArray.count)))], repostsCount: newsRepostsArray[Int(arc4random_uniform(UInt32(newsRepostsArray.count)))], name: nameLabel.text!, surname: surnameLabel.text!, date: newsDateArray[Int(arc4random_uniform(UInt32(newsDateArray.count)))], id: UUID().uuidString, user_id: userRegistration.id)
        
        newsManager.asyncSave(with: tempNews) {[weak self] (isSaved) in
            guard let strongSelf = self else { return }
            if (isSaved) {
                strongSelf.news = strongSelf.newsManager.syncGetAll()!

                    DispatchQueue.main.async {
                        strongSelf.tableView.reloadData()
                    }
                }
            }
        }

    
    //MARK: TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: noteCellIdentifier) as! NewsTableViewCell
        
        let newsModel = news.reversed()[indexPath.row]
        
        cell.prepare(with: newsModel)
        
        return cell
    }
    
    //MARK: CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == aboutCollectionView {
            return types.count
        }
        
        if collectionView == userPhotosCollectionView {
            return userPhotosCount
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == aboutCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: aboutCellIdentifier, for: indexPath) as! AboutUserCollectionViewCell
            cell.prepareCell(with: types[indexPath.row])
            
            return cell
        }
        
        if collectionView == userPhotosCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: userPhotosCellIdentifier, for: indexPath) as! UserPhotoCollectionViewCell
            cell.prepareCell(with: userPhotosArray[Int(arc4random_uniform(UInt32(userPhotosArray.count)))])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row ==  types.index(of: .followers) {
            performSegue(withIdentifier: followersSequeIdentifier, sender: nil)
        }
    }
    
    //MARK: Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == infoSequeIdentifier {
            let profileVC = segue.destination as! InformationAboutUserTableViewController
            profileVC.name = (nameLabel.text)!
            profileVC.surname = (surnameLabel.text)!
            profileVC.age = (ageLabel.text)!
            profileVC.location = (locationLabel.text)!
            profileVC.avatarFrom = avatar.image!
        }
        
        if segue.identifier == noteSequeIdentifier {
            let controller = segue.destination as! NoteViewController
            controller.dataTransferDelagete = self
        }
    
        if segue.identifier == testSugueIdentifir {
            let testController = segue.destination as! TestViewController
            testController.id = testID
        }
    }
    
}


