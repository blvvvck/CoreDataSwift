//
//  InformationAboutUserTableViewController.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 21/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class InformationAboutUserTableViewController: UITableViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var items: [InformationViewModelItem] = []
    let mainInfoCellIdentifier = "mainInfoCell"
    let statusCellIdentifier = "statusCell"
    let contactsCellIdentifier = "contactCell"
    let carierCellIdentifier = "carierCell"
    let educationCellIdentifier = "educationCell"
    let giftsCellIdentifier = "giftsCell"
    let moreInfoCellIdentifier = "moreInfoCell"
    
    let contactsCellHeight: CGFloat = 40
    let carierCellHeight: CGFloat = 78
    let mainInfoCellHeight: CGFloat = 53
    let giftsCellHeight: CGFloat = 110
    let defaultCellHeight: CGFloat = 44
    let educationCellHeight: CGFloat = 49
    
    let statusArray = ["NAVI VPERED!!!", "VP TOP1", "DOMOIII"]
    let mainInfoTitleArray = ["День рождения", "Место работы", "Семейное положение", "Языки", "Родители"]
    let mainInfoSubtitleArray = [ ["21 июля 1998", "16 января 2000"], ["Apple", "Google"], ["Женат", "Есть подруга"], ["Русский, Испанский", "Английский, Итальянский"], ["Иван Иванов, Мария Иванова", "Петр Петров, Анна Петрова"] ]
    let contactArray = [ ["89536777391", "89005258501"], ["Киров", "Казань"], ["super_nagibator", "ios_NINJA"] ]
    let contactImageArray = [UIImage(named: "phoneContact")!, UIImage(named: "homeContact")!, UIImage(named: "vkContact")!]
    let giftsImageArray = [UIImage(named: "gift1")!, UIImage(named: "gift2")!, UIImage(named: "gift3")!, UIImage(named: "gift1")!]
    let carierCompanyArray = ["Apple", "Google",]
    let carierLocationAndPeriodArray = ["Cupertino, 2016-2017", "Kirov, 2000-2001"]
    let carierPositionArray = ["iOS Developer", "Java Developer"]
    let educationTypeArray = ["Вуз", "Школа"]
    let educationNameArray = [ ["КФУ", "ВятГУ", "MIT"], ["Школа №10", "ФизМат Лицей"] ]
    let giftsNumberArray = ["20 подарков", "21 подарок", "16 подарков"]
    let moreInfoTitleArray = ["Интересные страницы", "Заметки", "Документы"]
    let moreInfoCountArray = [["102", "131", "116"], ["321", "123"], ["401", "291"]]
    
    var name: String = ""
    var surname: String = ""
    var age: String = ""
    var location: String = ""
    var avatarFrom: UIImage = UIImage(named: "gift1")!
    
    let radiusRoundCorner: CGFloat = 50
    let rightBarButtonImage = UIImage(named: "17223")
    let rightBarButtonFrame = CGRect(x: 0, y: 0, width: 30, height: 30)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initStatus()
        initMainInfo()
        initContacts()
        initCarier()
        initEdicational()
        initGifts()
        initMoreInfo()
        profileFromMainView()
        setupRefreshControl()
        cellRegistration()
        setRightBarButtonImageAndAction()
        setNavigationBarTitle()
    }
    
    func setRightBarButtonImageAndAction() {
        let btn1 = UIButton(type: .custom)
        btn1.addTarget(self, action: "moreInfoButtonPressed", for: .touchUpInside)
        btn1.setImage(rightBarButtonImage, for: .normal)
        btn1.frame = rightBarButtonFrame
        let item1 = UIBarButtonItem(customView: btn1)
        navigationItem.setRightBarButton(item1, animated: true)
    }
    
    func moreInfoButtonPressed() {
        present(showMoreInfoAlert(), animated: true, completion: nil)
    }
    
    func setNavigationBarTitle() {
        navigationItem.title = name
    }
    
    func cellRegistration() {
        
        let statusCellNib = UINib(nibName: "StatusTableViewCell", bundle: nil)
        tableView.register(statusCellNib, forCellReuseIdentifier: statusCellIdentifier)
        
        let mainInfoCellNib = UINib(nibName: "MainInfoTableViewCell", bundle: nil)
        tableView.register(mainInfoCellNib, forCellReuseIdentifier: mainInfoCellIdentifier)
        
        let contactsCellNib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        tableView.register(contactsCellNib, forCellReuseIdentifier: contactsCellIdentifier)
        
        let carierCellNib = UINib(nibName: "CarierTableViewCell", bundle: nil)
        tableView.register(carierCellNib, forCellReuseIdentifier: carierCellIdentifier)
        
        let educationCellNib = UINib(nibName: "EducationTableViewCell", bundle: nil)
        tableView.register(educationCellNib, forCellReuseIdentifier: educationCellIdentifier)
        
        let giftsCellNib = UINib(nibName: "GiftsTableViewCell", bundle: nil)
        tableView.register(giftsCellNib, forCellReuseIdentifier: giftsCellIdentifier)
        
        let moreIndoCellNib = UINib(nibName: "MoreInfoTableViewCell", bundle: nil)
        tableView.register(moreIndoCellNib, forCellReuseIdentifier: moreInfoCellIdentifier)
        
    }
    
    func setupRefreshControl(){
        refreshControl?.addTarget(self, action: #selector(self.handleRefresh(refreshControl:)), for: .valueChanged)
    }
    
    func profileFromMainView() {
        nameLabel.text = name
        surnameLabel.text = surname
        ageLabel.text = age
        locationLabel.text = location
        avatarImageView.image = avatarFrom
        avatarImageView.roundCorners([.topRight, .topLeft, .bottomRight, .bottomLeft], radius: radiusRoundCorner)
        nameLabel.sizeToFit()
        surnameLabel.sizeToFit()
        ageLabel.sizeToFit()
        locationLabel.sizeToFit()
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        items.removeAll()
        initStatus()
        initMainInfo()
        initContacts()
        initCarier()
        initEdicational()
        initGifts()
        initMoreInfo()
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //MARK: Init methods

    func initStatus() {
        let status = InformationViewModelStatusItem(status: "\(statusArray[Int(arc4random_uniform(UInt32(statusArray.count)))])")
        items.append(status)
    }
    
    func initMainInfo() {
        var mainInformations = [MainInfo]()
        
        for i in 0 ..< 5 {
            let mainInfo = MainInfo(title: "\(mainInfoTitleArray[i])", info: "\(mainInfoSubtitleArray[i][Int(arc4random_uniform(UInt32(mainInfoSubtitleArray[i].count)))])")
            mainInformations.append(mainInfo)
        }
        
        items.append(InformationViewModelMainInfoItem(mainInformations: mainInformations))
    }
    
    func initContacts() {
        
        var contactsInformation = [Contacts]()
        
        for i in 0 ..< 3 {
            let contactInfo = Contacts(image: contactImageArray[i], contact: "\(contactArray[i][Int(arc4random_uniform(UInt32(contactArray[i].count)))])")
            contactsInformation.append(contactInfo)
        }
        items.append(InformationViewModelContactsItem(contacts: contactsInformation))
    }
    
    func initCarier() {
        let carierInfo = InformationViewModelCarierItem(company: "\(carierCompanyArray[Int(arc4random_uniform(UInt32(carierCompanyArray.count)))])", locationAndPeriod: "\(carierLocationAndPeriodArray[Int(arc4random_uniform(UInt32(carierLocationAndPeriodArray.count)))])", position: "\(carierPositionArray[Int(arc4random_uniform(UInt32(carierPositionArray.count)))])")
        items.append(carierInfo)
    }
    
    func initEdicational() {
        var educationInformation = [EducationalEstablishments]()
        for i in 0 ..< 2 {
            let educationalInfo = EducationalEstablishments(type: "\(educationTypeArray[i])", name: "\(educationNameArray[i][Int(arc4random_uniform(UInt32(educationNameArray.count)))])")
            educationInformation.append(educationalInfo)
        }
        items.append(InformationViewModelEducationItem(educationaEstablishments: educationInformation))
    }
    
    func initGifts() {
        let gifts = InformationViewModelGiftsItem(giftNumbers: "\(giftsNumberArray[Int(arc4random_uniform(UInt32(giftsNumberArray.count)))])")
        items.append(gifts)
    }
    
    func initMoreInfo() {
        var moreInformation = [MoreInfo]()
        
        for i in 0 ..< 3 {
            let moreInfo = MoreInfo(title: "\(moreInfoTitleArray[i])", count: "\(moreInfoCountArray[i][Int(arc4random_uniform(UInt32(moreInfoCountArray[i].count)))])" )
            moreInformation.append(moreInfo)
        }
        items.append(InformationViewModelMoreInfoItem(moreInformations: moreInformation))
    }
    
    //MARK: Table View Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return items.count
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items[section].rowCount
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item.type {
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier: statusCellIdentifier, for: indexPath) as! StatusTableViewCell
            cell.prepateCell(with: item as! InformationViewModelStatusItem)
            return cell
            
        case .mainInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: mainInfoCellIdentifier, for: indexPath) as! MainInfoTableViewCell
            let mainInfoItemModel = item as! InformationViewModelMainInfoItem
            cell.prepareCell(with: mainInfoItemModel.mainInformations[indexPath.row])
            return cell
            
        case .contacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: contactsCellIdentifier, for: indexPath) as! ContactsTableViewCell
            let contactInfoItemModel = item as! InformationViewModelContactsItem
            cell.prepareCell(with: contactInfoItemModel.contacts[indexPath.row])
            return cell
            
        case .carier:
            let cell = tableView.dequeueReusableCell(withIdentifier: carierCellIdentifier, for: indexPath) as! CarierTableViewCell
            cell.prepareCell(with: item as! InformationViewModelCarierItem)
            return cell
            
        case .education:
            let cell = tableView.dequeueReusableCell(withIdentifier: educationCellIdentifier, for: indexPath) as! EducationTableViewCell
            let educationInfoItemModel = item as! InformationViewModelEducationItem
            cell.prepareCell(with: educationInfoItemModel.educationaEstablishments[indexPath.row])
            return cell
            
        case .gifts:
            let cell = tableView.dequeueReusableCell(withIdentifier: giftsCellIdentifier, for: indexPath) as! GiftsTableViewCell
            cell.prepareCell(with: item as! InformationViewModelGiftsItem)
            cell.gifts = giftsImageArray
            return cell
            
        case .moreInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: moreInfoCellIdentifier, for: indexPath) as! MoreInfoTableViewCell
            let moreInfoItemModel = item as! InformationViewModelMoreInfoItem
            cell.prepareCell(with: moreInfoItemModel.moreInformations[indexPath.row])
            return cell
                        
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return items[section].sectionType
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .contacts:
            return contactsCellHeight
        
        case .carier:
            return carierCellHeight
            
        case .mainInfo:
            return mainInfoCellHeight
            
        case .gifts:
            return giftsCellHeight
        
        case .education:
            return educationCellHeight
            
        default:
            return defaultCellHeight
        }
    }
}
