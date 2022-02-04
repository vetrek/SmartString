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
                
        let smartString = "Hello "
            .font { .systemFont(ofSize: 18) }
            .onTap { string in
                print(string)
            }
        + "world"
            .color(.red)
            .bold()
            .onTap { string in
                print(string)
            }
        + "!"
        
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

extension String {
    var title: SmartString {
        style(.title)
    }
}
