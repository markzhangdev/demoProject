//
//  TabBarViewController.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [self.invoiceTabBar, self.accountTabBar]
    }

    public lazy var invoiceTabBar: UINavigationController = {
        let invoiceTabBar = UINavigationController()
        
        let coordinator = InvoiceMainCoordinator(navigationController: invoiceTabBar)
        coordinator.start()
        
        let title = "Invoice List"

        let defaultImage = UIImage(systemName: "star")

        let selectedImage = UIImage(systemName: "star")

        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)

        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image, selectedImage: tabBarItems.selectedImage)

        invoiceTabBar.tabBarItem = tabBarItem

        return invoiceTabBar
    }()

    public lazy var accountTabBar: UINavigationController = {
        let accountTabBar = UINavigationController(rootViewController: AccountViewController())
        
        let title = "Account"

        let defaultImage = UIImage(systemName: "person.crop.circle")

        let selectedImage = UIImage(systemName: "person.crop.circle")

        let tabBarItem = UITabBarItem(title: "Account", image: defaultImage, selectedImage: selectedImage)

        accountTabBar.tabBarItem = tabBarItem

        return accountTabBar
    }()
}

