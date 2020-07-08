//
//  RankingListTableViewCell.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class RankingListTableViewCell: HTTableViewCell, ReuseIdentifier ,NibLoadableView {

    static let reuseIdentifier: String = Constants.RankingListTableViewCellIdentifier
    @IBOutlet var collectionView: UICollectionView!
    var rankingsArray: [Rankings]?
    weak var delegate: ProductListProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "RankingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.RankingCollectionViewCellIdentifier)
    }
    override func configureCell(_ model: HTTableViewCellModel) {
        super.configureCell(model)
        rankingsArray = (model as? RankingListTableViewCellModel)?.rankingArray
        delegate = (model as? RankingListTableViewCellModel)?.delegate
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}
extension RankingListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.RankingCollectionViewCellIdentifier, for: indexPath) as! RankingCollectionViewCell
        cell.configureCell(title: rankingsArray![indexPath.item].ranking!)
        return cell
    }
    
    
}
extension RankingListTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3) - 10, height: (collectionView.frame.width/3) - 10)
    }
}
extension RankingListTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.rankingCellTapped(ranking: rankingsArray![indexPath.item])
    }
}
