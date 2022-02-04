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
        let smartString = "Hello"
            .font(.boldSystemFont(ofSize: 30))
            .color(.green)
            .underline()
            .italic()
            .shadow(.default)
        + " world!"
            .font(.systemFont(ofSize: 24))
            .color(.purple)
        
//        let smartString = "Hello "
//            .font(.boldSystemFont(ofSize: 30))
//            .color(.blue)
//        + "world!"
//            .font(.systemFont(ofSize: 16))
//            .color(.red)
        
//        let smartString =
//        "1"
//            .font { .systemFont(ofSize: 18) }
//            .onTap { string in
//                print(string)
//            }
//        + "\n2"
//            .onTap { string in
//                print(string)
//            }
//        + "\n3"
//            .font { .systemFont(ofSize: 18) }
//            .color { .systemPink }
//        + "\n4"
//            .title
//            .color(.systemGreen)
//        + "\n5"
//            .font(.systemFont(ofSize: 52))
//            .color(.orange)
//            .shadow(SmartShadow())
//            .bold()
//            .background {
//                .red
//            }
//            .onTap { string in
//                print(string)
//            }
        
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
