//
//  HTTableViewCell.swift
//  HT
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

protocol HTTableViewCellProtocol: class {
    func configureCell(_ model: HTTableViewCellModel)
}

class HTTableViewCell: UITableViewCell, HTTableViewCellProtocol {
    
    func configureCell(_ model: HTTableViewCellModel) {
    }
}
