//
//  JSInterface.swift
//  JSInterface
//
//  Created by Kem on 9/12/15.
//  Copyright © 2015 Kem. All rights reserved.
//

import Foundation
import JavaScriptCore
import UIKit

@objc protocol MyExport : JSExport
{
    func getPaymentResponse(_ jsonResponse: String)
}

class JSInterface : NSObject, MyExport
{
    func getPaymentResponse(_ jsonResponse: String)
    {
        DispatchQueue.main.async(){
            
            let dict = self.convertToDictionary(text: jsonResponse)
            //Bhargav Hide
print(dict!)
//            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//            let identifier:String!
            if (dict!["response_code"]! as! String == "0")
            {

//                identifier = "PaymentSuccessFailureViewController"
            }
            else
            {
//                identifier = "PaymentSuccessFailureViewController"
            }
            
//            let psvc:PaymentSuccessFailureViewController = appDelegate.storyboard.instantiateViewController(withIdentifier: identifier) as! PaymentSuccessFailureViewController
////            psvc.dicData = dict! as NSDictionary
////            psvc.navigationItem.hidesBackButton = true
//            appDelegate.navigationController.pushViewController(psvc, animated: true)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PushSuccess"), object: dict)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                //Bhargav Hide
////print(error.localizedDescription)
            }
        }
        return nil
    }
}


////
////  JSInterface.swift
////  JSInterface
////
////  Created by Kem on 9/12/15.
////  Copyright © 2015 Kem. All rights reserved.
////
//
//import Foundation
//import JavaScriptCore
//import UIKit
//
//@objc protocol MyExport : JSExport
//{
//    func getPaymentResponse(_ jsonResponse: String)
//}
//
//class JSInterface : NSObject, MyExport
//{
//    func getPaymentResponse(_ jsonResponse: String)
//    {
//        DispatchQueue.main.async(){
//
//            let dict = self.convertToDictionary(text: jsonResponse)
//            //Bhargav Hide
////print(dict!)
//            //Bhargav Hide
////print("success to go other controller: ",dict as Any)
//
//            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//            let identifier:String!
//            if (dict!["response_code"]! as! String == "0")
//            {
//                identifier = "PaymentSuccessFailureViewController"
//            }
//            else
//            {
//                identifier = "PaymentSuccessFailureViewController"
//            }
//            //Bhargav Hide
////print("success to go other controller")
//            let psvc:PaymentSuccessFailureViewController = appDelegate.storyboard.instantiateViewController(withIdentifier: identifier) as! PaymentSuccessFailureViewController
//            psvc.dicData = dict! as NSDictionary!
//            psvc.navigationItem.hidesBackButton = true
//            appDelegate.navigationController.pushViewController(psvc, animated: true)
//        }
//    }
//
//    func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                //Bhargav Hide
////print(error.localizedDescription)
//            }
//        }
//        return nil
//    }
//}
