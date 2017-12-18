//
//  GiftsTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 24/09/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

class GiftsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var giftsNumberLabel: UILabel!
    @IBOutlet weak var giftsCollectionView: UICollectionView!
    let giftCellIdentifier = "giftCellIdentifier"
    var gifts: [UIImage]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
        setDelegateAndDataSource()
    }
    
    func registerCells() {
        let giftsCellNib = UINib(nibName: "GiftCollectionViewCell", bundle: nil)
        giftsCollectionView.register(giftsCellNib, forCellWithReuseIdentifier: giftCellIdentifier)
    }
    
    func setDelegateAndDataSource() {
        giftsCollectionView.delegate = self
        giftsCollectionView.dataSource = self
    }
    
    func prepareCell(with item: InformationViewModelGiftsItem) {
        giftsNumberLabel.text = item.giftNumbers
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: giftCellIdentifier, for: indexPath) as! GiftCollectionViewCell
        cell.prepareCell(with: gifts[Int(arc4random_uniform(UInt32(gifts.count)))] )
        return cell
    }
}
