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
    
//    let str: SmartString = "SmartString".align(.right).color(.black)
//    + "\nSmartString!".lineHeight(40).background(.red)
//    + "\nSmartString!".lineSpacing(40).charactersSpacing(10).background(.blue)
//    + "\nSmartString!".align(.center).color(.black)

    let str = SmartString(attributedString: getAttributedString()).color(.red) + "Ciccio".onTap(closure: { str in
      print("CICCIOOOOO")
    })
    
    let label = UITextView()
    label.smartString = str
    label.sizeToFit()
    label.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(label)
    label.center(in: view)
    label.backgroundColor = .green
    
    label.isEditable = false
    label.backgroundColor = .clear
    label.isScrollEnabled = false
    label.showsVerticalScrollIndicator = false
    label.showsHorizontalScrollIndicator = false
    label.textContainer.lineFragmentPadding = 0
    label.textContainerInset = .zero
    
    NSLayoutConstraint.activate(
      [
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
      ]
    )
  }
}

var html = """
    <style>\n    body {\n      background-color: black;\n      color: rgba(255, 255, 255, 0.7);\n      font-family: metropolis;\n      font-size: 14px;\n      line-height: 20px;\n      letter-spacign: 0.25px;\n    }\n\n    h2 {\n        font-size: 20px;\n    }\n    </style>Classe 1986<b>, Christopher Cassio Martins Meireles</b>, conosciuto al pubblico come Christopher Leoni è un <b>modello </b>di successo nato in Brasile.\r<br />\r<br />La moda, però, non è la sua unica passione: Christopher, infatti, si rivela un talentuoso attore conquistando ruoli prima in soap brasiliane e poi nella grande fiction italiana come ad esempio: <i>L’onore e il rispetto</i>, <i>Pupetta – il coraggio e la passione</i>, <i>Il peccato e la vergogna 2 </i>e <i>Il bello delle donne</i>. Nel 2017, invece, prende parte al cast di Ballando con le stelle.\r<br />\r<br />Pur definendosi cittadino del mondo, Christopher ha scelto di stabilirsi in Italia, paese in cui sono nati i suoi due meravigliosi figli di 8 e 5 anni avuti dalla relazione con Francesca Versace.\r
"""

public func getAttributedString() -> NSAttributedString {
  let combinedString = """
    <style>\n    body {\n      background-color: black;\n      color: rgba(255, 255, 255, 0.7);\n      font-family: metropolis;\n      font-size: 14px;\n      line-height: 20px;\n      letter-spacign: 0.25px;\n    }\n\n    h2 {\n        font-size: 20px;\n    }\n    </style>Classe 1986<b>, Christopher Cassio Martins Meireles</b>, conosciuto al pubblico come Christopher Leoni è un <b>modello </b>di successo nato in Brasile.\r<br />\r<br />La moda, però, non è la sua unica passione: Christopher, infatti, si rivela un talentuoso attore conquistando ruoli prima in soap brasiliane e poi nella grande fiction italiana come ad esempio: <i>L’onore e il rispetto</i>, <i>Pupetta – il coraggio e la passione</i>, <i>Il peccato e la vergogna 2 </i>e <i>Il bello delle donne</i>. Nel 2017, invece, prende parte al cast di Ballando con le stelle.\r<br />\r<br />Pur definendosi cittadino del mondo, Christopher ha scelto di stabilirsi in Italia, paese in cui sono nati i suoi due meravigliosi figli di 8 e 5 anni avuti dalla relazione con Francesca Versace.\r
  """
  let data = combinedString.data(using: .utf16)!
  return try! NSAttributedString(
    data: data,
    options: [.documentType: NSAttributedString.DocumentType.html],
    documentAttributes: nil
  )
}
