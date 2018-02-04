//
//  AppDelegate.swift
//  TestingApp
//
//  Created by Haider Khan on 2/3/18.
//  Copyright © 2018 moco. All rights reserved.
//

import UIKit
import MocoSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Moko.initialize()
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Moko.shared.didFetchBackground(withHandler: completionHandler)
    }


}

