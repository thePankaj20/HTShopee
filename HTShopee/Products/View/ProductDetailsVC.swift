//
//  ProductDetailsVC.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 07/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblProductTitle: UILabel!
    var selectedProduct: Products?
    override func viewDidLoad() {
        super.viewDidLoad()

        lblProductTitle.text = selectedProduct?.name
        // Do any additional setup after loading the view.
    }
    
}
extension ProductDetailsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedProduct?.variant?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ProductDetailsCellIdentifier, for: indexPath) as! ProductDetailsCell
        cell.configureCell(variant: (selectedProduct?.variant?[indexPath.item])!)
        return cell
    }
    
    
}
extension ProductDetailsVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/3)
    }
}
extension ProductDetailsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
