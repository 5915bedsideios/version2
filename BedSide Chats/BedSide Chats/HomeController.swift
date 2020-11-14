//
//  HomeController.swift
//  BedSide Chats
//
//  Created by Owen on 11/13/20.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: searchField.frame.height - 1, width: searchField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        searchField.borderStyle = UITextField.BorderStyle.none
        searchField.layer.addSublayer(bottomLine)
    }
    
}
