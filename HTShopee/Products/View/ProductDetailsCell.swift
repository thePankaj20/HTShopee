//
//  ProductDetailsCell.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class ProductDetailsCell: UICollectionViewCell {
    
    @IBOutlet var lblColor: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    func configureCell(variant: Variants) {
        lblColor.text = "Color: \(variant.color ?? "Not Available")"
        lblSize.text = "Size: \(variant.size ?? 0)"
        lblPrice.text = "Price: \(variant.price ?? 0)"
    }
}
