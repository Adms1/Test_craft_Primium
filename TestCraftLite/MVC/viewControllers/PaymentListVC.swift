//
//  PaymentListVC.swift
//  TestCraft
//
//  Created by ADMS on 27/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
import SDWebImage

class PaymentListVC: UIViewController, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var tblPaymentDetail:UITableView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblPath:UILabel!
    var isSub = ""
    var arrPaymentList = [PaymentListModal]()
    var strMsgDisplay = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblTitle.text = "Packages"
        if isSub == "1"
        {
            lblTitle.text = "My Subscription"
        }
        strMsgDisplay = "No subscription found"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                Get_Student_PaymentTransaction_ListApi()
            }
        }else{

//            let label:UILabel = UILabel()
//            label.textColor=UIColor.black
//            label.font = UIFont(name: "Halvetica", size: 14)
//            label.numberOfLines = 1
//            label.textColor = GetColor.lightGray
//            label.text = "No subscription found"
//            label.sizeToFit()
//
//            label.frame = CGRect(x: 10, y: view.frame.height/2, width: view.frame.width-10, height:30)
//
//            self.view.addSubview(label)


        }

        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func BackClicked(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    func Get_Student_PaymentTransaction_ListApi()
    {
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            showActivityIndicator()
            self.arrPaymentList.removeAll()
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            var api = API.Get_Student_PaymentTransaction_ListUrl
            if isSub == "1"
            {
                api = API.Get_Student_SubcriptionPaymentTransaction_List
            }
            let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            //Bhargav Hide
            print("API, Params: \n",api,params)
            if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                // show Alert
                self.hideActivityIndicator()
                print("The network is not reachable")
                self.tblPaymentDetail.reloadData()
                // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                return
            }

            Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
                self.hideActivityIndicator()
                
                switch response.result {
                case .success(let value):
                    if self.isSub == "1"
                    {
                        self.strMsgDisplay = "No Subscription Purchased."
                    }
                    else{
                        self.strMsgDisplay = "No Packages Purchased."

                    }
                    let json = JSON(value)
                    //Bhargav Hide
                    print(json)
                    
                    if(json["Status"] == "true" || json["Status"] == "2") {
                        let arrData = json["data"].array
                        
                        for value in arrData! {
                            //                        var arrTestType = [PackageDetailsModal]()
                            //                        let arrSubValue:[JSON] = value["TestType"].array!
                            
                            let pckgDetModel:PaymentListModal = PaymentListModal.init(PaymentTransactionID:  value["PaymentTransactionID"].stringValue, PaymentAmount:  value["PaymentAmount"].stringValue, PaymentDate:  value["PaymentDate"].stringValue, ExternalTransactionID:  value["ExternalTransactionID"].stringValue, ExternalTransactionStatus:  value["ExternalTransactionStatus"].stringValue, InvoiceId: value["InvoiceID"].stringValue, InvoiceGUId: value["InvoiceGUID"].stringValue, InvoiceLink: value[""].stringValue, OrderID: value["OrderID"].stringValue, packageName: "\(value["PackageName"].stringValue)",IsFree: "\(value["IsFree"].stringValue)")
                            //  (packageid: value[""].stringValue, packageName: value[""].stringValue, packageimage: value[""].stringValue, packageDescription: value[""].stringValue, packageStartDate: value[""].stringValue, packageEndDate: value[""].stringValue)
                            
                            self.arrPaymentList.append(pckgDetModel)
                        }
                        self.tblPaymentDetail.reloadData()
                    }
                case .failure(let error):
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                    //Bhargav Hide
                    ////print(error)
                }
            }
        }
        else
        {
            self.view.makeToast("Somthing wrong.....", duration: 3.0, position: .bottom)
        }
    }

    @IBAction func btnTryAgainClikedAction(sender:UIButton)
    {
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
////print(result)
        Resend_Payment_Api(StudentID: "\(result.value(forKey: "StudentID") ?? "")", PaymentAmount: "\(arrPaymentList[sender.tag].PaymentAmount ?? "")", PaymentTransactionID: "\(arrPaymentList[sender.tag].PaymentTransactionID ?? "")")
        
    }
    @IBAction func invoiceGenerateClicked(sender:UIButton)
    {
//        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//        //Bhargav Hide
////print(result)
//        Resend_Payment_Api(StudentID: "\(result.value(forKey: "StudentID") ?? "")", PaymentAmount: "\(arrPaymentList[sender.tag].PaymentAmount ?? "")", PaymentTransactionID: "\(arrPaymentList[sender.tag].PaymentTransactionID ?? "")")
        var str_invoice_Url = ""
        if isSub == "1"
        {
            str_invoice_Url = API.SubcriptionInvoiceDetailUrl + "\(arrPaymentList[sender.tag].InvoiceGUId ?? "")"
        }else
        {

        str_invoice_Url = API.invoiceUrl + "\(arrPaymentList[sender.tag].InvoiceGUId ?? "")"

        }
        //Bhargav Hide
////print(str_invoice_Url)
//        guard let url = URL(string: str_invoice_Url) else { return }
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url)
//        } else {
//            // Fallback on earlier versions
//            UIApplication.shared.openURL(url)
//        }
        
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
            vc?.strTitle = "Invoice"
        vc?.strLoadUrl = str_invoice_Url
                self.navigationController?.pushViewController(vc!, animated: true)

    }

    func Resend_Payment_Api(StudentID:String,PaymentAmount:String,PaymentTransactionID:String)
    {
        showActivityIndicator()
        //        let UDID: String = UIDevice.current.identifierForVendor!.uuidString
        
        let currencyString = "\(PaymentAmount)"
        var amount_new = currencyString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: "₹", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        //Bhargav Hide
////print("_currencyString_______amount_____",currencyString, amount_new)

        let params = ["StudentID":StudentID,"PaymentAmount":amount_new,"PaymentTransactionID":PaymentTransactionID]
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
                        Order_ID = value["OrderID"].stringValue
                        PaymentTransaction_ID = value["PaymentTransactionID"].stringValue
                    }
                    let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                    tpvc.amount = PaymentAmount
                    self.navigationController?.pushViewController(tpvc, animated: true)                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                
            }
        }
    }
    
}

extension PaymentListVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return arrPaymentList.count
        tableView.backgroundView = nil;
        if self.arrPaymentList.count > 0 { return self.arrPaymentList.count }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = strMsgDisplay
            noDataLabel.textColor     = GetColor.themeBlueColor//UIColor.red
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            return 0
        }
        
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier = "PaymentTableViewCell"
        if arrPaymentList[indexPath.row].ExternalTransactionStatus ?? "" == "success"
        {
            identifier = "PaymentTableViewCell1"
        }
        var cell: PaymentTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? PaymentTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "PaymentTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PaymentTableViewCell
        }
        
        if isSub == "1"
        {
            cell.lbl_ET_ID.text = "Package: \(arrPaymentList[indexPath.row].packageName ?? "")"
            //"Order ID : \(arrPaymentList[indexPath.row].OrderID ?? "")"
            cell.lbl_P_Date.text = "Date: \(arrPaymentList[indexPath.row].PaymentDate ?? "")"
//            cell.btnInvoice.isHidden = true
        }
        else
        {
            cell.lbl_ET_ID.text = "Package: \(arrPaymentList[indexPath.row].packageName ?? "")" //"Order ID : \(arrPaymentList[indexPath.row].OrderID ?? "")"
            cell.lbl_P_Date.text = "Date: \(arrPaymentList[indexPath.row].PaymentDate ?? "")"
        }
        let temp_IsFree = "\(arrPaymentList[indexPath.row].IsFree ?? "")"
        if temp_IsFree == "1"
        {
            cell.lbl_P_Amount.text = "Free"//"₹ \(arrPaymentList[indexPath.row].PaymentAmount ?? "")"
        }//arrPaymentList[indexPath.row].PaymentAmount ?? ""
        else
        {
            if isSub == "1"
            {
                cell.lbl_P_Amount.text = "₹ \(arrPaymentList[indexPath.row].PaymentAmount ?? "")"
            }
            else
            {
                cell.lbl_P_Amount.text = "₹ \(arrPaymentList[indexPath.row].PaymentAmount ?? "")"
            }
        }
        cell.lblMsg.text = arrPaymentList[indexPath.row].ExternalTransactionStatus ?? ""
        cell.topbgView1.addShadowWithRadius(0,0,0,color: UIColor.darkGray)
        //        cell.topbgView1.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.0)
        
        if cell.lblMsg.text == "success"
        {
            cell.lblMsg.textColor = GetColor.green
            cell.btnInvoice.tag = indexPath.row
            cell.btnInvoice.addTarget(self, action: #selector(invoiceGenerateClicked(sender:)), for: .touchUpInside)
//            cell.btnInvoice.addShadowWithRadius(0,13,1,color: GetColor.blueHeaderText)
//            cell.btnInvoice.clipsToBounds = true
        }
        else
        {
            cell.lblMsg.textColor = GetColor.red
            cell.btnTryAgain.tag = indexPath.row
            cell.btnTryAgain.addTarget(self, action: #selector(btnTryAgainClikedAction(sender:)), for: .touchUpInside)
            cell.btnTryAgain.addShadowWithRadius(0,cell.btnTryAgain.frame.width/9,0,color: GetColor.blueHeaderText)
        }
        //            cell.contentView.addShadowWithRadius(5,5,0,color: UIColor.darkGray)
        
        return cell        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
        //        vc!.arrPackageDetail = [self.arrHeaderSub3Title[indexPath.row]]
        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
        
        //        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        
//        let editAction = UITableViewRowAction(style: .normal, title: "Try Again") { (rowAction, indexPath) in
//            //TODO: edit the row at indexPath here
//            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//            //Bhargav Hide
////print(result)
//            self.Resend_Payment_Api(StudentID: "\(result.value(forKey: "StudentID") ?? "")", PaymentAmount: "\(self.arrPaymentList[indexPath.row].PaymentAmount ?? "")", PaymentTransactionID: "\(self.arrPaymentList[indexPath.row].PaymentTransactionID ?? "")")
//        }
//        editAction.backgroundColor = GetColor.themeBlueColor
//        
//        //        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
//        //            //TODO: Delete the row at indexPath here
//        //        }
//        //        deleteAction.backgroundColor = .red
//        if arrPaymentList[indexPath.row].ExternalTransactionStatus ?? "" == "success"
//        {
//            return []
//        }
//        else
//        {
//            return [editAction]//,deleteAction]
//        }
//    }
}
