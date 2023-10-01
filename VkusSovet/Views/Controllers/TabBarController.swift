//
//  TabBarController.swift
//  VkusSovet
//
//  Created by Ilya on 01.10.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .systemOrange
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .black
        
        setupTabs()
        
    }
    
    private func createNav(image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = image
        return nav
    }
    
    private func setupTabs() {
        let main = self.createNav(image: UIImage(systemName: "list.bullet"), vc: MainViewController())
        let second = self.createNav(image: UIImage(systemName: "bag"), vc: UIViewController())
        let third = self.createNav(image: UIImage(systemName: "info"), vc: UIViewController())
        
        self.setViewControllers([main, second, third], animated: true)
    }
    
}
