//
//  Extensions.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 05/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import UIKit
protocol ReuseIdentifier : class {
    
}
extension ReuseIdentifier where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadableView : class{
    
}
extension NibLoadableView where Self : UIView {
    static var nibName : String {
        return String(describing: self)
    }
    
}

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        // get a class name and demangle for classes in Swift
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
}
extension UITableView {
    func register<T>(cell : T.Type) where T : ReuseIdentifier,T : UITableViewCell , T : NibLoadableView {
        register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T where T : UITableViewCell, T : ReuseIdentifier {
        guard  let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(type(of: self)) Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }

}

extension UIView{
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
