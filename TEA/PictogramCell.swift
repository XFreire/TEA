//
//  PictogramCell.swift
//  TEA
//
//  Created by Alexandre Freire García on 7/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

class PictogramCell: UICollectionViewCell, ReusableView, NibLoadableView {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                super.isSelected = true
                self.borderWidth = 1
                self.borderColor = UIColor.green
            } else {
                super.isSelected = false
                self.borderWidth = 0
                self.borderColor = UIColor.clear
            }
        }
    }
    
        
    @IBOutlet weak var pictogramView: PictogramView!
    override func prepareForReuse() {
        super.prepareForReuse()
        pictogramView.url = nil
    }
    
    
}
