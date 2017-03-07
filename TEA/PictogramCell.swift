//
//  PictogramCell.swift
//  TEA
//
//  Created by Alexandre Freire García on 7/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

class PictogramCell: UICollectionViewCell, ReusableView, NibLoadableView {
        
    @IBOutlet weak var pictogramView: PictogramView!
    override func prepareForReuse() {
        super.prepareForReuse()
        pictogramView.url = nil
    }
}
