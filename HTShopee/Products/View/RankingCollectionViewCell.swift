//
//  RankingCollectionViewCell.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class RankingCollectionViewCell: UICollectionViewCell {

    @IBOutlet var lblRankingTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(title: String) {
        lblRankingTitle.text = title
    }
}
