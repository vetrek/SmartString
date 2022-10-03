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
        let label = UILabel()

//        label.smartString = "a".font(.systemFont(ofSize: 12))
//        + " Bold".font(UIFont(name: "HelveticaNeue-Bold", size: 17)!)
//        + " normal".onTap { str in
//            label.smartString = "ciao".smartString.onTap(closure: { _ in
//                print(label.font)
//            })
//        }
        
//        label.smartString = "<primary>Hello </primary><secondary>world!</secondary>".smartStringXML
        
//        let xmlString = "Hello ".tag(XMLStringStyles.primary) + "world! ".tag(XMLStringStyles.secondary)
//        label.smartString = "Add ".appendImage(UIImage(systemName: "plus")!.withTintColor(.white), height: 16)
//        + " or Import ".appendImage(UIImage(systemName: "square.and.arrow.down")!.withTintColor(.white), height: 16)
//        + "\n what you need"
        
        let str: SmartString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do ".color(.red).onTap(closure: { str in
            print(str)
        })
        + "eiusmod tempor incididunt " + "ut labore et dolore magna".color(.black).onTap(closure: { str in
            print(str)
        }) + "aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

        label.smartString = str
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.center(in: view)
        label.backgroundColor = .green
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

