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
final class AddTaskCoordinator: Coordinator {

    private unowned let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let viewController = AddTaskViewController()
        
        viewController.didFinish = { [weak self] in
            guard let `self` = self else {
                return
            }
            
            // This will remove the coordinator from its parent
            self.didFinish()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }

}
