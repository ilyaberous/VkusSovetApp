//
//  MenuCategory.swift
//  VkusSovet
//
//  Created by Ilya on 30.09.2023.
//

import Foundation


struct Categories: Decodable {
    let status: Bool
    let menuList: [CategoryItem]
}

struct CategoryItem: Decodable {
    let menuID : String
    let image: String
    let name: String
    let subMenuCount: Int
}
