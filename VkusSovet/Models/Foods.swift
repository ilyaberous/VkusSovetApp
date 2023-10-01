//
//  Foods.swift
//  VkusSovet
//
//  Created by Ilya on 30.09.2023.
//

import Foundation


struct Foods: Decodable {
    let status: Bool
    let menuList: [FoodItem]
}

struct FoodItem: Decodable {
    let id: String
    let image: String
    var name: String
    let content: String
    var price: String
    var weight: String?
    let spicy: String?
}
