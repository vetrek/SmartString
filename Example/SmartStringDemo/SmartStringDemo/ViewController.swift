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
        
        let xmlString = "Hello ".tag(XMLStringStyles.primary) + "world! ".tag(XMLStringStyles.secondary)
        label.smartString = xmlString.smartStringXML.appendImage(UIImage(systemName: "qrcode")!.withTintColor(.white))

        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.center(in: view)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

