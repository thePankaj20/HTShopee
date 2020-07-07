//
//  HTTableViewModel.swift
//  HT
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation

class HTTableViewModel: NSObject {
    
    var sectionModels = [HTTableViewSectionModel]()
    
    fileprivate func newSectionModel() -> HTTableViewSectionModel {
        let sectionModel = HTTableViewSectionModel()
        addSectionModel(sectionModel)
        return sectionModel
    }
    
    fileprivate func lastSectionModel() -> HTTableViewSectionModel? {
        if sectionModels.count > 0 {
            if let sectionModel = sectionModels.last {
                return sectionModel
            }
        }
        return nil
    }
    
    func addSectionModel(_ sectionModel: HTTableViewSectionModel) {
        sectionModels.append(sectionModel)
    }
    
    func addCellModel(_ cellModel: HTTableViewCellModel) {
        guard let sectionModel = lastSectionModel() else {
            let lastSectionModel = newSectionModel()
            addCellModel(cellModel, toSectionModel: lastSectionModel)
            return
        }
        addCellModel(cellModel, toSectionModel: sectionModel)
    }
    
    func addCellModels(_ cellModels: [HTTableViewCellModel]) {
        for cellModel in cellModels {
            addCellModel(cellModel)
        }
    }

    func addCellModel(_ cellModel: HTTableViewCellModel, atIndex index: Int) {
        lastSectionModel()?.addCellModel(cellModel, atIndex: index)
    }
    
    func addCellModel(_ cellModel: HTTableViewCellModel, toSectionModel sectionModel: HTTableViewSectionModel) {
        if !sectionModels.contains(sectionModel) {
            addSectionModel(sectionModel)
        }
        sectionModel.addCellModel(cellModel)
    }
    
    func addCellModel(_ cellModel: HTTableViewCellModel, toSectionModel sectionModel: HTTableViewSectionModel, atIndex index: Int) {
        if sectionModel.cellModels.count > index {
            sectionModel.cellModels.insert(cellModel, at: index)
        }
    }
    
    func addCellModels(_ cellModels: [HTTableViewCellModel], toSectionModel sectionModel: HTTableViewSectionModel) {
        for cellModel in cellModels {
            addCellModel(cellModel, toSectionModel: sectionModel)
        }
    }
    
    func removeSectionAtIndex(_ index: Int) {
        if sectionModels.count > index {
            sectionModels.remove(at: index)
        }
    }
    
    func removeAllSections() {
        sectionModels.removeAll()
    }
    
    func removeAllSectionsWithCells() {
        for sections in sectionModels {
            sections.removeAllCells()
        }
        sectionModels.removeAll()
    }
}
