//
//  ReportVC.swift
//  TestCraft
//
//  Created by ADMS on 25/07/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage

class ReportVC: UIViewController, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var arrInfoSummary = [SubmitSummaryListModal]()
    @IBOutlet var viewInfoPopup: UIView!
    @IBOutlet var subViewInfoPopup: UIView!
    @IBOutlet var tblInfo:UITableView!
    @IBOutlet var lblTitleInfo: UILabel!
    @IBOutlet var btnInfo:UIButton!
    @IBOutlet var btnFinalClloseInfo:UIButton!
    
    //    var strCorrect = ""
    //    var strInCorrect = ""
    //    var strUnanswered = ""
    //    var strTotal = ""
    var strTestID = ""
    var strStudentTestID = ""
    var strPass = ""
    var strTitle = ""
    var strTestType = ""
    var TotalQue = ""

    var getTotalMarsk = ""
    
    @IBOutlet var lblCorrect: UILabel!
    @IBOutlet var lblIncorrect: UILabel!
    @IBOutlet var lblUnanswered: UILabel!
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblTotalCorrect: UILabel!
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblTotalQue: UILabel!
    
    @IBOutlet var imgCorrect: UIImageView!
    @IBOutlet var imgIncorrect: UIImageView!
    @IBOutlet var imgUnanswered: UIImageView!
    @IBOutlet var imgTotalQue: UIImageView!
    
    @IBOutlet weak var btnSolution: UIButton!
    @IBOutlet weak var btnTestSummaryReport: UIButton!
    @IBOutlet weak var btnSWAnalysis: UIButton!
    @IBOutlet var lbl_Left_SWAnalysis: UILabel!
    @IBOutlet var lbl_Right_SWAnalysis: UILabel!
    @IBOutlet var lblYourRankIs: UILabel!
    @IBOutlet var imgAIR: UIImageView!
    @IBOutlet var lblPer: UILabel!
    //    @IBOutlet var back_btn_width: NSLayoutConstraint!
    
    //    //new outlet
    //    @IBOutlet var viewPopup: UIView!
    //    @IBOutlet var lblMarks: UILabel!
    //    @IBOutlet var lblResult: UILabel!
    //    @IBOutlet var lblCongratulation: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnFinalClloseInfo.setTitleColor(UIColor.white, for: .normal)
        btnFinalClloseInfo.backgroundColor = UIColor(rgb: 0x10A8DD) //GetColor.blueHeaderText
        btnFinalClloseInfo.addShadowWithRadius(2, btnFinalClloseInfo.frame.width/6, 0, color: GetColor.blueHeaderText)
        subViewInfoPopup.addShadowWithRadius(7,6.0,0,color: UIColor.darkGray)
        lbl_Left_SWAnalysis.text = "Strengths"
        lbl_Right_SWAnalysis.text = "Weakness"
        //        strPass = strCorrect
        //        if strPass == "0"
        //        {
        //            btnSolution.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
        //            viewPopup.backgroundColor = GetColor.successPopupPinkColor
        //            lblResult.text = "FAIL"
        //            lblCongratulation.text = "BETTER LUCK NEXT TIME"
        //        }
        //        else
        //        {
        //            btnSolution.setTitleColor(GetColor.successPopupGreenColor, for: .normal)
        //            viewPopup.backgroundColor = GetColor.successPopupGreenColor
        //            lblResult.text = "PASS"
        //            lblCongratulation.text = "CONGRATULATIONS"
        //        }
        //        strCorrect = "01"
        //        strInCorrect = "09"
        //        strUnanswered = "00"
        
        Get_StudentTestAnswer_ReportApi()
        viewInfoPopup.isHidden = true
        lblCorrect.textColor = GetColor.green
        lblIncorrect.textColor = GetColor.red
        lblUnanswered.textColor = GetColor.yellow
        //        lblTotalQue.textColor = GetColor.darkGray
        
        // Do any additional setup after loading the view.
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2300", comment: "Score and Solutions Screen", isFirstTime: "0")
        
        btnSolution.addShadowWithRadius(0,btnSolution.frame.width/11,0,color: UIColor.white)
        btnTestSummaryReport.addShadowWithRadius(0,btnSolution.frame.width/11,0,color: UIColor.white)
        GetReview()
        //        btnSolution.backgroundColor = UIColor.white
        //        viewPopup.addShadowWithRadius(1,9,0,color: UIColor.clear)
        //        lblMarks.text = "Marks: " + strCorrect + ""
        //
        ////        imgCorrect.setImageForName(strCorrect, backgroundColor: GetColor.green, circular: true, textAttributes: nil, gradient: false)
        ////        imgIncorrect.setImageForName(strInCorrect, backgroundColor: GetColor.red, circular: true, textAttributes: nil, gradient: false)
        ////        imgUnanswered.setImageForName(strUnanswered, backgroundColor: GetColor.yellow, circular: true, textAttributes: nil, gradient: false)
        //
        //        lblCorrect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.CorrectClicked (_:))))
        //        lblIncorrect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.InCorrectClicked (_:))))
        //        lblUnanswered.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.UnansweredClicked (_:))))
        //        let gradient: CAGradientLayer = CAGradientLayer()
        //        gradient.frame.size = self.btnSWAnalysis.frame.size//btnSWAnalysis.bounds
        //        gradient.colors = [
        //            UIColor.green.cgColor,
        //            UIColor.green.cgColor,
        //            UIColor.blue.cgColor,
        //            UIColor.blue.cgColor
        //        ]
        //        gradient.frame.size.width = gradient.frame.size.width + 20
        //btnSWAnalysis.addShadowWithRadius(0,btnSWAnalysis.frame.width/11,0,color: UIColor.white)
        //        /* repeat the central location to have solid colors */
        //        gradient.locations = [0, 0.5, 0.5, 0]
        //
        //        /* make it horizontal */
        //        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        //        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        //
        //        btnSWAnalysis.layer.insertSublayer(gradient, at: 0)
        //
        
        //        self.btnSWAnalysis.applyGradient(colours: [.yellow, .blue])
        
        //        let string1 = "..."
        //        let string2 = "..."
        //
        //        let att = NSMutableAttributedString(string: "\(string1)\(string2)");
        //        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: string1.count))
        //        att.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.blue, range: NSRange(location: 0, length: string1.count))
        //        att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location: string1.count, length: string2.count))
        //        btnSWAnalysis.setAttributedTitle(att, for: .normal)
        
    }
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    ////        roundCorners(corners: [.topLeft, .topRight], radius: 3.0)
    //    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLog("bounds = \(self.view.bounds)")
        btnSWAnalysis.addShadowWithRadius(0,30,0,color: UIColor.white)
        /* repeat the central location to have solid colors */
        lbl_Left_SWAnalysis.backgroundColor = GetColor.darkGreen
        lbl_Right_SWAnalysis.backgroundColor = GetColor.tomatoRed
        lbl_Left_SWAnalysis.roundCorners(corners: [.topLeft, .bottomLeft], radius: 30)
        lbl_Right_SWAnalysis.roundCorners(corners: [.topRight, .bottomRight], radius: 30)
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            //Bhargav Hide
//            let gradient: CAGradientLayer = CAGradientLayer()
//            gradient.frame = btnSolution.bounds
//            gradient.colors = [
//                GetColor.darkGreen.cgColor,
//                GetColor.darkGreen.cgColor,
//                GetColor.tomatoRed.cgColor,
//                GetColor.tomatoRed.cgColor
//            ]
//
//            /* repeat the central location to have solid colors */
//            gradient.locations = [0, 0.5, 0.5, 1.0]
//
//            /* make it horizontal */
//            gradient.startPoint = CGPoint(x: 0, y: 0.5)
//            gradient.endPoint = CGPoint(x: 1, y: 0.5)
////            let gradient: CAGradientLayer = CAGradientLayer()
////
////            gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
////            gradient.locations = [0.0 , 1.0]
////            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
////            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
////            gradient.frame = btnSWAnalysis.bounds
////            //CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
////
////            //self.view.layer.insertSublayer(gradient, at: 0)
////
//            btnSWAnalysis.layer.insertSublayer(gradient, at: 0)
//
//        }else{
//            let gradient: CAGradientLayer = CAGradientLayer()
//            gradient.frame.size = self.btnSWAnalysis.frame.size//btnSWAnalysis.bounds
//            gradient.colors = [
//                GetColor.darkGreen.cgColor,
//                GetColor.darkGreen.cgColor,
//                GetColor.tomatoRed.cgColor,
//                GetColor.tomatoRed.cgColor
//            ]
//            gradient.frame.size.width = gradient.frame.size.width
//
//            gradient.locations = [0, 0.5, 0.5, 1]
//
//            /* make it horizontal */
//            gradient.startPoint = CGPoint(x: 0, y: 0.5)
//            gradient.endPoint = CGPoint(x: 1.25, y: 0.5)
//            btnSWAnalysis.layer.insertSublayer(gradient, at: 0)
//
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        //        if isDeeplink == "1"
        //        {
        //            back_btn_width.constant = 0
        //        }
        
        if isGotoDashBoard == "1"
        {
            BackToDashbord(VC: self)
        }
    }

    @objc func CorrectClicked(_ sender: UITapGestureRecognizer) {
        //Bhargav Hide
        ////print("tap CorrectClicked")
    }
    @objc func InCorrectClicked(_ sender: UITapGestureRecognizer) {
        //Bhargav Hide
        ////print("tap InCorrectClicked")
    }
    @objc func UnansweredClicked(_ sender: UITapGestureRecognizer) {
        //Bhargav Hide
        ////print("tap UnansweredClicked")
    }
    @IBAction func SWAnalysis_Clicked(_ sender: UIButton)
    {
        //        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2301", comment: "View Solutions Button", isFirstTime: "0")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "StudentTestSWAnalysisVC") as? StudentTestSWAnalysisVC
        vc?.strTestID = strTestID
        vc!.strStudentTestID = strStudentTestID
        //        vc!.strTestTitle = self.strTitle
        //        vc!.strTotalQuetion = TotalQue
        
        //            SJSwiftSideMenuController.pushViewController(vc!, animated: true)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func TestSummaryReportSolution_Clicked(_ sender: UIButton)
    {
        //        if strTestType == "1"
        //        {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2302", comment: "Summary Report", isFirstTime: "0")
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        vc?.strTitle = "Test Summary Report"
        vc?.strLoadUrl = "\(API.hostName)TestSummaryReport.aspx?STID=\(self.strStudentTestID)&chap=1"
        self.navigationController?.pushViewController(vc!, animated: true)
        //        }
        //        else
        //        {
        //            let alert = AlertController(title: "", message: "Test Summary Report", preferredStyle: .alert)
        //            //                alert.setTitleImage(UIImage(named: "risk_blue"))
        //            let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 16.0)!]
        //            let titleAttrString = NSMutableAttributedString(string: "Test Summary Report", attributes: titleFont)
        //            alert.setValue(titleAttrString, forKey: "attributedMessage")
        //
        //            // Add actions
        //            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
        //                //            self.runProdTimer()
        //            })
        //            //        action.actionImage = UIImage(named: "close")
        //            alert.addAction(UIAlertAction(title: "Chapter wise", style: .destructive, handler: {(alert: UIAlertAction!) in
        //
        //                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        //                vc?.strTitle = "Test Summary Report"
        //                vc?.strLoadUrl = "\(API.hostName)TestSummaryReport.aspx?STID=\(self.strStudentTestID)&chap=1"
        //                self.navigationController?.pushViewController(vc!, animated: true)
        //            }))
        //            alert.addAction(UIAlertAction(title: "Topic wise", style: .destructive, handler: {(alert: UIAlertAction!) in
        //
        //                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        //                vc?.strTitle = "Test Summary Report"
        //                vc?.strLoadUrl = "\(API.hostName)TestSummaryReport.aspx?STID=\(self.strStudentTestID)"
        //                self.navigationController?.pushViewController(vc!, animated: true)
        //            }))
        //            alert.addAction(action)
        //
        //            self.present(alert, animated: true, completion: nil)
        //        }
        
    }
    @IBAction func Back_Clicked(_ sender: UIButton)
    {
        //        self.navigationController?.popViewController(animated: false)
        for controller in self.navigationController!.viewControllers as Array {
            //Bhargav Hide
            ////print(controller)
            if controller.isKind(of: MyPackageListVCViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
//            else if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                //                            self
//                controller.tabBarController!.selectedIndex = 0
//                //                                controller.tabBarController?.tabBarItem
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }
                //            else if controller.isKind(of: SelectExamLangVC.self) {
                //                //                            self
                ////                controller.tabBarController!.selectedIndex = 0
                ////                //                                controller.tabBarController?.tabBarItem
                //                self.navigationController!.popToViewController(controller, animated: false)
                //                break
                //            }
            else
            {
                if ((UserDefaults.standard.value(forKey: "exam_preferences")) != nil)
                {
                    let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                    popupVC.selectedIndex = 1
                    selectedPackages = 1
                    add(asChildViewController: popupVC, self)
                    
                }
                else{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
//                    self.navigationController?.pushViewController(vc!, animated: false)
                }
            }
        }
    }
    @IBAction func Solution_Clicked(_ sender: UIButton)
    {
        //                self.navigationController?.popViewController(animated: false)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2301", comment: "View Solutions Button", isFirstTime: "0")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SolutionsVC") as? SolutionsVC
        vc?.strTestID = strTestID
        vc!.strStudentTestID = strStudentTestID
        vc!.strTestTitle = self.strTitle
        vc!.strTotalQuetion = TotalQue
        
        //            SJSwiftSideMenuController.pushViewController(vc!, animated: true)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func Info_Clicked(_ sender: UIButton)
    {
        self.tabBarController?.tabBar.isHidden = true
        viewInfoPopup.isHidden = false
        Pre_Info_Test_Api()
    }
    @IBAction func Info_Popup_Close_Clicked(_ sender: UIButton)
    {
        self.tabBarController?.tabBar.isHidden = false
        viewInfoPopup.isHidden = true
    }
    func Get_StudentTestAnswer_ReportApi()
    {
        showActivityIndicator()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)
        
        let params = ["StudentTestID":strStudentTestID]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_StudentTestAnswer_ReportApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API.Get_StudentTestAnswer_ReportApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    var crct = ""
                    var Incrct = ""
                    var NotAnswer = ""
                    var Total = ""
                    var TotalGetMarks = ""
                    //                    var ExamType = ""
                    var AIR = ""
                    for value in arrData! {
                        
                        crct = value["Correct"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        Incrct = value["Wrong"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        NotAnswer = value["UnAnswered"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        Total = value["TotalMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        TotalGetMarks = value["TotalGetMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        AIR = value["AIR"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        self.TotalQue = value["TotalQue"].stringValue
                        self.strTestType = "\(value["IsCompetetive"].stringValue)"

                        self.getTotalMarsk = "Internal Rank: \(value["InternalRank"].stringValue)"




//                        if AIR == "" {self.lblYourRankIs.text = "Internal Rank: \(value["InternalRank"].stringValue)"} else {self.lblYourRankIs.text = "AIR: \(value["AIR"].stringValue)"}
                        self.lblPer.text = "Percentile: \(value["Percentile"].stringValue)" + "     Percentage: \(value["percentage"].stringValue)%"
                        if isSubscription == "1"
                        {
                            self.lblPer.text = "Percentage: \(value["percentage"].stringValue)%"
                        }

                    }
                    self.lblCorrect.text = crct + "  Correct"
                    self.lblIncorrect.text = Incrct + "  Incorrect"
                    self.lblUnanswered.text = NotAnswer + "  Unanswered"
                    self.lblTotalQue.text = "Total Questions:  "  + self.TotalQue
                    self.lblTotalCorrect.text = TotalGetMarks
                    self.lblTotal.text = Total
                    self.lblTitle.text = self.strTitle
                    if self.strTestType == "1"
                    {

                        if (Int(TotalGetMarks)! >= 0)
                        {

                            if Int(TotalGetMarks)! == 0
                            {
                                self.imgAIR.isHidden = true
                                self.lblYourRankIs.isHidden = true

                            }else{
                                self.lblYourRankIs.isHidden = false
                                self.imgAIR.isHidden = false
                                self.lblYourRankIs.text = self.getTotalMarsk
                            }
                        }else{
                            self.imgAIR.isHidden = true
                            self.lblYourRankIs.isHidden = true
                        }

                        self.btnInfo.isHidden = false; self.btnSWAnalysis.isHidden = false;
                        self.lbl_Left_SWAnalysis.isHidden = false; self.lbl_Right_SWAnalysis.isHidden = false;
//                        self.lblYourRankIs.isHidden = false; self.imgAIR.isHidden = false
                    }
                    else
                    {
                        self.btnInfo.isHidden = true; self.btnSWAnalysis.isHidden = false;
                        self.lbl_Left_SWAnalysis.isHidden = false; self.lbl_Right_SWAnalysis.isHidden = false;
                        self.lblYourRankIs.isHidden = false;
                        self.imgAIR.isHidden = false
                    }
                    if isSubscription == "1"
                    {
                        self.lblYourRankIs.text = ""
                        self.imgAIR.isHidden = true
                    }

                    //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
                    //                    vc!.strCorrect = "\(crct)"
                    //                    vc!.strInCorrect = "\(Incrct)"
                    //                    vc!.strUnanswered = "\(NotAnswer)"
                    //                    vc!.strTotal = "\(Total)"
                    //                    vc!.strTestID = self.strTestID
                    //                    vc!.strStudentTestID = self.strStudentTestID
                    //                    vc!.strTitle = self.strTitle
                    //                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                }
                else
                {
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                
            }
        }
    }
    func Pre_Info_Test_Api()
    {
        //                api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2003", comment: "Info Icon", isFirstTime: "0")
        self.viewInfoPopup.isHidden = false
        showActivityIndicator()
        let params = ["StudentTestID":strStudentTestID]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Subject_wise_marksApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblInfo.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API.Subject_wise_marksApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.arrInfoSummary.removeAll()
            self.hideActivityIndicator()
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    for value in arrData! {
                        
                        let summaryModel:SubmitSummaryListModal = SubmitSummaryListModal.init(id: "\(value[""].stringValue)", title: "\(value["SubjectName"].stringValue)", Attempted: "\(value["Answered"].stringValue)", NotAttempted: "\(value["UnAnswered"].stringValue)", SubjectName: "\(value["SubjectName"].stringValue)", TotalQue: "\(value["TotalQue"].stringValue)", ObtainMark: "\(value["ObtainMark"].stringValue)")
                        self.arrInfoSummary.append(summaryModel)
                    }
                    self.tblInfo.reloadData()
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                    //                        self.runProdTimer()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                //                    self.runProdTimer()
            }
        }
    }
    func GetReview() {
        //Bhargav Hide
//        showActivityIndicator()

        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_AppRatingRatingApi,params,result)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
//            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_AppRatingRatingApi, method: .post, parameters: params, headers: headers).validate().responseJSON { [self] response in
//            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print("Response",API.Get_AppRatingRatingApi,json)

                if(json["Status"] == "true" || json["Status"] == "1")
                {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReatingPopupVC") as! ReatingPopupVC
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.modalTransitionStyle = .crossDissolve
//                    vc.strTestID = self.strTestID
//                    vc.strStudentTestID = strStudentTestID
                    self.present(vc, animated: true, completion: {
                        self.tabBarController?.tabBar.isHidden = true
                    })
//                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

                }
                else
                {
//                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
}

extension ReportVC:UITableViewDataSource,UITableViewDelegate
{
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.arrInfoSummary.count
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if let height = self.rowHeights[indexPath.row]{
        //            return height
        //        }
//        if tableView == tblInfo{
            return UITableView.automaticDimension
//        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        tableView.layer.removeAllAnimations()
        //        UITableView.setAnimationsEnabled(false)
//        if tableView == tblInfo{
            let identifier = "SubmitSummaryTableViewCell"
            var cell: SubmitSummaryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SubmitSummaryTableViewCell
            if cell == nil {
                tableView.register(UINib(nibName: "SubmitSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SubmitSummaryTableViewCell
            }
            cell.lbl_Title.text = "\(self.arrInfoSummary[indexPath.row].title ?? "")"
            cell.lbl_Attempted.text = "\(self.arrInfoSummary[indexPath.row].ObtainMark ?? "")"
            cell.lbl_NotAttempted.text = "\(self.arrInfoSummary[indexPath.row].TotalQue ?? "")"

            return cell
//        }
//        else
//
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView == tblSubmit

    }


}
