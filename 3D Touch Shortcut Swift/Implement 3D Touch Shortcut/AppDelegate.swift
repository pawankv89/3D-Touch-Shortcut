//
//  AppDelegate.swift
//  Implement 3D Touch Shortcut
//
//  Created by Pawan kumar on 17/05/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Add 3D Touch Shortcuts
        self.addNewShortcuts(application: application)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
    //MARK: - Add 3D Touch Shortcuts
    
    func removeShortcuts(application: UIApplication) -> () {
        
        //If you want to remove all items you can just simply do this.
        application.shortcutItems = []
        
    }
    
    func addNewShortcuts(application: UIApplication) -> () {
        
        let viewController = self.window?.rootViewController
        
        // Check the trait collection to see if force is available.
        if viewController!.traitCollection.forceTouchCapability == .available {
            // Enable 3D Touch features
            print("Enable 3D Touch features")
        } else {
            // Fall back to other non 3D Touch features.
            print("Fall back to other non 3D Touch features.")
        }
        
        //If you want to remove all items you can just simply do this.
        self.removeShortcuts(application: application)
        
        let shortcut_search = UIMutableApplicationShortcutItem(type: "Search", localizedTitle: "Search", localizedSubtitle: "", icon: UIApplicationShortcutIcon(type: .search), userInfo: nil)
        
        let shortcut_dashboard = UIMutableApplicationShortcutItem(type: "Dashboard", localizedTitle: "Dashboard", localizedSubtitle: "", icon: UIApplicationShortcutIcon.init(templateImageName: "tab_dashboardblack"), userInfo: nil)
        
        let shortcut_profile = UIMutableApplicationShortcutItem(type: "Profile", localizedTitle: "Profile", localizedSubtitle: "", icon: UIApplicationShortcutIcon.init(templateImageName: "tab_my_account"), userInfo: nil)
        
        let shortcut_gift = UIMutableApplicationShortcutItem(type: "Gift", localizedTitle: "Gift", localizedSubtitle: "", icon: UIApplicationShortcutIcon.init(templateImageName: "tab_explore"), userInfo: nil)
        
        
        //Add Only Four (4) Item by Daynamic or Static Total Show Five (5) iTems with Share by Default added in List
        application.shortcutItems = [shortcut_search, shortcut_dashboard, shortcut_profile, shortcut_gift]
        
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let handleShortCutItem = self.handleShortCutItem(shortcutItem: shortcutItem, application: application)
        completionHandler(handleShortCutItem)
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem, application: UIApplication) -> Bool {
        
        var handle = false
        
        //gurad to see if the shortcutItem type is string
        guard let shortCutType = shortcutItem.type as String? else {
            return false
        }
        
        switch (shortCutType) {
        case "Search":
            //Handle shortcut 1
            
            //Move to Search Screen
            self.moveToSearchViewControllerScreen()
            
            handle = true
            break
        case "Dashboard":
            //Handle shortcut 2
            
            //Move to Dashboard Screen
            self.moveToDashboardViewControllerScreen()
            
            handle = true
            break
        case "Profile":
            //Handle shortcut 3
            
            //Move to Profile Screen
            self.moveToProfileViewControllerScreen()
            
            handle = true
            break
        case "Gift":
            //Handle shortcut 4
            
            //Move to Gift Screen
            self.moveToGiftViewControllerScreen()
            
            handle = true
            break
        default:
            break
        }
        
        print("Select ShortCut Item.type:- \(shortcutItem.type)")
        print("Select ShortCut Item.localizedTitle:- \(shortcutItem.localizedTitle)")
        
        return handle
    }
    
    //MARK: - Search ViewController
    func moveToSearchViewControllerScreen() -> () {
        
        //gurad navigationController
        guard let navigationController = UIApplication.shared.keyWindow?
            .rootViewController as? UINavigationController else {
                return
        }
        
        //Goto Search
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
        
        var isController: Bool = true
        for vController in (navigationController.viewControllers) {
            // some process
            if vController.isKind(of: SearchViewController.self) {
                print("yes it is SearchViewController")
                
                isController = false
                return
            }
        }
        
        if isController == true {
            navigationController.pushViewController(viewcontroller, animated: true)
        }
        
    }
    
    //MARK: - Dashboard ViewController
    func moveToDashboardViewControllerScreen() -> () {
        
        //gurad navigationController
        guard let navigationController = UIApplication.shared.keyWindow?
            .rootViewController as? UINavigationController else {
                return
        }
        
        //Goto Search
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: DashboardViewController.identifier) as! DashboardViewController
        
        var isController: Bool = true
        for vController in (navigationController.viewControllers) {
            // some process
            if vController.isKind(of: DashboardViewController.self) {
                print("yes it is DashboardViewController")
                
                isController = false
                return
            }
        }
        
        if isController == true {
            navigationController.pushViewController(viewcontroller, animated: true)
        }
        
    }
    
    //MARK: - Profile ViewController
    func moveToProfileViewControllerScreen() -> () {
        
        //gurad navigationController
        guard let navigationController = UIApplication.shared.keyWindow?
            .rootViewController as? UINavigationController else {
                return
        }
        
        //Goto Search
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: ProfileViewController.identifier) as! ProfileViewController
        
        var isController: Bool = true
        for vController in (navigationController.viewControllers) {
            // some process
            if vController.isKind(of: ProfileViewController.self) {
                print("yes it is ProfileViewController")
                
                isController = false
                return
            }
        }
        
        if isController == true {
            navigationController.pushViewController(viewcontroller, animated: true)
        }
        
    }
    
    //MARK: - Gift ViewController
    func moveToGiftViewControllerScreen() -> () {
        
        //gurad navigationController
        guard let navigationController = UIApplication.shared.keyWindow?
            .rootViewController as? UINavigationController else {
                return
        }
        
        //Goto Search
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: GiftViewController.identifier) as! GiftViewController
        
        var isController: Bool = true
        for vController in (navigationController.viewControllers) {
            // some process
            if vController.isKind(of: GiftViewController.self) {
                print("yes it is GiftViewController")
                
                isController = false
                return
            }
        }
        
        if isController == true {
            navigationController.pushViewController(viewcontroller, animated: true)
        }
        
    }
}
