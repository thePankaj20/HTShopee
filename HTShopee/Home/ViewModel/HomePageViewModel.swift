//
//  HiomePageViewModel.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 05/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class HomePageViewModel {
    
    var prodcutResp: ProductBaseModel?
    
    func getProductInfo(completionHandler : @escaping(ProductBaseModel?,Error?)->Void ) {
        
        fetchDataFromLocalDB { (respData, eroor) in
            if respData != nil {
                self.prodcutResp = respData
                completionHandler(self.prodcutResp,nil)
            } else {
                var sessionTask : URLSessionTask?
                sessionTask?.cancel()
                sessionTask = NetworkManager.shared.getData(url: URL.init(string: Constants.prodcutDataAPI)! ) { (data, error) in
                    if let error = error  {
                        DispatchQueue.main.async {
                            completionHandler(nil , error)
                        }
                    }else{
                        guard let unwrappedData = data else {
                            DispatchQueue.main.async {
                                completionHandler(nil,nil);
                            }
                            return
                        }
                        do {
                            let jsonDecoder = JSONDecoder.init()
                            let jsonObjet = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [String:AnyObject]
                            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObjet!)
                            let jsonString = String.init(data: jsonData!, encoding: String.Encoding.utf8)
                            self.prodcutResp = try jsonDecoder.decode(ProductBaseModel.self, from: unwrappedData)
                            DispatchQueue.main.async {
                                self.saveDataToLocalDB(productData: jsonString ?? "")
                                completionHandler(self.prodcutResp,nil)
                            }
                        }
                        catch {
                            DispatchQueue.main.async {
                                completionHandler(nil,error)
                            }
                        }
                    }
                    
                }
            }
        }
        
        
    }
    func saveDataToLocalDB(productData: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "ProductData",
                                       in: managedContext)!
        
        let prodcut = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
        
        prodcut.setValue(productData, forKeyPath: "data")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func fetchDataFromLocalDB(completionHandler : @escaping(ProductBaseModel?,Error?)->Void ){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ProductData")
        
        do {
            let products = try managedContext.fetch(fetchRequest)
            guard let productsData = products[0].value(forKeyPath: "data") as? String else {
                return
            }
            let jsonDecoder = JSONDecoder.init()
            let data = productsData.data(using: .utf8)
            let productModel = try jsonDecoder.decode(ProductBaseModel.self, from: data!)
            DispatchQueue.main.async {
                completionHandler(productModel,nil)
            }
        } catch let error as NSError {
            DispatchQueue.main.async {
                completionHandler(nil,error)
            }
        }
    }
    func getRankingwiseProduct(ranking: Rankings) -> [Products] {
        var arrProducts = [Products]()
        for category in self.prodcutResp?.categories ?? []{
            arrProducts.append(contentsOf: category.products?.filter{ (product) -> Bool in
                if (ranking.products?.contains(where: {$0.id == product.id}))! {
                    return true
                } else {
                    return false
                }
                } ?? [])
        }
        return arrProducts
    }
    func navigateAsPerSubcategories(viewController: UIViewController, selectedCat: Categories){
        if selectedCat.child_categories?.count ?? 0 > 0 {
            let filteredCat = self.prodcutResp?.categories?.filter{ (cat) -> Bool in
                if (selectedCat.child_categories?.contains(where: {$0 == cat.id}))! {
                    return true
                } else {
                    return false
                }
                } ?? []
            let optionMenu = UIAlertController(title: nil, message: "Choose Category", preferredStyle: .actionSheet)
            for category in filteredCat {
                let selectAction = UIAlertAction(title: category.name, style: .default) { action in
                    let category = filteredCat.filter { (cat) -> Bool in
                        return cat.name == category.name
                    }
                    if category.count > 0 {
                        self.navigateAsPerSubcategories(viewController: viewController, selectedCat: category[0])
                    }
                }
                optionMenu.addAction(selectAction)
            }
            let cancelButtonAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) -> Void in
            })
            optionMenu.addAction(cancelButtonAction)
            DispatchQueue.main.async {
                viewController.present(optionMenu, animated: true, completion: nil)
            }
            
        } else {
            moveToProductList(viewController: viewController, productArray: selectedCat.products ?? [], titleString: selectedCat.name ?? "")
        }
    }
    func moveToProductList(viewController: UIViewController,productArray: [Products], titleString: String){
        let vc = viewController.storyboard?.instantiateViewController(identifier: "ProductListVC") as! ProductListVC
        vc.rankingArray = self.prodcutResp?.rankings
        vc.arrProducts = productArray
        vc.title = titleString
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
