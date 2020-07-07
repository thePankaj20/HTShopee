//
//  CategoryTableViewCell.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 05/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class CategoryTableViewCell: HTTableViewCell, ReuseIdentifier ,NibLoadableView {

    @IBOutlet var lblCategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell(_ model: HTTableViewCellModel) {
        super.configureCell(model)
        let category = (model as? CategoryTableViewCellModel)?.category
        lblCategoryName.text = category?.name
    }
}
