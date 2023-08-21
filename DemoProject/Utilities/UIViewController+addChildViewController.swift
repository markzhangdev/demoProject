//
//  UIViewController+addChildViewController.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)

        if let childView = child.view {
            containerView.fill(with: childView)
        }
    }
}
