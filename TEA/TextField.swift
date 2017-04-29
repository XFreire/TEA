//
//  UnderlinedTextField.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

@IBDesignable
class TextField: UIView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var line: UIView!
    
    var text: String? {
        get{
            return textField.text
        }
        
        set{
            textField.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    

}
