//
//  CollectionViewModel.swift
//  VkusSovet
//
//  Created by Ilya on 30.09.2023.
//

import Foundation
import UIKit

protocol CollectionViewModelDelegate: NSObject {
    func updateCollectionData()
    func setHeaderText(text: String)
}

final class CollectionViewModel {
    
    var categories: [CategoryItem] = [] {
        didSet {
            self.getFoods(for: categories[0])
            self.delegate?.setHeaderText(text: categories[0].name)
        }
    }
    var foods: [FoodItem] = [] {
        didSet {
            for i in 0..<foods.count {
                if (foods[i].weight != nil) {
                    foods[i].weight = " / \(foods[i].weight!)"
                } else {
                    foods[i].weight = ""
                }
                foods[i].price = String(format: "%.0f", Double(foods[i].price)!) + " ₽"
                foods[i].name = foods[i].name.replacingOccurrences(of: "&quot;", with: "\"")
            }
        }
    }
    
    weak var delegate: CollectionViewModelDelegate?
    
    
    func getCategories() {
        let endpoint = API.getCategories(())
        
        NetworkManager.request(endpoint: endpoint) { (result : Result<Categories, Error>) in
            switch result {
                
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let response):
                guard response.status else {
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.categories = response.menuList
                    self.delegate?.updateCollectionData()
                }
            }
        }
    }
    
    
    func getFoods(for category: CategoryItem) {
        let endpoint = API.getFoods(menuID: category.menuID)
        
        NetworkManager.request(endpoint: endpoint) { (result : Result<Foods, Error>) in
            switch result {
                
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let response):
                guard response.status else {
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.foods = response.menuList
                    self.delegate?.updateCollectionData()
                }
            }
        }
    }
}
