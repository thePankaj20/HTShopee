//
//  ProductListVC.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class ProductListVC: HTTableViewController {

    var arrProducts: [Products]?
    var rankingArray: [Rankings]?
    var selectedProduct: Products?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cell: ProductTableViewCell.self)
    }
   //MARK:- Table view methods
    override func createTableViewModel() -> HTTableViewModel {
        let htTableViewModel = HTTableViewModel()
        for prodcut in arrProducts ?? []{
            htTableViewModel.addCellModel(ProductTableViewCellModel(productObj: prodcut))
        }
        return htTableViewModel
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = arrProducts![indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    //MARK:- Segue navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ProductDetailsVC
        vc.selectedProduct = selectedProduct
    }
}
