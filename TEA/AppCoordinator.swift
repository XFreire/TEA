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
    private let navigationController = UINavigationController()
    private let disposeBag = DisposeBag()
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
        
    }
    
    override func start() {
        customizeAppearance()
        
        window.rootViewController = navigationController
        
        // The volume list is the initial screen
        let coordinator = ScheduleCoordinator(navigationController: navigationController)
        
        add(child: coordinator)
        coordinator.start()
        
        window.makeKeyAndVisible()
        
        
        
    }
    
    // MARK: - Appearance Customization
    private func customizeAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let barTintColor = UIColor(named: .bar)
        navigationBarAppearance.barStyle = .black // This will make the status bar white by default
        navigationBarAppearance.barTintColor = barTintColor
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
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
