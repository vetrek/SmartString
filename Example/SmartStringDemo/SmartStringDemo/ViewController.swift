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
    
    let str: SmartString = "SmartString".align(.right).color(.black)
    + "\nSmartString!".lineHeight(40).background(.red)
    + "\nSmartString!".lineSpacing(40).charactersSpacing(10).background(.blue)
    + "\nSmartString!".align(.center).color(.black)
    
    let label = UILabel()
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
