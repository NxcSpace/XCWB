//
//  AppDelegate.swift
//  XCWB
//
//  Created by nxc on 2020/3/3.
//  Copyright © 2020 nxc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = WBTabBarViewController()
        window?.makeKeyAndVisible()
        
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }

    


}

