//
//  GridView.swift
//  TEA
//
//  Created by Alexandre Freire García on 13/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

class GridView: UIView {

    enum GridType {
        case oneColumn, twoColumns
    }
    
    @IBOutlet weak var firstColumn: UIStackView!
    @IBOutlet weak var secondColumn: UIStackView!
    
    var type: GridType = .oneColumn {
        didSet {
            secondColumn.isHidden = (type == .oneColumn) ? true : false
        }
    }

}
