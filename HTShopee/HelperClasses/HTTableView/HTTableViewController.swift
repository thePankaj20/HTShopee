//
//  HTTableViewController.swift
//  HT
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class HTTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    final var tableViewModel: HTTableViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.isHidden = false
                self.tableView?.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.estimatedRowHeight = 44.0
        registerNibs()
        tableViewModel = createTableViewModel()
    }
    
    //MARK:
    //MARK: override methods
    func registerNibs() {
        // Override in all child classes
    }
    
    func createTableViewModel() -> HTTableViewModel {
        return HTTableViewModel()
    }
    
    func reloadTableView() {
        tableViewModel = createTableViewModel()
    }
    
    
    //MARK:
    //MARK: UITableView Delegates
    final func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewModel?.sectionModels.count ?? 0
    }
    
    final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = tableViewModel?.sectionModels[section]
        return sectionModel?.cellModels.count ?? 0
    }
    
    final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = tableViewModel?.sectionModels[indexPath.section]
        guard let cellModel = sectionModel?.cellModels[indexPath.row] else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.reuseIdentifier, for: indexPath) as? HTTableViewCell else { return UITableViewCell() }
        cell.configureCell(cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = tableViewModel?.sectionModels[indexPath.section]
        if let cellModel = sectionModel?.cellModels[indexPath.row], let height = cellModel.height {
            return height
        }
        return UITableView.automaticDimension
    }
    
    //MARK: - As per requirement
    func scrollToTopOfScreen() {
        let topOffest = CGPoint(x: 0, y: -(self.tableView?.contentInset.top ?? 0.0))
        self.tableView?.setContentOffset(topOffest, animated: true)
    }
}
