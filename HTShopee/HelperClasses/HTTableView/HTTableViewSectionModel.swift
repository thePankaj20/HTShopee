//
//  HTTableViewSectionModel.swift
//  HT
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation

class HTTableViewSectionModel: NSObject {
    
    var cellModels = [HTTableViewCellModel]()
    var index: Int?
    
    convenience init(index: Int) {
        self.init()
        self.index = index
    }
    
    func removeAllCells() {
        cellModels.removeAll()
    }
    
    func removeCellAtIndex(_ index: Int) {
        cellModels.remove(at: index)
    }
    
    func removeAllCellsOtherThanIndex(_ index: Int) {
        for i in 0...(cellModels.count - 1) {
            if i != index {
                cellModels.remove(at: i)
            }
        }
    }
    
    func addCellModel(_ cellModel: HTTableViewCellModel, atIndex index: Int) {
        if index >= 0 && index <= cellModels.count {
            cellModels.insert(cellModel, at: index)
        }
    }
    
    func addCellModel(_ cellModel: HTTableViewCellModel) {
        cellModels.append(cellModel)
    }
    
    func addCellModels(_ cellModelArray: [HTTableViewCellModel]) {
        for cellModel in cellModelArray {
            addCellModel(cellModel)
        }
    }
}
