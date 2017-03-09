//
//  ScheduleCoordinator.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

final class ScheduleCoordinator: Coordinator {

    // MARK: - Properties
    private unowned let navigationController: UINavigationController
    private let viewController: ScheduleViewController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        viewController = ScheduleViewController()
        
        
        super.init()
        
        viewController.didSelectAddTask = { [weak self] _ in
            print("did select add task")
            let coordinator = AddTaskCoordinator(navigationController: navigationController)
            self?.add(child: coordinator)
            coordinator.start()
        }
        
    }
    
    override func start() {
        viewController.definesPresentationContext = true
        navigationController.pushViewController(viewController, animated: false)
    }
    
    

}
