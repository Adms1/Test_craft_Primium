//
//  PaymentWebViewVC.swift
//  TestCraft
//
//  Created by ADMS on 20/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation
//import SJSwiftSideMenuController
import JavaScriptCore
import Toast_Swift
import Alamofire
import SwiftyJSON
import WebKit
import JavaScriptCore


class PaymentWebViewVC: UIViewController, ActivityIndicatorPresenter, SuccessFailedDelegate, UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate//, WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate
{
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        <#code#>
//    }

    var setrootViewController:String = ""
    var arrPackageDetail:StandardList?
    //var arrPackageDetail = [subPreferenceList]()
    var jsContext: JSContext!
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var eventFunctions = Dictionary<String, (String) -> Void>()

    @IBOutlet var lblSuccess : UILabel!
    @IBOutlet var lblFail : UILabel!
    @IBOutlet var lblSuccessDetail : UILabel!
    @IBOutlet var lblFailDetail : UILabel!

    @IBOutlet var viewSuccess : UIView!
    @IBOutlet var viewFail : UIView!
    @IBOutlet var btnTryAgain : UIButton!
    @IBOutlet var btnOK : UIButton!
    @IBOutlet var btnCancle : UIButton!
    @IBOutlet var lblTransactionID : UILabel!
    @IBOutlet var lblnPackageName : UILabel!
    @IBOutlet var lblnPrice : UILabel!

    @IBOutlet var lblFailTransactionID : UILabel!
      @IBOutlet var lblFailPackageName : UILabel!
      @IBOutlet var lblFailPrice : UILabel!
//    "Transaction id :  \(self.transaction_id) \nPackageName: \(self.arrPackageDetail[0].TestPackageName) \nPrice                :  ₹ \(self.AmountRs)"
    //    @IBOutlet var webview: WKWebView!
    @IBOutlet var webview: WKWebView!
    var amount: String!
    
//    var Salt             = "531553f8d6b906aa3342948a3c535ca301de9d5d" //Test Mode
//    var Api_key          = "535ee616-a161-4e16-88ed-a338582e841a" //Test Mode
    var Salt             = "10ad507bb768b574c3d6ff2bc6694b04386b9c8f" //Live Mode
    var Api_key          = "0cda5f4f-d803-4316-8562-c75a72fe99c0" //Live Mode
    var AmountRs         = ""
    var City             = "Ahmedabad"
    var Country          = "IND"
    var Currency         = "INR"
    var Description      = ""
    var Email            = "tech@testcraft.in"
    var Mode             = API.PaymentMode
//    var Mode             = "LIVE"
    var Name             = ""
    var Order_id         = ""
    var Phone            = ""
    var Return_url       = "https://biz.traknpay.in/tnp/return_page_android.php"
    var Show_saved_cards = "n"
    var State            = "Gujarat"
    var ZipCode          = "380015"
    var Address_line_1   = "-"
    var Address_line_2   = "-"
    var transaction_id   = ""
    //    var udf1   = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()


        print("id",arrPackageDetail?.ID)
        print("id",arrPackageDetail?.Name)

//        let webConfiguration = WKWebViewConfiguration()
//        let controller = WKUserContentController()
//        controller.add(self, name: "sendPrice")
//        controller.add(self, name: "sendListing")
//        webConfiguration.userContentController = controller
//        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
//        webview = WKWebView(frame: .zero, configuration: webConfiguration)
     //   webview.uiDelegate = self

        //view = webview
      //  webview.delegate = self
      //  webview.navigationDelegate = self
        TransctionPayment_webview_Reload()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(PushSuccessClicked(_:)), name: Notification.Name(rawValue: "PushSuccess"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
        btnOK.addShadowWithRadius(0,btnOK.frame.width/9,0,color: GetColor.signInText)
        btnCancle.addShadowWithRadius(0,btnCancle.frame.width/9,0,color: GetColor.signInText)
        btnTryAgain.addShadowWithRadius(0,btnTryAgain.frame.width/9,0,color: GetColor.signInText)
        self.viewSuccess.isHidden = true
        self.viewFail.isHidden = true
    }
    func TransctionPayment_webview_Reload()
    {

//        let contentController = WKUserContentController()
//        //we shall add some more code here
//        let config = WKWebViewConfiguration()
//        config.userContentController = contentController
//        self.webview = WKWebView( frame: self.view.bounds, configuration: config)

//        let webViewContraints = [
//        webView.leftAnchor.constraint(equalTo: view.leftAnchor),
//        webView.rightAnchor.constraint(equalTo: view.rightAnchor),
//        webView.topAnchor.constraint(equalTo: view.topAnchor),
//        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ]
     //   NSLayoutConstraint.activate(webViewContraints)
       // self.webview.uiDelegate = self
        //self.webview.navigationDelegate = self
//        let request = URLRequest(url: URL(string: "https://google.com")!)
//        webView.load(request)




        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        let currencyString = "\(amount ?? "")"
        var amount_new = currencyString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: "₹", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        //Bhargav Hide
////print("_currencyString_______amount_____",currencyString, amount_new)

        AmountRs  = amount_new
          //  amount_new
        Description = "test"//narration!
        Name = "\(result.value(forKey: "StudentFirstName") ?? "")"//(CompanyDetails.value(forKey: "CustomerName")! as! String)
        Order_id = Order_ID!
        Email = "tech@testcraft.in"//"\(result.value(forKey: "StudentEmailAddress") ?? "")"
        Phone = "7433988267"//Shrenik Sir Mob Num //"\(result.value(forKey: "StudentMobile") ?? "")"
//        if Phone == ""
//        {
//            Phone = "8401244813"
//        }
        
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "570b0683-97e0-edad-1258-bde786158280"
        ]




        // prepare json data
        let json = ["salt":Salt,"address_line_1":Address_line_1,"address_line_2":Address_line_2,"amount":AmountRs,"api_key":Api_key,
                                   "city":City,"country":Country,"currency":Currency,"description":Description,"email":Email,"mode":Mode,
                                   "name":Name,"order_id":Order_id,"phone":Phone,
                                   "return_url":Return_url,"show_saved_cards":Show_saved_cards,"state":State,"zip_code":ZipCode]

       // let jsonData = try? JSONSerialization.data(withJSONObject: json)



        let hashdata = [Salt,Address_line_1,Address_line_2,AmountRs,Api_key,City,Country,Currency,Description,Email,Mode,Name,Order_id,Phone,Return_url,Show_saved_cards,State,ZipCode].joined(separator: "|")
        //Bhargav Hide
////print("hashdata \n",hashdata)
        
        let SHA_512_str:String = SHA_512.createSHA512(hashdata).uppercased()

        //Bhargav Hide
////print("SHA_512_str \n",SHA_512_str)
        
        let postkey = ["salt","address_line_1","address_line_2","amount","api_key","city","country","currency","description","email","mode","name","order_id","phone","return_url","show_saved_cards","state","zip_code"]
        
        var postdata:String = "hash=\(SHA_512_str)"
        for (index, element) in (hashdata.components(separatedBy: "|") as NSArray).enumerated()
        {
            if index != 0
            {
                postdata = "\(postdata)&\(postkey[index])=\(element)"
            }
        }
        //Bhargav Hide
        print("postdata",postdata,API.TraknPayUrl)
        let request = NSMutableURLRequest(url: NSURL(string: API.TraknPayUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpBody = postdata.data(using: .utf8)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
//        webview.delegate = self
        webview.load(request as URLRequest)

       // self.view.addSubview(self.webview)
        
    }

    @IBAction func Back_Clicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func PushSuccessClicked(_ notification: Notification) {
        let dict = notification.object as! NSDictionary
        transaction_id = dict["transaction_id"]! as! String

        //Bhargav Hide
print("Responce dic _____ \n",dict as Any)
       // Update_Payment_Api(dic: dict)

    }
    
//    func popup_open(dict : NSDictionary)
//    {
//        self.hideActivityIndicator()
//
//        if (dict["response_code"]! as! String == "0")
//        {
////            buyPackages()
//            self.viewSuccess.isHidden = false
//            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1500", comment: "Payment Successful", isFirstTime: "0")
//
//            //                        self.lblSuccessDetail.text = "Package name: \(self.arrPackageDetail[0].TestPackageName ?? "") \n Price: \(self.AmountRs) \n Transaction id: \(self.transaction_id)"
//            self.lblSuccessDetail.text = ""//"Transaction id :  \(self.transaction_id) \nPackageName: \(self.arrPackageDetail[0].TestPackageName) \nPrice                :  ₹ \(self.AmountRs)"
//            lblTransactionID.text = "\(self.transaction_id)"
//            lblnPackageName.text = "\(self.arrPackageDetail[0].Name)"
//            lblnPrice.text = "₹ \(self.AmountRs)"
//
//        }
//        else
//        {
//            self.viewFail.isHidden = false
//            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1400", comment: "Payment Fail", isFirstTime: "0")
//            //            lblFailDetail.text = "Package name: \(arrPackageDetail[0].TestPackageName ?? "") \n Price: \(AmountRs)" //\n Transaction id: \(transaction_id)"
//            self.lblFailDetail.text = ""//"Transaction id :  \(self.transaction_id) \nPackageName: \(self.arrPackageDetail[0].TestPackageName)\nPrice                :  ₹ \(self.AmountRs)"
//            lblFailTransactionID.text = "\(transaction_id)"
//            lblFailPackageName.text = "\(self.arrPackageDetail[0].Name)"
//            lblFailPrice.text = "₹ \(self.AmountRs)"
//
////            // Create AlertController
////            let alert = AlertController(title: "\(dict["response_message"] ?? "")", message: "", preferredStyle: .alert)
////            alert.setTitleImage(UIImage(named: "risk_blue"))
////            // Add actions
////            alert.addAction(UIAlertAction(title: "Try Again", style: .destructive, handler: {(alert: UIAlertAction!) in
////                //                self.navigationController?.popViewController(animated: true)
////                //                PaymentTransaction_ID
////                self.Resend_Payment_Api()
////
////            }))
////            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
//////                self.navigationController?.popViewController(animated: true)
//////                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
//////                SJSwiftSideMenuController.pushViewController(vc!, animated: false)
////                for controller in self.navigationController!.viewControllers as Array {
////                    //Bhargav Hide
//////print(controller)
////                    if controller.isKind(of: PackageDetailsVC.self) {
////                        self.navigationController!.popToViewController(controller, animated: true)
////                        break
////                    }
////                }
////            }))
////
////            //            AlertController.setValue(UIColor.orange, forKey: "titleTextColor")
////            self.present(alert, animated: true, completion: nil)
////
//        }
//
//
//    }
    
    deinit {
        //Bhargav Hide
////print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
//        self.webview.removeJavascriptInterfaces()
        
    }


    func Update_Payment_Api_packeage(dic : NSDictionary)
   // func Update_Payment_Api(orederID:String,PaymentStatus:String,transaction_id:String)
    {


        print("success responce",dic)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            self.showActivityIndicator()
        }
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
////print(result)
        var payment_status = ""
        if (dic["response_code"] as! Int == 1000){
            payment_status = "failed"
//            print("payment",payment_status)
//            for controller in self.navigationController!.viewControllers as Array {
//                //Bhargav Hide
//    ////print(controller)
//                if controller.isKind(of: TestCraftListVC.self) {
//                    self.navigationController!.popToViewController(controller, animated: true)
//                    break
//                }
//            }
        }else{
            payment_status = "success"
        }

        let params = ["PaymentOrderID":dic["order_id"] as! String,"ExternalTransactionStatus":payment_status, "ExternalTransactionID":dic["transaction_id"] as! String, "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]



//        let mmpparams = ["PaymentOrderID":orederID,"ExternalTransactionStatus":PaymentStatus, "ExternalTransactionID":transaction_id, "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.Update_Payment_RequestApi,params)
                       if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                           return
                       }

        Alamofire.request(API.Update_Payment_RequestApi, method: .post, parameters: params, headers: headers).validate().responseJSON { [self] response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                self.hideActivityIndicator()
            };
           // self.popup_open(dict: dic)
            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {


                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                    vc?.strPaymentStatus  = "success"
                    vc?.setRootvc = "MyPackageListVCViewController"
                    self.navigationController?.pushViewController(vc!, animated: false)


                  //  self.buyPackages()

//                    let arrData = json["data"].array
//                    for value in arrData! {
//                        Order_ID = value["OrderID"].stringValue //arrData.value(forKey: "TransactionID") as! String
//                        self.AmountRs = value["OrderID"].stringValue
//                        PaymentTransaction_ID = value["PaymentTransactionID"].stringValue //arrData.value(forKey: "TransactionID") as! String
//                    }

                }
                else
                {
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                    vc?.strPaymentStatus  = "failed"
                    vc?.setRootvc = "MyPackageListVCViewController"
                    self.navigationController?.pushViewController(vc!, animated: false)

//                    self.navigationController?.present(vc!, animated: true, completion: nil)
//                    for controller in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//            ////print(controller)
//                        if controller.isKind(of: TestCraftListVC.self) {
//                            self.navigationController!.popToViewController(controller, animated: true)
//                            break
//                        }
//
//                    }

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }


    func Update_Payment_Api(dic : NSDictionary)
   // func Update_Payment_Api(orederID:String,PaymentStatus:String,transaction_id:String)
    {


        print("success responce",dic)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
            self.showActivityIndicator()
        }
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
////print(result)
        var payment_status = ""
        if (dic["response_code"] as! Int == 1000){
            payment_status = "failed"
//            print("payment",payment_status)
//            for controller in self.navigationController!.viewControllers as Array {
//                //Bhargav Hide
//    ////print(controller)
//                if controller.isKind(of: TestCraftListVC.self) {
//                    self.navigationController!.popToViewController(controller, animated: true)
//                    break
//                }
//            }
        }else{
            payment_status = "success"
        }
        
        let params = ["PaymentOrderID":dic["order_id"] as! String,"ExternalTransactionStatus":payment_status, "ExternalTransactionID":dic["transaction_id"] as! String, "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]



//        let mmpparams = ["PaymentOrderID":orederID,"ExternalTransactionStatus":PaymentStatus, "ExternalTransactionID":transaction_id, "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.SubscriptionUpdatePaymentUrl,params)
                       if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                           return
                       }

        Alamofire.request(API.SubscriptionUpdatePaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { [self] response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                self.hideActivityIndicator()
            };
           // self.popup_open(dict: dic)
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {



                    if self.setrootViewController == "MyPackageListVCViewController"
                    {
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                        vc?.strPaymentStatus  = "success"
                        vc?.setRootvc = "MyPackageListVCViewController"
                        self.navigationController?.pushViewController(vc!, animated: false)
                    }else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                        vc?.strPaymentStatus  = "success"
//                            vc?.setRootvc = "MyPackageListVCViewController"
                        self.navigationController?.pushViewController(vc!, animated: false)
                    }

               //     self.buyPackages()

//                    let arrData = json["data"].array
//                    for value in arrData! {
//                        Order_ID = value["OrderID"].stringValue //arrData.value(forKey: "TransactionID") as! String
//                        self.AmountRs = value["OrderID"].stringValue
//                        PaymentTransaction_ID = value["PaymentTransactionID"].stringValue //arrData.value(forKey: "TransactionID") as! String
//                    }

                }
                else
                {
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                    vc?.strPaymentStatus  = "failed"
                    self.navigationController?.pushViewController(vc!, animated: false)

//                    self.navigationController?.present(vc!, animated: true, completion: nil)
//                    for controller in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//            ////print(controller)
//                        if controller.isKind(of: TestCraftListVC.self) {
//                            self.navigationController!.popToViewController(controller, animated: true)
//                            break
//                        }
//
//                    }

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                
            }
        }
    }
    
    //MARK: WEBVIEW DELEGATE

    func webViewDidStartLoad(_ webView: UIWebView)
    {
        showActivityIndicator()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideActivityIndicator()
    }
//
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
//    {
//        //Bhargav Hide
//////print("loaderror",error)
//        self.hideActivityIndicator()
//
//    }

//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
//        if (request.url?.absoluteString  == "https://biz.traknpay.in/tnp/return_page_android.php") {
//            webview.addJavascriptInterface(JSInterface(), forKey: "Android");
//        }
//        return true
//    }
    

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        showActivityIndicator()
    }

//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("finish to load")
//        self.hideActivityIndicator()
//
//
//    }

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool
    {
        //https://biz.traknpay.in/v2/paymentprocess
        //https://biz.traknpay.in/v2/paymentrequest
        if (request.url?.absoluteString  == "https://biz.traknpay.in/v2/paymentcancel") {
            for controller in self.navigationController!.viewControllers as Array {
                //Bhargav Hide
    ////print(controller)
                if self.setrootViewController == "MyPackageListVCViewController" {
                    if controller.isKind(of: MyPackageListVCViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }else if self.setrootViewController == "MyExpiredPackage"{
                    if controller.isKind(of: MyPackageListVCViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
                else{
                    if controller.isKind(of: TestCraftListVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }
        else if (request.url?.absoluteString == "https://biz.traknpay.in/tnp/return_page_android.php"){




           // Update_Payment_Api(orederID:Order_ID,PaymentStatus:"success",transaction_id:"1234")


           // return false

           // webview.addJavascriptInterface(JSInterface(), forKey: "Android");
            //print("responce",request.url?.query)
           // https://biz.traknpay.in/v2/getpaymentrequesturl paymentrequest
           // https://biz.traknpay.in/v2/paymentseamlessresponse

            let request1 = NSMutableURLRequest(url: NSURL(string:"https://biz.traknpay.in/v2/paymentstatus")! as URL)

            let session = URLSession.shared
            request1.httpMethod = "POST"

            //Note : Add the corresponding "Content-Type" and "Accept" header. In this example I had used the application/json.
            request1.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request1.addValue("application/json", forHTTPHeaderField: "Accept")


//            let headers = [
//                "Content-Type": "application/x-www-form-urlencoded"
//            ]

            let hashdata = [Salt,Address_line_1,Address_line_2,AmountRs,Api_key,City,Country,Currency,Description,Email,Mode,Name,Order_id,Phone,Return_url,Show_saved_cards,State,ZipCode].joined(separator: "|")
            //Bhargav Hide
    ////print("hashdata \n",hashdata)

            let SHA_512_str:String = SHA_512.createSHA512(hashdata).uppercased()

            //Bhargav Hide
    ////print("SHA_512_str \n",SHA_512_str)

            let postkey = ["salt","address_line_1","address_line_2","amount","api_key","city","country","currency","description","email","mode","name","order_id","phone","return_url","show_saved_cards","state","zip_code"]

            var postdata:String = "hash=\(SHA_512_str)"
            for (index, element) in (hashdata.components(separatedBy: "|") as NSArray).enumerated()
            {
                if index != 0
                {
                    postdata = "\(postdata)&\(postkey[index])=\(element)"
                }
            }
            //Bhargav Hide
//            print("postdata",postdata,API.TraknPayUrl)
//            let request = NSMutableURLRequest(url: NSURL(string: API.TraknPayUrl)! as URL,
//                                              cachePolicy: .useProtocolCachePolicy,
//                                              timeoutInterval: 10.0)
            request1.httpBody = postdata.data(using: .utf8)




           // request1.httpBody = request.httpBody

            let task = session.dataTask(with: request1 as URLRequest) { data, response, error in
                guard data != nil else {
                    print("no data found: \(error)")
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? AnyObject {
//                        print("Response: \(json["data"][0])")
//                        print("Response: \(json["data"][1])")

                        guard let  arr = json["data"] as? NSArray else{
                            return
                        }
                        print("Response: \(arr[0] as! NSDictionary)")



//                        if (arr[0]["response_code"] as! Int == 0){
//                        }else{
//                            payment_status = "failed"
//                        }

                        if self.setrootViewController == "MyPackageListVCViewController" {
                            self.Update_Payment_Api_packeage(dic: arr[0] as! NSDictionary)
                        }else{
                            self.Update_Payment_Api(dic: arr[0] as! NSDictionary)
                        }




//                        for controller in self.navigationController!.viewControllers as Array {
//                            //Bhargav Hide
//                ////print(controller)
//                            if controller.isKind(of: TestCraftListVC.self) {
//                                self.navigationController!.popToViewController(controller, animated: true)
//                                break
//                            }
//
//                        }
//                        self.mainResponse(json)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)// No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr)")
//                        self.eroorResponse(jsonStr!)
                    }
                } catch let parseError {
                    print(parseError)// Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: '\(jsonStr)'")
//                    self.eroorResponse(jsonStr!)
                }
            }

            task.resume()
            return false
        }
        return true
    }

//    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        let res = navigationResponse.response as! HTTPURLResponse
//        let header = res.allHeaderFields
//        print(header)
//    }



//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
//            webView.evaluateJavaScript("https://biz.traknpay.in/tnp/return_page_android.php") { (anyObject, error) in
//                guard let htmlStr = anyObject as? String else {
//                    return
//                }
//                let data: Data = htmlStr.data(using: .utf8)!
//                do {
//                    let jsObj = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0))
//                    if let jsonObjDict = jsObj as? Dictionary<String, Any> {
//                       // let threeDSResponse = ThreeDSResponse(dict: jsonObjDict)
//                        print(jsonObjDict)
//                    }
//                } catch _ {
//                    print("having trouble converting it to a dictionary")
//                }
//            }
//        }


    func dataToJSON(data: Data) -> Any? {
       do {
           return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       } catch let myJSONError {
           print(myJSONError)
       }
       return nil
    }

    func Resend_Payment_Api()
    {
        showActivityIndicator()
        //        let UDID: String = UIDevice.current.identifierForVendor!.uuidString
        
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
////print(result)
        
        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","PaymentAmount":"\(AmountRs)","PaymentTransactionID":"\(PaymentTransaction_ID ?? "0")"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.PaymentUrl,params)
                       if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                           return
                       }

        Alamofire.request(API.PaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
////print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    
                    for value in arrData! {
                        Order_ID = value["OrderID"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        self.AmountRs = value["OrderID"].stringValue
                        PaymentTransaction_ID = value["PaymentTransactionID"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                        self.TransctionPayment_webview_Reload()
                    }
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
    
        func buyPackages() {
            showActivityIndicator()
//            var result:[String:String] = [:]
//            if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
//            {
//                result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
//            }
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            let params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "TestPackageID":"\(arrPackageDetail?.ID ?? "0")"]
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            //Bhargav Hide
print("API, Params: \n",API.Add_StudentTestPackageApi,params,result)
                   if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                       // show Alert
                       self.hideActivityIndicator()
                       print("The network is not reachable")
                       // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                       return
                   }
    
            Alamofire.request(API.Add_StudentTestPackageApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
                self.hideActivityIndicator()
    
                switch response.result {
                case .success(let value):
    
                    let json = JSON(value)
                    //Bhargav Hide
////print(json)
    
                    if(json["Status"] == "true" || json["Status"] == "1") {
                        self.viewSuccess.isHidden = false
//                        self.lblSuccessDetail.text = "Package name: \(self.arrPackageDetail[0].TestPackageName ?? "") \n Price: \(self.AmountRs) \n Transaction id: \(self.transaction_id)"
                        self.lblSuccessDetail.text = ""//"Transaction id :  \(self.transaction_id) \nPackageName: \(self.arrPackageDetail[0].TestPackageName) \nPrice                :  ₹ \(self.AmountRs)"
                        self.lblTransactionID.text = "\(self.transaction_id)"
                        self.lblnPackageName.text = "\(self.arrPackageDetail?.Name)"
                        self.lblnPrice.text = "₹ \(self.AmountRs)"

                        if self.setrootViewController == "MyPackageListVCViewController"
                        {
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                            vc?.strPaymentStatus  = "success"
                            vc?.setRootvc = "MyPackageListVCViewController"
                            self.navigationController?.pushViewController(vc!, animated: false)
                        }else{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PaymentSuccessVC") as? PaymentSuccessVC
                            vc?.strPaymentStatus  = "success"
//                            vc?.setRootvc = "MyPackageListVCViewController"
                            self.navigationController?.pushViewController(vc!, animated: false)
                        }


//                        else{

//                        }


//                        self.navigationController?.pushViewController(vc!, animated: false)


//                        for controller in self.navigationController!.viewControllers as Array {
//                            //Bhargav Hide
//                ////print(controller)
//                            if controller.isKind(of: TestCraftListVC.self) {
//                                self.navigationController!.popToViewController(controller, animated: true)
//                                break
//                            }
//
//                        }

                    }
                    else
                    {
                        self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    }
                case .failure(let error):
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
    
                }
            }
        }
    @IBAction func OK_Clicked(_ sender: UIButton) {
        self.viewSuccess.isHidden = true
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1600", comment: "Dashboard", isFirstTime: "0")

        for controller in self.navigationController!.viewControllers as Array {
            //Bhargav Hide
////print(controller)
            isGotoDashBoard = "1"

            if controller.isKind(of: TestCraftListVC.self) {
                controller.tabBarController!.selectedIndex = 0
                //                                controller.tabBarController?.tabBarItem
                self.navigationController!.popToViewController(controller, animated: false)

                break
            }
//            else if controller.isKind(of: ExploreVC.self) {
//                controller.tabBarController!.selectedIndex = 0
//
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }

        }
        
    }
    @IBAction func TryAgain_Clicked(_ sender: UIButton) {
        self.viewFail.isHidden = true
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1401", comment: "Try Again Button", isFirstTime: "0")
        self.Resend_Payment_Api()
    }
    @IBAction func Cancel_Clicked(_ sender: UIButton) {
        self.viewFail.isHidden = true
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1402", comment: "Cancel Button", isFirstTime: "0")
        for controller in self.navigationController!.viewControllers as Array {
            //Bhargav Hide
////print(controller)
            if controller.isKind(of: TestCraftListVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }

        }
    }


}

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
//print(dict!)
////            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
////            let identifier:String!
//            if (dict!["response_code"]! as! String == "0")
//            {
//
////                identifier = "PaymentSuccessFailureViewController"
//            }
//            else
//            {
////                identifier = "PaymentSuccessFailureViewController"
//            }
//
////            let psvc:PaymentSuccessFailureViewController = appDelegate.storyboard.instantiateViewController(withIdentifier: identifier) as! PaymentSuccessFailureViewController
//////            psvc.dicData = dict! as NSDictionary
//////            psvc.navigationItem.hidesBackButton = true
////            appDelegate.navigationController.pushViewController(psvc, animated: true)
//            NotificationCenter.default.post(name: Notification.Name(rawValue: "PushSuccess"), object: dict)
//        }
//    }
//
//    func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                //Bhargav Hide
//////print(error.localizedDescription)
//            }
//        }
//        return nil
//    }
//}
