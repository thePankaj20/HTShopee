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
    var categoriesArray: [Categories]?
    override func viewDidLoad() {
        super.viewDidLoad()// 
        viewModel = HomePageViewModel()
        tableView.register(cell: CategoryTableViewCell.self)
        tableView.register(cell: RankingListTableViewCell.self)
        fetchData()
        initRefreshControl()
    }
    private func initRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        self.refreshControl.addTarget(self, action: #selector(fetchData), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }
    //MARK:- Table view methods
    override func createTableViewModel() -> HTTableViewModel {
        let htTableViewModel = HTTableViewModel()
        if viewModel != nil {
            
            if viewModel?.prodcutResp?.rankings != nil {
                htTableViewModel.addCellModel(RankingListTableViewCellModel(rankingArray: (viewModel?.prodcutResp?.rankings!)!, delegate: self))
            }
            for category in categoriesArray ?? [] {
                htTableViewModel.addCellModel(CategoryTableViewCellModel(category: category))
            }
        }
        return htTableViewModel
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categoriesArray?[indexPath.row - 1]
        viewModel?.navigateAsPerSubcategories(viewController: self, selectedCat: category!)
    }
    //MARK:- Data fetching
    @objc func fetchData(){
        viewModel?.getProductInfo(completionHandler: { (resp, error) in
            if error == nil {
                self.categoriesArray = self.viewModel?.prodcutResp?.categories
                self.reloadTableView()
                self.refreshControl.endRefreshing()
            }
        })
    }
}
//MARK:- Ranking cell tap action
extension HomePageVC: ProductListProtocol {
    func rankingCellTapped(ranking: Rankings) {
        let arrProducts = viewModel?.getRankingwiseProduct(ranking: ranking) ?? []
        viewModel?.moveToProductList(viewController: self, productArray: arrProducts, titleString: ranking.ranking!)
    }
}
//MARK:- SearchBar delegate methods
extension HomePageVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.text = ""
        categoriesArray = viewModel?.prodcutResp?.categories
        searchBar.endEditing(true)
        reloadTableView()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        let searchdata = searchText.isEmpty ? viewModel?.prodcutResp?.categories : viewModel?.prodcutResp?.categories?.filter {
            (item: Categories) -> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        categoriesArray = searchdata
        reloadTableView()
    }
}
