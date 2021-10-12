//
//  HighlightsVC.swift
//  TestCraft
//
//  Created by ADMS on 25/06/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit

class HighlightsVC: UIViewController {
    var strCorrect = ""
    var strInCorrect = ""
    var strUnanswered = ""
    var strTotal = ""
    var strTestID = ""
    var strStudentTestID = ""
    var strTitle = ""
    var strPass = ""
    var strTotalGetMarks = ""
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
    @IBOutlet weak var btnGotoDashboard: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var btnRegisterViewSolution: UIButton!
//new outlet
    @IBOutlet var viewPopup: UIView!
    @IBOutlet var lblMarks: UILabel!
    @IBOutlet var lblResult: UILabel!
    @IBOutlet var lblCongratulation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strPass = strCorrect
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2200", comment: "Score Pop-up", isFirstTime: "0")
//                    let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//                    print("___result",result)
//                    let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"

//        if isDeeplink == "" &&  strAccountTypeID == "5"
//        {
//            btnRegisterViewSolution.isHidden = true
//            btnGotoDashboard.isHidden = false
//            btnReport.isHidden = false
//        }else{
//            btnRegisterViewSolution.isHidden = false
//            btnGotoDashboard.isHidden = true
//            btnReport.isHidden = true
//        }
        if (Int(strTotalGetMarks)! >= 0)
        {

            if Int(strTotalGetMarks)! == 0
            {
                btnReport.isHidden = true
                btnReport.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
                btnRegisterViewSolution.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
                btnSolution.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
                btnGotoDashboard.setTitleColor(GetColor.successPopupPinkColor, for: .normal)

                viewPopup.backgroundColor = GetColor.successPopupPinkColor
                lblResult.text = "FAIL"
                lblCongratulation.text = "BETTER LUCK NEXT TIME"

            }else{
                btnReport.isHidden = true
                btnReport.setTitleColor(GetColor.successPopupGreenColor, for: .normal)
                btnRegisterViewSolution.setTitleColor(GetColor.successPopupGreenColor, for: .normal)
                btnSolution.setTitleColor(GetColor.successPopupGreenColor, for: .normal)
                btnGotoDashboard.setTitleColor(GetColor.successPopupGreenColor, for: .normal)

                viewPopup.backgroundColor = GetColor.successPopupGreenColor
                lblResult.text = "PASS"
                lblCongratulation.text = "CONGRATULATIONS"
            }


        }
        else
        {
            btnReport.isHidden = true
            btnReport.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
            btnRegisterViewSolution.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
            btnSolution.setTitleColor(GetColor.successPopupPinkColor, for: .normal)
            btnGotoDashboard.setTitleColor(GetColor.successPopupPinkColor, for: .normal)

            viewPopup.backgroundColor = GetColor.successPopupPinkColor
            lblResult.text = "FAIL"
            lblCongratulation.text = "BETTER LUCK NEXT TIME"
        }
////        strCorrect = "01"
////        strInCorrect = "09"
////        strUnanswered = "00"
//        lblCorrect.text = strCorrect + "  Correct"
//        lblIncorrect.text = strInCorrect + "  Incorrect"
//        lblUnanswered.text = strUnanswered + "  Unanswered"
//        lblTotalCorrect.text = strCorrect
//        lblTotal.text = strTotal
        lblTitle.text = strTitle
//        lblMarks.text = strCorrect + "/" + strTotal
//
//        lblCorrect.textColor = GetColor.green
//        lblIncorrect.textColor = GetColor.red
//        lblUnanswered.textColor = GetColor.yellow
//
//        // Do any additional setup after loading the view.

        btnSolution.addShadowWithRadius(0,btnSolution.frame.width/10,1,color: UIColor.white)
        btnSolution.backgroundColor = UIColor.white

        btnGotoDashboard.addShadowWithRadius(0,btnGotoDashboard.frame.width/10,1,color: UIColor.white)
        btnGotoDashboard.backgroundColor = UIColor.white

        btnRegisterViewSolution.addShadowWithRadius(0,btnRegisterViewSolution.frame.width/10,1,color: UIColor.white)
        btnRegisterViewSolution.backgroundColor = UIColor.white

        btnReport.addShadowWithRadius(0,btnReport.frame.width/10,1,color: UIColor.white)
        btnReport.backgroundColor = UIColor.white

        viewPopup.addShadowWithRadius(3,9,0,color: UIColor.clear)
        lblMarks.text = "Marks: " + strTotalGetMarks + "/" + strTotal

//
////        imgCorrect.setImageForName(strCorrect, backgroundColor: GetColor.green, circular: true, textAttributes: nil, gradient: false)
////        imgIncorrect.setImageForName(strInCorrect, backgroundColor: GetColor.red, circular: true, textAttributes: nil, gradient: false)
////        imgUnanswered.setImageForName(strUnanswered, backgroundColor: GetColor.yellow, circular: true, textAttributes: nil, gradient: false)
//
//        lblCorrect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.CorrectClicked (_:))))
//        lblIncorrect.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.InCorrectClicked (_:))))
//        lblUnanswered.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.UnansweredClicked (_:))))

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        if isGotoDashBoard == "1"
        {
            BackToDashbord(VC: self)
        }
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        print("___result",result)
        let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
        if isDeeplink == ""// &&  strAccountTypeID != "5"
               {
                   btnRegisterViewSolution.isHidden = true
                   btnGotoDashboard.isHidden = false
                   btnReport.isHidden = true
               }
//        else if strAccountTypeID != "5"
//        {
//            btnRegisterViewSolution.isHidden = true
//            btnGotoDashboard.isHidden = false
//            btnReport.isHidden = false
//
//        }
        else{
                   btnRegisterViewSolution.isHidden = false
                   btnGotoDashboard.isHidden = true
                   btnReport.isHidden = true
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

    @IBAction func Back_Clicked(_ sender: UIButton)
    {
//                        self.navigationController?.popViewController(animated: false)
//                        self.navigationController?.popViewController(animated: false)

//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)

        //                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as? Test
        //                self.navigationController?.pushViewController(vc!, animated: true)
        //                self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

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
//            }else if controller.isKind(of: SelectExamLangVC.self) {
//                //                            self
//                //                controller.tabBarController!.selectedIndex = 0
//                //                //                                controller.tabBarController?.tabBarItem
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }
        }
    }
    
    @IBAction func Solution_Clicked(_ sender: UIButton)
    {
        //                self.navigationController?.popViewController(animated: false)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2201", comment: "Score and Solutions Button", isFirstTime: "0")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SolutionsVC") as? SolutionsVC
        vc?.strTestID = strTestID
        vc!.strStudentTestID = strStudentTestID
        
        //            SJSwiftSideMenuController.pushViewController(vc!, animated: true)
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    //Go to Intro Screen
    @IBAction func RegesterViewSolution_Clicked(_ sender: UIButton)
    {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
//        vc!.strTestID = strTestID
//        vc!.strStudentTestID = strStudentTestID
//        vc!.strTitle = strTitle
        vc?.isSelectExam = "1000"
        self.navigationController?.pushViewController(vc!, animated: false)
    }

    @IBAction func Reports_Clicked(_ sender: UIButton)
    {
    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportVC") as? ReportVC
//    vc!.strCorrect = strCorrect
//    vc!.strInCorrect = strInCorrect
//    vc!.strUnanswered = strUnanswered
//    vc!.strTotal = strTotal
        vc!.strTestID = strTestID
        vc!.strStudentTestID = strStudentTestID
        vc!.strTitle = strTitle

    self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func GotoDashboard_Clicked(_ sender: UIButton)
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2202", comment: "Back to Dashboard Button", isFirstTime: "0")

        for controller in self.navigationController!.viewControllers as Array {
            //Bhargav Hide
////print(controller)
            if controller.isKind(of: DashboardVC.self) {
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
//                //                controller.tabBarController!.selectedIndex = 0
//                //                //                                controller.tabBarController?.tabBarItem
////                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }

        }
    }
}
