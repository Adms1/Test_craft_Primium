//
//  SubscriptionPopupVC.swift
//  TestCraftLite
//
//  Created by ADMS on 25/03/21.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON

class SubscriptionPopupVC: UIViewController, ActivityIndicatorPresenter {

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()
    //     var selectedIndex: Int = 0
    @IBOutlet var tblList:UITableView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblPrice:UILabel!

    @IBOutlet var lblSubscriptionTitle:UILabel!
    @IBOutlet var lblSubscriptionDetail:UILabel!
    @IBOutlet var popUpViewSubscription:UIView!
    @IBOutlet var popUpSubViewSubscription:UIView!
    @IBOutlet var btnPrice:UIButton!
    @IBOutlet var btnPayNow:UIButton!

    var PopCategoryID = ""
    var PopCategoryID1 = ""
    var PopCategoryID2 = ""

    var strPrice = ""
    var strListPrice = ""
    var IsFree = ""
    var temp_Order_ID = ""
    var temp_PaymentTransaction_ID = ""

    var strCouponCode = ""

    var arrTitle = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        isContinuePurchsedFromDetailScreen = "1"

        popUpSubViewSubscription.addShadowWithRadius(10, 8, 0, color: GetColor.blackColor)
        btnPrice.addShadowWithRadius(0, 0, 1, color: GetColor.themeBlueColor)
        btnPayNow.addShadowWithRadius(0, 0, 0, color: GetColor.blackColor)
        //        lblSubscriptionTitle.addShadowWithRadius(0, 8, 0, color: GetColor.blackColor)
        popUpSubViewSubscription.backgroundColor = GetColor.whiteColor
        btnPayNow.backgroundColor = GetColor.themeBlueColor
        //        lblSubscriptionTitle.backgroundColor = GetColor.blueHeaderBg
        lblSubscriptionTitle.textColor = GetColor.blueHeaderText
        //        lblSubscriptionDetail.textColor = GetColor.darkGray
        btnPayNow.setTitle("Subscribe", for: .normal)
        self.lblPrice.text = "-" //"\(json["data"]["TestPackage"].stringValue)"
        self.btnPrice.isHidden = true
        self.lblPrice.isHidden = true
        self.btnPayNow.isHidden = true

        Get_Subcription_Course_Price_API(CourseID: "0", BoardID: PopCategoryID1, StandardID: PopCategoryID2, TypeID: PopCategoryID)
    }
}
extension SubscriptionPopupVC{
    @IBAction func Subscription_Close_Clicked(_ sender: AnyObject) {
        navigationController?.popViewController(animated: false)
    }
    @IBAction func Subscription_Clicked(_ sender: AnyObject) {
        //        Insert_StudentSubscription_API()
        var strSelectd = false

        //        if PopCategoryID == "{
        //        if self!.PopCategoryID == "1" //PopCategoryID == "1"
        //        {

        if PopCategoryID == "1"{
            if PopCategoryID1 != "" && PopCategoryID2 != ""{
                strSelectd = true
            }
        }else if PopCategoryID == "2"{
            if PopCategoryID1 != "" //&& PopCategoryID2 != ""
            {
                strSelectd = true
            }
        }
        //        }
        if strSelectd == true {
            //            self.Insert_StudentSubscription_API(CourseID: "\(self.PopCategoryID1)", BoardID: "0", StandardID: "0", TypeID: "\(self.PopCategoryID)")
            if self.PopCategoryID == "1" //PopCategoryID == "1"
            {
                //                self!.Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(self!.PopCategoryID1)", StandardID: "\(self!.PopCategoryID2)", TypeID: "\(self!.PopCategoryID)")

                                self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.PopCategoryID1)", StandardID: "\(self.PopCategoryID2)", TypeID: "\(self.PopCategoryID)")

            }

            else
            {
                //                self!.Get_Subcription_Course_Price_API(CourseID: "\(self!.PopCategoryID1)", BoardID: "0", StandardID: "0", TypeID: "\(self!.PopCategoryID)")
                                self.Insert_StudentSubscription_API(CourseID: "\(self.PopCategoryID1)", BoardID: "0", StandardID: "0", TypeID: "\(self.PopCategoryID)")

            }

        }else{
            self.view.makeToast("Select Package..", duration: 3.0, position: .bottom)

        }

    }
}
extension SubscriptionPopupVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "MyPackageSubscriptionCell"
        var cell: MyPackageSubscriptionCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageSubscriptionCell
        if cell == nil {
            tableView.register(UINib(nibName: "MyPackageSubscriptionCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageSubscriptionCell
        }
        cell.lblPackageName.text = arrTitle[indexPath.row]
        cell.topbgView1.addShadowWithRadius(0,8,0,color: UIColor.lightGray)
        return cell
    }
}
extension SubscriptionPopupVC{
    func Get_Subcription_Course_Price_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
    {
        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""
       // let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)

        api = API.Get_Subcription_Course_PriceApi
                params = ["StudentID":"14395", "CourseID":CourseID, "BoardID":BoardID, "StandardID":StandardID, "TypeID":TypeID, "IsFree":IsFree]

        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                self.btnPrice.isHidden = true
                self.lblPrice.isHidden = true
                self.btnPayNow.isHidden = true

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "True") {
                    //                    self.Get_ContentCount_API()
                    //                        let strQuestion = "\(json["data"]["Question"].stringValue)"
                    //                        let TestPackage = "\(json["data"]["TestPackage"].stringValue)"
                    self.strPrice = "\(json["data"]["Price"].stringValue)"
                    self.strListPrice = "\(json["data"]["ListPrice"].stringValue)"
                    //                    self.strPrice = "0"
                    //                        self.btnPrice.isHidden = false
                    //                        self.btnPayNow.isHidden = false
                    //                        self.lblPrice.isHidden = false
                    //                        self.lblPrice.text = ""
                    //                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    //                        let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strListPrice)")//, attributes: attrs )
                    //                        attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    //                        attributeString.append(attributeString1)
                    //                        let attributedStringColor = [NSAttributedString.Key.foregroundColor : GetColor.blueHeaderText];
                    //
                    //                        if self.strPrice == "0" {
                    //                            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    //                            attributeString.append(attributeString2)
                    //
                    //                        }else{
                    //    //                        self.lblPrice.text = "₹ \(self.strPrice)"
                    //                            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)", attributes: attributedStringColor)
                    //                            attributeString.append(attributeString2)
                    //
                    //                        }
                    //                        self.lblPrice.attributedText = attributeString
                    self.Check_Subcription_FreeTrial_API()
                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)

                    let alert = UIAlertController(title: "\(json["Msg"].stringValue)", message: "", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                        //Bhargav Hide
                        //                        self.popUpViewSubscription.isHidden = false
                        //                        self.pushPackage(strTemp:"")
                    }
                    alert.addAction(action1)
                    //                            alert.addAction(actionContinue)
                    self.present(alert, animated: true, completion: {
                        //Bhargav Hide
                        ////print("completion block")
                    })
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
    func Check_Subcription_FreeTrial_API()
    {
        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
       // let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)
        params = ["StudentID":"14395"]

        //Bhargav Hide
        print("API, Params: \n",API.Check_Subcription_FreeTrialApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            //            self.collectionView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Check_Subcription_FreeTrialApi, method: .post, parameters: params, headers: headers).validate().responseJSON { [self] response in
            self.hideActivityIndicator()
            self.popUpSubViewSubscription.isHidden = false

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
                self.btnPrice.isHidden = false
                self.btnPayNow.isHidden = false
                self.lblPrice.isHidden = false
                self.lblPrice.text = ""

                if(json["Status"] == "true" || json["Status"] == "1") {

                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strPrice)")//, attributes: attrs )
                    attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    attributeString.append(attributeString1)
                    let attributedStringColor = [NSAttributedString.Key.foregroundColor : GetColor.blueHeaderText];
                    //                    if self.strPrice == "0" {
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    attributeString.append(attributeString2)

                    //                    }else{
                    //////                        self.lblPrice.text = "₹ \(self.strPrice)"
                    ////                        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)", attributes: attributedStringColor)
                    ////                        attributeString.append(attributeString2)
                    //
                    //                    }
                    self.lblPrice.attributedText = attributeString
                    self.IsFree = "1"
                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)

                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    //                    let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strListPrice)")//, attributes: attrs )
                    //                    attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    //                    attributeString.append(attributeString1)
                    let attributedStringColor = [NSAttributedString.Key.foregroundColor : GetColor.blueHeaderText];

                    //                    if self.strPrice == "0" {
                    //                        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    //                        attributeString.append(attributeString2)
                    //
                    //                    }else{
                    //                        self.lblPrice.text = "₹ \(self.strPrice)"
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)", attributes: attributedStringColor)
                    attributeString.append(attributeString2)

                    //                    }
                    self.lblPrice.attributedText = attributeString
                    self.IsFree = "0"
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...\(error)", duration: 3.0, position: .bottom)
                print(error)
            }
        }
    }
    func Insert_StudentSubscription_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "4201", comment: "Subscription Pay Button", isFirstTime: "0")

        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""
      //  let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)

        api = API.Insert_StudentSubscription_TempApi
        params = ["StudentID":"14395","CourseID":CourseID,"BoardID":BoardID,"StandardID":StandardID,"TypeID":TypeID,"IsFree":IsFree]

        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                //                self.btnPrice.isHidden = true
                //                self.lblPrice.isHidden = true
                //                self.btnPayNow.isHidden = true

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    self.Payment_Api(strCoin: self.strPrice)

                    //                    self.Get_ContentCount_API()
                    //                    let arrData = json["data"].array
                    //                    let alert = UIAlertController(title: "Package add sucessfully", message: "", preferredStyle: UIAlertController.Style.alert)
                    //                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                    //                        //Bhargav Hide
                    //                        ////print("User click Ok button")
                    ////                        self.popUpViewSubscription.isHidden = false
                    ////                        self.pushPackage(strTemp:"")
                    //                    }
                    //                    alert.addAction(action1)
                    //                    //                            alert.addAction(actionContinue)
                    //                    self.present(alert, animated: true, completion: {
                    //                        //Bhargav Hide
                    //                        ////print("completion block")
                    //                    })
                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
//                    self.Payment_Api(strCoin: self.strPrice)

                    let alert = UIAlertController(title: "\(json["Msg"].stringValue)", message: "", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                        //Bhargav Hide
                        //                        self.popUpViewSubscription.isHidden = false
                        //                        self.pushPackage(strTemp:"")
                    }
                    alert.addAction(action1)
                    //                            alert.addAction(actionContinue)
                    self.present(alert, animated: true, completion: {
                        //Bhargav Hide
                        ////print("completion block")
                    })
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
    func Payment_Api(strCoin: String)
    {
        //        showActivityIndicator()
        let UDID: String = UIDevice.current.identifierForVendor!.uuidString

       // let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)
        let currencyString = "\(strCoin)"
        var amount_new = currencyString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: "₹", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        //        var amount_new = currencyString.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: ", ₹  "))
        //Bhargav Hide
        ////print("_currencyString_______amount_____",currencyString, amount_new)
        var params = ["":""]
        //            if self.strCouponCodeID != ""
        //            {
        //                params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0"]
        //            }
        //            else
        //            {

       // dynamic parameters
      //  params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0"]

        params = ["StudentID":"14395", "PaymentAmount":amount_new,"PaymentTransactionID":"0"]

        //            }

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        //Bhargav Hide
        print("API, Params: \n",API.SubscriptionPaymentUrl,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.SubscriptionPaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    var amount = "0"
                    var temp_isFree = "0"
                    //                    var New_Student_ID = ""

                    for value in arrData! {
                        amount = "\(value["PaymentAmount"].stringValue)"//hide29_oct_2020
                        self.temp_Order_ID = "\(value["OrderID"].stringValue)"
                        self.temp_PaymentTransaction_ID = "\(value["PaymentTransactionID"].stringValue)"
                        temp_isFree = "\(value["IsFree"].stringValue)"
//                        "IsFree" : "0",

                    }
                    if self.IsFree == "1"
                    {
                        print("Freee.....")
                        //                        self.buyPackages()
                        self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "14395", amount: amount, IsFree: temp_isFree)
                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
                    }
                    else
                    {
                        print("Paidd.....")
                        let temp_strMyCoin = (strMyCoin as NSString).doubleValue
                        let temp_amount = (amount as NSString).doubleValue
                        //                        let unlockTest_InAppPurchase_Selected_ProductId = "1001"
                        //                        self.unlockProduct(unlockTest_InAppPurchase_Selected_ProductId)

                        if(temp_amount <= temp_strMyCoin){
                            print("\(strMyCoin) <= \(amount)")
                            // Bhargav 10 jun
                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "14395", amount: amount, IsFree: self.IsFree)

                        }else
                        {
                            print("Not Enough Coin.")
                            //                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)
                            //
                            let alert = UIAlertController(title: "Not Enough Coins!", message: "Looks like you need more Coins to buy.", preferredStyle: UIAlertController.Style.alert)
                            let action1 = UIAlertAction(title: "Cancel", style: .default) { (_) in
                                //Bhargav Hide
                                ////print("User click Ok button")
                                //                        self.PrompPopup()
                            }
                            alert.addAction(action1)
                            let actionBuy = UIAlertAction(title: "Buy", style: .default) { (_) in
                                //Bhargav Hide
                                ////print("User click Ok button")
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCoinVC") as? AddCoinVC
                                let temp_minCoin = temp_amount - temp_strMyCoin
                                if(temp_amount <= temp_strMyCoin){
                                }
//                                vc!.strMinPrice = "\(temp_minCoin)"//amount
                                isContinuePurchsedFromDetailScreen = "1"
//                                self.navigationController?.pushViewController(vc!, animated: false)
                            }
                            alert.addAction(actionBuy)
                            self.present(alert, animated: true, completion: {
                                //Bhargav Hide
                                ////print("completion block")
                            })
                        }
                    }

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
    func Update_Payment_Api(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String, IsFree:String)
    {
        showActivityIndicator()

        //        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //        //Bhargav Hide
        ////print(result)
        //        let payment_status = (dic["response_code"]! as! String == "0") ? "success" : "failed"
        let params = ["PaymentOrderID":OrderID, "ExternalTransactionStatus":ExternalTransactionStatus, "ExternalTransactionID":ExternalTransactionID, "StudentID":StudentID]

        //        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
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

        Alamofire.request(API.SubscriptionUpdatePaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
//                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    if IsFree == "1"
                    {

//                        self.logFBEvent(Event_Name: "Subscription_free", device_Name: "iOS", valueToSum: 1)

//                            self.Get_Coin_Globle_API()
                            let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                            let action1 = UIAlertAction(title: "Go To Dashboard", style: .default) { (_) in
                                //Bhargav Hide
                                ////print("User click Ok button")
//                                for controller in self.navigationController!.viewControllers as Array {
//                                    //Bhargav Hide
//                                    ////print(controller)
//                                    if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                                        controller.tabBarController!.selectedIndex = 0
//                                        //                                controller.tabBarController?.tabBarItem
//                                        self.navigationController!.popToViewController(controller, animated: false)
//                                        break
//                                    }
//                                    else if controller.isKind(of: ExploreVC.self) {
//                                        controller.tabBarController!.selectedIndex = 0
//                                        self.navigationController!.popToViewController(controller, animated: false)
//                                        break
//                                    }
//                                }

//                                let presentingVC = self.presentingViewController
//                                self.dismiss(animated: true, completion: {
//                                    //                                //Bhargav Hide
//                                    print("completion block")
//                                    presentingVC?.tabBarController?.tabBar.isHidden = false
//                                    presentingVC?.tabBarController!.selectedIndex = 0
//
//                                }
//                                )
                            }
                            alert.addAction(action1)
                            self.present(alert, animated: true, completion: {
                                //Bhargav Hide
                                ////print("completion block")
                            })
//                        }
//                        let alert = AlertController(title: "", message: "\(json["Msg"])", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
//                            for controller in self.navigationController!.viewControllers as Array {
//                                //Bhargav Hide
//                                ////print(controller)
//                                if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    //                                controller.tabBarController?.tabBarItem
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                                else if controller.isKind(of: ExploreVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                            }
//
//                        }))
//                        alert.addAction(action)
//                        self.present(alert, animated: true, completion: nil)

                    }else{
                        self.Purchased_Coin_Api(OrderID: OrderID, ExternalTransactionStatus: "success", ExternalTransactionID: "", StudentID: StudentID, amount: amount, isFree: IsFree)
//                        self.logFBEvent(Event_Name: "Subscription_paid", device_Name: "iOS", valueToSum: 1)

                    }
                }
                else
                {
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
    func Purchased_Coin_Api(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String, isFree:String)
    {
        showActivityIndicator()
        //        (string StudentID, string Credit, string Debit, string PackageID)
        var freeCoin = ""

        if isFree == "1"{
            freeCoin = "0"
        }else
        {
            freeCoin = amount
        }

        let params = ["Debit":amount, "Credit":"", "TestPackageID":"2", "StudentID":StudentID]
        //        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.purchase_Coin_Api,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.purchase_Coin_Api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    if isFree == "1"
                    {
                        self.Get_Coin_Globle_API()
                        let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "Go To Dashboard", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
//                            for controller in self.navigationController!.viewControllers as Array {
//                                //Bhargav Hide
//                                ////print(controller)
//                                if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    //                                controller.tabBarController?.tabBarItem
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                                else if controller.isKind(of: ExploreVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                            }

//                            let presentingVC = self.presentingViewController
//                            self.dismiss(animated: true, completion: {
//                                //                                //Bhargav Hide
//                                print("completion block")
//                                presentingVC?.tabBarController?.tabBar.isHidden = false
//                                presentingVC?.tabBarController!.selectedIndex = 0
//
//                            }
//                            )
                        }
                        alert.addAction(action1)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })
                    }else{
                        self.Get_Coin_Globle_API()
                        let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "Go To Dashboard", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
                            //                        self.PrompPopup()
//                            self.navigationController?.popViewController(animated: false)
//                            for controller in self.navigationController!.viewControllers as Array {
//                                //Bhargav Hide
//                                ////print(controller)
//                                if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    //                                controller.tabBarController?.tabBarItem
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                                else if controller.isKind(of: ExploreVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                            }

//                            let presentingVC = self.presentingViewController
//                            self.dismiss(animated: true, completion: {
//                                //                                //Bhargav Hide
//                                print("completion block")
//                                presentingVC?.tabBarController?.tabBar.isHidden = false
//                                presentingVC?.tabBarController!.selectedIndex = 0
//
//                            }
//                            )
                        }
                        alert.addAction(action1)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })
                    }
                }
                else
                {
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
}
