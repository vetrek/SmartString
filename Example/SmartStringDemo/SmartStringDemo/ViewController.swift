//
//  ViewController.swift
//  SmartStringDemo
//
//  Created by Valerio Sebastianelli on 2/3/22.
//

import UIKit
import SmartString

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let smartString =
        "Text 1"
            .style(.title)
        + "\nText 2"
            .font { .systemFont(ofSize: 18) }
            .color { .systemPink }
        + "\nText 3"
            .style(.body)
        + "\nText 4"
            .font(.systemFont(ofSize: 52))
            .color(.orange)
            .shadow(SmartShadow())
            .toBold()
        
        let label = UILabel()
        label.smartString = smartString
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension SmartStringStyle {
    static let title = SmartStringStyle(color: .black, font: .systemFont(ofSize: 30))
    static let body = SmartStringStyle(color: .blue, font: .systemFont(ofSize: 20))
}
