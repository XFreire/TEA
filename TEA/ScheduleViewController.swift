//
//  ScheduleViewController.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    var didSelectAddTask: () -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTaskClicked))
    }
    
    func addTaskClicked() {
        didSelectAddTask()
    }
}
