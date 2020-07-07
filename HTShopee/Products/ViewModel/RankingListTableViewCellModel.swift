//
//  RankingListTableViewCellModel.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation
protocol ProductListProtocol: class {
    func rankingCellTapped(ranking: Rankings)
}
class RankingListTableViewCellModel: HTTableViewCellModel{
    var delegate: ProductListProtocol?
    var rankingArray: [Rankings]?
    init(rankingArray: [Rankings], delegate: ProductListProtocol) {
        self.delegate = delegate
        self.rankingArray = rankingArray
        super.init(reuseIdentifier: RankingListTableViewCell.reuseIdentifier)
    }
}
