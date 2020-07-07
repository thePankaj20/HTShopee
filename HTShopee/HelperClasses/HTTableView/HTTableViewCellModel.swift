//
//  HTTableViewCellModel.swift
//  HT
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation
import UIKit
class HTTableViewCellModel: NSObject {
    
    var reuseIdentifier: String
    var height: CGFloat?
    
    init(reuseIdentifier: String, height: CGFloat? = nil) {
        self.reuseIdentifier = reuseIdentifier
        self.height = height
    }
}
