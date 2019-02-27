//
//  AppDelegate.swift
//  ViewShatter
//
//  Created by Dylan Elliott on 28/1/19.
//  Copyright © 2019 Dylan Elliott. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow!


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		window = UIWindow()
		window.rootViewController = RestorableNavigationController(factoryBlock: { MyViewController() })
		window.makeKeyAndVisible()
		
		return true
	}

	


}

