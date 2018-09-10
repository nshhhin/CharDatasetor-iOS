//
//  AppDelegate.swift
//  CharDatasetor-iOS
//
//  Created by 新納真次郎 on 2018/09/05.
//  Copyright © 2018年 新納真次郎. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userName: String?
    let userDefaults = UserDefaults.standard


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if userDefaults.string(forKey: "userName") != nil {
            userName = userDefaults.string(forKey: "userName")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

