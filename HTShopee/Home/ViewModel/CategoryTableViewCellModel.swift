//
//  CategoryTableViewCellModel.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation
class CategoryTableViewCellModel: HTTableViewCellModel {
    var category: Categories?
    init(category: Categories) {
        self.category = category
        super.init(reuseIdentifier: CategoryTableViewCell.reuseIdentifier)
    }
}
