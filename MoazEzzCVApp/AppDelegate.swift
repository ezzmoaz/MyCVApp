//
//  AppDelegate.swift
//  MoazEzzCVApp
//
//  Created by Moaz Ezz on 4/22/18.
//  Copyright © 2018 Moaz Ezz. All rights reserved.
//

import UIKit
import ChameleonFramework


//let MainColor = #colorLiteral(red: 0.7529411765, green: 0.2235294118, blue: 0.168627451, alpha: 1)
//let MainDarkColor = #colorLiteral(red: 0.4980392157, green: 0.5490196078, blue: 0.5529411765, alpha: 1)
//let MainColor = UIColor(hex: "ff8181")
//let MainDarkColor =  UIColor(hex: "a81382")
//let MainGray = #colorLiteral(red: 0.4980392157, green: 0.5490196078, blue: 0.5529411765, alpha: 1)
//let NormalFontBig = UIFont(name: "Cairo", size: 20)
//let NormalFont = UIFont(name: "Cairo", size: 17)
//let BoldFont = UIFont(name: "Cairo-Bold", size: 17)
//
//func getGradiantColor(frame : CGRect, style : UIGradientStyle, isReversed : Bool) -> UIColor{
//    if isReversed{
//        return UIColor.init(gradientStyle: style, withFrame: frame, andColors: [MainDarkColor, MainColor])
//    }else{
//        return UIColor.init(gradientStyle: style, withFrame: frame, andColors: [MainColor, MainDarkColor])
//    }
//}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

