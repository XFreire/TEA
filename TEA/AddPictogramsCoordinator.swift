//
//  AddPictogramsCoordinator.swift
//  TEA
//
//  Created by Alexandre Freire García on 25/4/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

final class AddPictogramsCoordinator: Coordinator {
    
    // MARK: - Properties
    private unowned let navigationController: UINavigationController
    private let viewController: AddPictogramsViewController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        viewController = AddPictogramsViewController(viewModel: AddPictogramsViewModel())
        
        super.init()
        
        viewController.didTapNext = { [weak self] pictograms in
            guard let `self` = self else { return }
            let coordinator = NameWithImageCoordinator(pictograms: pictograms, navigationController: self.navigationController)
            self.add(child: coordinator)
            coordinator.start()
        }
                
    }
    
    override func start() {
        viewController.definesPresentationContext = true
        navigationController.pushViewController(viewController, animated: false)
    }
}
