//
//  AddTaskCoordinator.swift
//  TEA
//
//  Created by Alexandre Freire García on 15/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import Container

final class AddTaskCoordinator: Coordinator {
    
    private unowned let navigationController: UINavigationController
    private let viewContoller: AddTaskViewController
    
    init(pictograms: [Pictogram], navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewContoller = AddTaskViewController(pictograms: pictograms)
    }
    
    override func start() {
        navigationController.pushViewController(viewContoller, animated: true)
    }
    
}
