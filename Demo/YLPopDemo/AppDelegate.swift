//
//  AppDelegate.swift
//  YLPopDemo
//
//  Created by Lin on 2023/10/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let vc = TestController()
        window?.rootViewController = vc
        
        //激活window
        window?.makeKeyAndVisible()
        
        return true
    }

}

