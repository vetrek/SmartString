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
        let smartString = "Se sono passati piu di 15 giorni dalla richiesta e non hai ancora ricevuto il pin, "
        + "contatta il tuo "
            .font(UIFont(name: "HelveticaNeue-Bold", size: 17)!)
            .bold()
            .underline()
            .italic()
            .shadow(.default)
        + "servizio clienti"
            .font(UIFont(name: "HelveticaNeue-Bold", size: 17)!)
            .bold()
            .underline()
            .onTap { str in
                print(str)
            }
        + "."
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.smartString = "smartString.color(UIColor.brown)".color(.red)
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

extension SmartStringStyle {
    static let title = SmartStringStyle(color: .black, font: .systemFont(ofSize: 30))
    static let body = SmartStringStyle(color: .blue, font: .systemFont(ofSize: 20))
}

extension String {
    var title: SmartString {
        style(.title)
    }
}

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
