//
//  AddTaskCoordinator.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import Container

/// Coordinates the presentation of a task form
final class AddPictogramsToTaskCoordinator: Coordinator {

    private unowned let navigationController: UINavigationController
    private let viewController: AddPictogramsToTaskViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        viewController = AddPictogramsToTaskViewController()
        
        super.init()
        
        viewController.didFinish = { [weak self] in
            guard let `self` = self else {
                return
            }
            
            // This will remove the coordinator from its parent
            self.didFinish()
        }
        
        viewController.didTapNext = { pictograms in
            let coordinator = AddTaskCoordinator(pictograms: pictograms, navigationController: self.navigationController)
            self.add(child: coordinator)
            coordinator.start()
        }
        
    }
    
    override func start() {
        
        
        
        navigationController.pushViewController(viewController, animated: true)
    }

}
