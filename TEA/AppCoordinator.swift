//
//  AppCoordinator.swift
//  TEA
//
//  Created by Alexandre Freire García on 3/3/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import Foundation
import RxSwift
import Container

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private let scheduleNavigationController = UINavigationController()
    private let activitiesNavigationController = UINavigationController()
    private let tabBarController = UITabBarController()
    private let disposeBag = DisposeBag()
    private let container = ModelContainer.instance

    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
        tabBarController.viewControllers = [scheduleNavigationController, activitiesNavigationController]
        window.rootViewController = tabBarController
    }
    
    override func start() {
        let _ = container.load().subscribe()

        customizeAppearance()
        
        let activitiesCoordinator = AddPictogramsCoordinator(navigationController: activitiesNavigationController)
        let scheduleCoordinator = ScheduleCoordinator(navigationController: scheduleNavigationController)
        
        add(child: activitiesCoordinator)
        add(child: scheduleCoordinator)
        activitiesCoordinator.start()
        scheduleCoordinator.start()
        
        window.makeKeyAndVisible()
        
        
        
    }
    
    // MARK: - Appearance Customization
    private func customizeAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let barTintColor = UIColor(named: .bar)
        navigationBarAppearance.barStyle = .default 
        navigationBarAppearance.barTintColor = barTintColor
        navigationBarAppearance.tintColor = UIColor(named: .darkText)
        navigationBarAppearance.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(named: .darkText)
        ]
        
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = barTintColor
    }
    
    func loadDummyData() -> Observable<Void>{
        return  Observable<Void>.create { observer in
            observer.onNext()
            return Disposables.create()
            
        }
        
        
    }
}

extension UISplitViewController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

