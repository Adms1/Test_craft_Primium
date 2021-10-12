//
//  AppDelegate.swift
//  TestCraftLite
//
//  Created by ADMS on 24/03/21.
//

import UIKit
import GoogleSignIn
import Firebase
import FacebookCore
import FBSDKCoreKit

import Firebase
//import FirebaseDynamicLinks
//import FirebaseDynamicLinks
//import FirebaseInstanceID
//import UserNotifications
//import FirebaseMessaging


var strcellulerNetworkGloble = ""



@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all
    var storyboard:UIStoryboard!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        GIDSignIn.sharedInstance().clientID = "67592456911-ek8fp3bv0on8i6h10vhkikgfh30bog6d.apps.googleusercontent.com"

        GIDSignIn.sharedInstance().clientID = "824237543405-92rm61qjmq1g93hs66bfi1bec21lb05e.apps.googleusercontent.com"

        FirebaseApp.configure()
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//
//        NSSetUncaughtExceptionHandler { exception in
//            //Bhargav Hide
//            ////print(exception)
//        }
        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
        print("UUID: \(UUIDValue)")
        UserDefaults.standard.set(UUIDValue, forKey: "UUID")
//
        NetworkManager.shared.startNetworkReachabilityObserver()
//        Settings.isAutoInitEnabled = true
//        ApplicationDelegate.initializeSDK(nil)
//        Settings.isAutoLogAppEventsEnabled = true

        self.PushDashbord()
        return true
    }

    func application(_ application: UIApplication,
                  open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
     if GIDSignIn.sharedInstance().handle(url) {
         return true
     } else if ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
         return true
     }

     return false
 }

 @available(iOS 9.0, *)
 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
     if GIDSignIn.sharedInstance().handle(url) {
         return true
     } else if ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]
         ) {
         return true
     }
     return false
 }

//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//            if (ApplicationDelegate.shared.application(app, open: url, options: options)) {
//                return true
//            }
//            return false
//        }

//    internal func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print("url UIApp:",url)
//        print("url \(url)")
//        print("url host :\(url.host!)")
//        print("url path :\(url.path)")
//        print("url scheme :\(url.scheme ?? "")")
//        print("I have recived a URL through a custome scheme! :\(url.absoluteString)")
//        let url_scheme = "\(url.scheme ?? "")"
//        print("url_scheme scheme! :\(url_scheme)")
//        //        print("query scheme! :\(url. ?? "")")
//
////        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
////            // Handle the deep link. For example, show the deep-linked content or
////            // apply a promotional offer to the user's account.
////            // ...
////            print("dynamic link \(dynamicLink.url)")
////            self.handleIncomingDynamicLink(dynamicLink)
////            return true
////        }else  if url_scheme == "SwiftDeepLinkTestcraft" {
////            let temp_Url = (URL(string: "\(url.host ?? "")\(url.path)") ?? nil)!
////            print("temp_Url! :\(temp_Url)")
////            self.handleIncomingURLLink(url)
////
////            //            self.handleIncomingDynamicLink(temp_Url)
////
////            //            if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: temp_Url) {
////            //                // Handle the deep link. For example, show the deep-linked content or
////            //                // apply a promotional offer to the user's account.
////            //                // ...
////            //                print("dynamic link fb \(dynamicLink.url)")
////            //                self.handleIncomingDynamicLink(dynamicLink)
////            //                return true
////            //            }
////            //            else
////            //            {
////            return true
////            //            }
////        }else{
//
//            let appId: String = Settings.appID!
//            if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
//                return ApplicationDelegate.shared.application(app, open: url, options: options)
//            }
//            else
//            {
//                return  GIDSignIn.sharedInstance().handle(url)
//
//                //        return GIDSignIn.sharedInstance().handle(url as URL?,
//                //                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                //                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
//            }
//        //}
//    }
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
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        #if DEBUG
//        //  self.tryCheckUpdate()
//        #else
//        //            self.tryCheckUpdate() //comment when send testing
//        #endif
//
//        //        self.birthday()
//        AppLinkUtility.fetchDeferredAppLink { (url, error) in
//            if let error = error {
//                print("fb_link____________Received error while fetching deferred app link %@", error)
//            }
//            if let url = url {
//                print("fb_link____________\n \(url)")
//
//                if #available(iOS 10, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    UIApplication.shared.openURL(url)
//                }
//            }
//        }
//
//    }
    func PushDashbord() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)

        if (UserDefaults.standard.object(forKey: "Deeplink") != nil)
        {
            isDeeplink = (UserDefaults.standard.value(forKey: "Deeplink")! as! NSString) as String
        }
        //        var params = ["":""]
        var result_AccountTypeID = ""
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            let result_logindata = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            result_AccountTypeID = "\(result_logindata["AccountTypeID"] ?? "")"
        }
        print("isDeeplink: \(isDeeplink), AccountTypeID: \(result_AccountTypeID) ")
        if isDeeplink != "" //&& result_AccountTypeID == "5"
        {
            var deep_select_CV = ""

            if isDeeplink == "1"{ deep_select_CV = "SelectExamLangVC" }
            else if isDeeplink == "2"{ deep_select_CV = "DeeplinkTestListVC"}
            else { deep_select_CV = "DeeplinkTestListVC"}
            let rootVC = storyboard.instantiateViewController(withIdentifier: deep_select_CV) as UIViewController
            rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
//            SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)

            let frontNavigationController = UINavigationController(rootViewController: rootVC)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = frontNavigationController
            self.window?.makeKeyAndVisible()
        }
        else
        {
            var select_CV = ""
            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                // exist
                //            if (key == 0)

                let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
                if(result == "1")
                {
                    print("Store All DATA: ",result)
                    let dictPrice:[String:Any] = ["minPrice":"0", "maxPrice":"5000"]
                    UserDefaults.standard.set(dictPrice, forKey: "filter_price")
                    if ((UserDefaults.standard.value(forKey: "exam_preferences")) != nil)
                    {
                        let exam_preferences = UserDefaults.standard.value(forKey: "exam_preferences")! as! NSDictionary

                        //Bhargav Hide
                        print("exam_preferences",exam_preferences)
                        strCategoryID = "\(exam_preferences.value(forKey: "CategoryID") ?? "")"
                        strCategoryTitle = "\(exam_preferences.value(forKey: "CategoryTitle") ?? "")"
                        select_CV = "BaseTabBarViewController"
                        //                    select_CV = "SelectExamVC"

                        arrPath = exam_preferences.value(forKey: "arrPath") as! [String]
                        if strCategoryID == "1" //Exam
                        {
                            strCategoryID1 = "\(exam_preferences.value(forKey: "CategoryID1") ?? "")"//Board
                            strCategoryID2 = "\(exam_preferences.value(forKey: "CategoryID2") ?? "")"//Standard
                            strCategoryID3 = "\(exam_preferences.value(forKey: "CategoryID3") ?? "")"//Subject
                            strCategoryTitle1 = "\(exam_preferences.value(forKey: "CategoryTitle1") ?? "")"//Board
                            strCategoryTitle2 = "\(exam_preferences.value(forKey: "CategoryTitle2") ?? "")"//Standard
                            strCategoryTitle3 = "\(exam_preferences.value(forKey: "CategoryTitle3") ?? "")"//Subject
                        }
                        else
                        {
                            strCategoryID1 = "\(exam_preferences.value(forKey: "CategoryID1") ?? "")"//Exam
                            strCategoryID3 = "\(exam_preferences.value(forKey: "CategoryID3") ?? "")"//Subject
                            strCategoryTitle1 = "\(exam_preferences.value(forKey: "CategoryTitle1") ?? "")"//Exam
                            strCategoryTitle3 = "\(exam_preferences.value(forKey: "CategoryTitle3") ?? "")"//Subject
                        }
                        strTutorsId = "\(exam_preferences.value(forKey: "TutorID") ?? "")"
                        strTutorsTitle = "\(exam_preferences.value(forKey: "TutorTitle") ?? "")"
                        selectedPackages = 1


                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

    //                    let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
                        rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
                        if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
                        {
                            rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
                        }
                        else{
            //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                            // exist
                            rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
            //            }
                        }


                        let frontNavigationController = UINavigationController(rootViewController: rootVC)
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = frontNavigationController
                        self.window?.makeKeyAndVisible()

                    }
                    else
                    {
                        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

    //                    let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
                        rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
                        if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
                        {
                            rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
                        }
                        else{
            //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                            // exist
                            rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
            //            }
                        }


                        let frontNavigationController = UINavigationController(rootViewController: rootVC)
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window?.rootViewController = frontNavigationController
                        self.window?.makeKeyAndVisible()


                    }
                }
                else
                {
                   // select_CV = "IntroVC"


                    let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController

//                    let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
                    rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
                    if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
                    {
                        rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
                    }
                    else{
        //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                        // exist
                        rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
        //            }
                    }


                    let frontNavigationController = UINavigationController(rootViewController: rootVC)
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = frontNavigationController
                    self.window?.makeKeyAndVisible()
                }
            }
            else
            {
                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
               // select_CV = "IntroVC"
//                let rootVC = storyboard.instantiateViewController(withIdentifier: select_CV) as UIViewController
                rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
                if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
                {
                    rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
                }
                else{
    //            if UserDefaults.standard.object(forKey: "isLogin") != nil{
                    // exist
                    rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
    //            }
                }


                let frontNavigationController = UINavigationController(rootViewController: rootVC)
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = frontNavigationController
                self.window?.makeKeyAndVisible()
                //select_CV = "IntroVC"
            }

//            SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L, rightMenuController: sideVC_R, leftMenuType: .SlideOver, rightMenuType: .SlideView)

        }
//        AppUtility.lockOrientation(.portraitUpsideDown)

//        SJSwiftSideMenuController.enableDimbackground = true
//        SJSwiftSideMenuController.leftMenuWidth = 280
//        //=======================================
//        self.window?.rootViewController = mainVC
//        NetworkManager.shared.window = self.window
//        self.window?.makeKeyAndVisible()

    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//                return ApplicationDelegate.shared.application(app, open: url, options: options)
//        }



}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
//    var shouldAutorotate: Bool {
//        return true
//    }


}
