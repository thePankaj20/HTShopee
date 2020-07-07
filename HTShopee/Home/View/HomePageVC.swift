//
//  ViewController.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 04/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class HomePageVC: HTTableViewController {

    var viewModel: HomePageViewModel?
    private var refreshControl:UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()// 
        viewModel = HomePageViewModel()
        tableView.register(cell: CategoryTableViewCell.self)
        tableView.register(cell: RankingListTableViewCell.self)
        fetchData()
        initRefreshControl()
    }
    override func createTableViewModel() -> HTTableViewModel {
        let htTableViewModel = HTTableViewModel()
        if viewModel != nil {
            if viewModel?.prodcutResp?.rankings != nil {
                htTableViewModel.addCellModel(RankingListTableViewCellModel(rankingArray: (viewModel?.prodcutResp?.rankings!)!, delegate: self))
            }
            for category in viewModel?.prodcutResp?.categories ?? [] {
                htTableViewModel.addCellModel(CategoryTableViewCellModel(category: category))
            }
        }
        return htTableViewModel
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = viewModel?.prodcutResp?.categories?[indexPath.row - 1]
        viewModel?.navigateAsPerSubcategories(viewController: self, selectedCat: category!)
    }
    @objc func fetchData(){
        viewModel?.getProductInfo(completionHandler: { (resp, error) in
            if error == nil {
                self.reloadTableView()
                self.refreshControl.endRefreshing()
            }
        })
    }
    private func initRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        self.refreshControl.addTarget(self, action: #selector(fetchData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
}
extension HomePageVC: ProductListProtocol {
    func rankingCellTapped(ranking: Rankings) {
        let arrProducts = viewModel?.getRankingwiseProduct(ranking: ranking) ?? []
        viewModel?.moveToProductList(viewController: self, productArray: arrProducts, titleString: ranking.ranking!)
    }
}
