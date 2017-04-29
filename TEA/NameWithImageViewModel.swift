//
//  NameWithImageViewModel.swift
//  TEA
//
//  Created by Alexandre Freire García on 23/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import Container
import UIKit

final class NameWithImageViewModel {

    let pictograms: [Pictogram]
    
    init(pictograms: [Pictogram] = [Pictogram(name: "Camara", image: UIImage(named: "camera")!), Pictogram(name: "prueba", image: UIImage(named: "prueba")!), Pictogram(name: "Papelera", image: UIImage(named: "papelera")!)]) {
        self.pictograms = pictograms
    }
}
