////
////  PaymentSuccessViewController.swift
////  SaralPayVault
////
////  Created by Ankit on 03/04/17.
////  Copyright © 2017 Waterworks Aquatics. All rights reserved.
////
//
//import UIKit
//
//class PaymentSuccessFailureViewController: CustomNavigationBar,SuccessFailedDelegate {
//    
//    @IBOutlet weak var btnHeader:UIButton!
//    
//    var dicData:NSDictionary!
//    var arr = ["transaction_id","amount","description"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        delegate = self
//        let payment_status = (dicData!["response_code"]! as! String == "0") ? "successful" : "failed"
//
//        let params = ["payment_id":dicData!["transaction_id"]! as! String,"PaymentStatus":payment_status,"transaction_id":dicData!["order_id"]! as! String,"Trans_Type":"2","order_id":"0","Description":dicData!["description"]! as! String,"CustomerID":UserDefaults.standard.value(forKey: "CustomerID") as! NSNumber] as [String : Any]
//        
//        InputValidation.ApiCalling(web_url: "\(InputValidation.WEB_API.BaseUrl)\(InputValidation.WEB_API.UpdatePaymentUrl)", param: params, success_msg: "", failure_msg:"", superview: self.view)
//        
//    }
//    
//    func SuccessFailedStatus()
//    {
//        btnHeader.setTitle((UserDefaults.standard.value(forKey: "CompanyName") as? String)?.uppercased(), for: .normal)
//        if(dicData != nil && dicData!["response_code"]! as! String == "0")
//        {
//            for view in self.view.subviews[1].subviews
//            {
//                if view.isKind(of: UITextField.classForCoder())
//                {
//                    (view as! UITextField).text = dicData.value(forKey: arr[view.tag]) as! String?
//                }
//                else if view.isKind(of: UITextView.classForCoder())
//                {
//                    (view as! UITextView).text = dicData.value(forKey: arr[view.tag]) as! String
//                    (view as! UITextView).textContainerInset =
//                        UIEdgeInsetsMake(5,10,5,5)
//                    (view as! UITextView).textColor = UIColor.black
//                }
//            }
//        }
//    }
//    
////    @IBAction func btnDoneClicked(sender:UIButton)
////    {
////        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
////        for aViewController in viewControllers {
////            if aViewController is QRScannerViewController {
////                self.navigationController!.popToViewController(aViewController, animated: false)
////            }
////        }
////    }
////
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
//}
