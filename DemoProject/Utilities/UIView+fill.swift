//
//  UIView+fill.swift
//  DemoProject
//
//  Created by Zhang, Mark on 21/8/2023.
//

import UIKit

extension UIView {
    enum AlignTo {
        case view
        case margin

        func leadingAnchor(of view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case .view: return view.leadingAnchor
            case .margin: return view.layoutMarginsGuide.leadingAnchor
            }
        }

        func trailingAnchor(of view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case .view: return view.trailingAnchor
            case .margin: return view.layoutMarginsGuide.trailingAnchor
            }
        }

        func topAnchor(of view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case .view: return view.topAnchor
            case .margin: return view.layoutMarginsGuide.topAnchor
            }
        }

        func bottomAnchor(of view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case .view: return view.bottomAnchor
            case .margin: return view.layoutMarginsGuide.bottomAnchor
            }
        }
    }

    func fill(with childView: UIView, padding: UIEdgeInsets = .zero, alignTo: AlignTo = .view) {
        childView.translatesAutoresizingMaskIntoConstraints = false

        if !subviews.contains(childView) {
            addSubview(childView)
        }

        NSLayoutConstraint.activate([
            childView.leadingAnchor.constraint(
                equalTo: alignTo.leadingAnchor(of: self),
                constant: padding.left
            ),
            childView.trailingAnchor.constraint(
                equalTo: alignTo.trailingAnchor(of: self),
                constant: -padding.right
            ),
            childView.topAnchor.constraint(
                equalTo: alignTo.topAnchor(of: self),
                constant: padding.top
            ),
            childView.bottomAnchor.constraint(
                equalTo: alignTo.bottomAnchor(of: self),
                constant: -padding.bottom
            )
        ])
    }
}
