//
//  AppDelegate.swift
//  TEA
//
//  Created by Alexandre Freire García on 24/2/17.
//  Copyright © 2017 Alexandre Freire García. All rights reserved.
//

import UIKit
import RxSwift
import TEAService

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    var disposeBag = DisposeBag()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        
//        let client = Client()
//        client.searchPictogram(forQuery: "ir").subscribe(onNext: { response in
//            print(response)
//        })
        
        return true
    }

}

