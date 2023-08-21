//
//  Coordinator.swift
//  DemoProject
//
//  Created by Zhang, Mark on 22/8/2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class InvoiceMainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = InvoiceListContainerViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
