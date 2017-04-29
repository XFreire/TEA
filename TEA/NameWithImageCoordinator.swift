//
//  NameWithImageCoordinator.swift
//  TEA
//
//  Created by Alexandre Freire García on 11/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import Container

final class NameWithImageCoordinator: Coordinator {
    
    // MARK: - Properties
    private unowned let navigationController: UINavigationController
    private let viewController: NameWithImageViewController
    
    init(pictograms: [Pictogram], navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        viewController = NameWithImageViewController(viewModel: NameWithImageViewModel(pictograms: pictograms))
        
        
        super.init()
    
    }
    
    override func start() {
        navigationController.pushViewController(viewController, animated: false)
    }  
}
