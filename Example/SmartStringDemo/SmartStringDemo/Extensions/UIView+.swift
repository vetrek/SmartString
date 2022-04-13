//
//  UIView+.swift
//  SmartStringDemo
//
//  Created by Valerio Sebastianelli on 4/13/22.
//

import UIKit

extension UIView {
    @available(iOS, introduced: 11.0)
    func fill(view: UIView, insets: UIEdgeInsets = .zero, useSafeArea: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = false
        let leading = self.leadingAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor, constant: insets.left)
        let bottom = self.bottomAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor, constant: -insets.bottom)
        let trailing = self.trailingAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor, constant: -insets.right)
        let top = self.topAnchor.constraint(equalTo: useSafeArea ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor, constant: insets.top)
        NSLayoutConstraint.activate([leading, bottom, trailing, top])
    }
    
    /**
     Adds Autolayout constraints to center `self` inside `view`
     
     - parameter view: the UIView to center in
     - parameter offset: the absolute offset from the center of `view`
     - precondition: `self` and `view` must be in the same view hierachy
     */
    func center(in view: UIView, offset: CGPoint = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        let centerHorizontally = self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.x)
        let centerVertically = self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.y)
        NSLayoutConstraint.activate([centerHorizontally, centerVertically])
    }
}
