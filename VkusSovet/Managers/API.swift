//
//  API.swift
//  VkusSovet
//
//  Created by Ilya on 30.09.2023.
//

import Foundation


enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum HTTPScheme: String {
    case http
    case https
}


protocol APIManager {
    // .http  or .https
    var scheme: HTTPScheme { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem] { get }
    // "GET"
    var method: HTTPMethod { get }
}


enum API: APIManager {
    case getCategories(Void)
    case getFoods(menuID: String)
    
    var scheme: HTTPScheme {
        switch self {
        case .getCategories, .getFoods:
            return .https
        } }
    
    var baseURL: String {
        switch self {
        case  .getCategories, .getFoods:
            return "vkus-sovet.ru"
        } }
    
    var path: String {
        switch self {
        case .getCategories:
            return "/api/getMenu.php"
        case .getFoods:
            return "/api/getSubMenu.php"
        } }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getFoods(let id):
            let params = [
                URLQueryItem(name: "menuID", value: id),
            ]
            return params
        case .getCategories():
            return []
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getCategories, .getFoods:
            return .get
        } }
}



