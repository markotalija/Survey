//
//  AppDelegate.swift
//  Survey
//
//  Created by Marko Rankovic on 1/22/18.
//  Copyright © 2018 marko.rankovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Properties
    var window: UIWindow?

    //MARK: - UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let data = UserDefaults.standard.data(forKey: USER) {
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            DataManager.sharedInstance.currentUser = user
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController")
            
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }
        
        return true
    }
}

