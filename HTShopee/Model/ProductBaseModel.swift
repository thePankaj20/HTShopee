//
//  ProductBaseModel.swift
//  HTShopee
//
//  Created by Pankaj Kaluram Kumhar on 04/07/20.
//  Copyright © 2020 Pankaj Kumhar. All rights reserved.
//

import Foundation
struct ProductBaseModel : Codable {
    let categories : [Categories]?
    let rankings : [Rankings]?

    enum CodingKeys: String, CodingKey {

        case categories = "categories"
        case rankings = "rankings"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        rankings = try values.decodeIfPresent([Rankings].self, forKey: .rankings)
    }

}


struct Categories : Codable {
    let id : Int?
    let name : String?
    let products : [Products]?
    let child_categories : [Int]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case products = "products"
        case child_categories = "child_categories"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
        child_categories = try values.decodeIfPresent([Int].self, forKey: .child_categories)
        print("")
    }

}


struct Products : Codable {
    let id : Int?
    let view_count : Int?
    let name: String?
    let date_added: String?
    let shares : Int?
    let order_count : Int?
    let variant: [Variants]?
    let tax: Tax?
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case view_count = "view_count"
        case name = "name"
        case date_added = "date_added"
        case shares = "shares"
        case order_count = "order_count"
        case variant = "variants"
        case tax = "tax"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        view_count = try values.decodeIfPresent(Int.self, forKey: .view_count)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
        shares = try values.decodeIfPresent(Int.self, forKey: .shares)
        order_count = try values.decodeIfPresent(Int.self, forKey: .order_count)
        variant = try values.decodeIfPresent([Variants].self, forKey: .variant)
        tax = try values.decodeIfPresent(Tax.self, forKey: .tax)
    }

}

struct Rankings : Codable {
    let ranking : String?
    let products : [Products]?

    enum CodingKeys: String, CodingKey {

        case ranking = "ranking"
        case products = "products"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ranking = try values.decodeIfPresent(String.self, forKey: .ranking)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
    }

}

struct Tax : Codable {
    let name : String?
    var value : Double?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        if let taxValue = try values.decodeIfPresent(Double.self, forKey: .value) {
            value = taxValue
        } else if let taxValue = try values.decodeIfPresent(Int.self, forKey: .value) {
            value = Double(taxValue)
        }
    }

}


struct Variants : Codable {
    let id : Int?
    let color : String?
    let size : Int?
    let price : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case color = "color"
        case size = "size"
        case price = "price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
    }

}
