//
//  AppDelegate.swift
//  tableView
//
//  Created by David Marjanović on 23/03/2020.
//  Copyright © 2020 David Marjanović. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let initialViewController = UINavigationController(rootViewController: MovieListViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = initialViewController
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    


}

