//
//  ProductTableViewCell.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class ProductTableViewCell: HTTableViewCell, ReuseIdentifier ,NibLoadableView {

    static let reuseIdentifier: String = Constants.ProductTableViewCellIdentifier
    
    @IBOutlet var lblProductName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configureCell(_ model: HTTableViewCellModel) {
        super.configureCell(model)
        let prodcut = (model as? ProductTableViewCellModel)?.productObj
        lblProductName.text = prodcut?.name
    }
}
