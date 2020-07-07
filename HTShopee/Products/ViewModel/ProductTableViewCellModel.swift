//
//  ProductTableViewCellModel.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation
class ProductTableViewCellModel: HTTableViewCellModel{
    var productObj: Products?
    init(productObj: Products) {
        self.productObj = productObj
        super.init(reuseIdentifier: ProductTableViewCell.reuseIdentifier)
    }
}
