//
//  ViewController.swift
//
//  Copyright (c) 2021 Valerio69 (valerio.alsebas@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
        
        let style1 = SmartStringStyle { style in
            style.color = .green
            style.font = .boldSystemFont(ofSize: 30)
            style.shadow = .default
        }
                
        label.smartString = "Hello" + " world!".style(style1)

//        label.smartString = "<primary>Hello </primary><secondary>world!</secondary>".smartStringXML

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

