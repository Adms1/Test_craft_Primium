//
//  SuccessVC.swift
//  TestCraft
//
//  Created by ADMS on 07/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
//import SJSwiftSideMenuController

class SuccessVC: UIViewController {

    @IBOutlet var lblMsg: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var isSelectExam = ""
    var isRegistered = ""
    var DicReg : [String : AnyObject] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        btnDone.layer.cornerRadius = 30.0
            btnDone.layer.frame.height / 2.0
        btnDone.layer.masksToBounds = true

        // Do any additional setup after loading the view.
        lblMsg.text = "Your mobile number has been successfully verified."
//        lblMsg.textColor = UIColor(rgb: 0x77B34D)
        btnDone.addShadowWithRadius(0,btnDone.frame.width/9,1,color: GetColor.signInText)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "500", comment: "OTP Verified", isFirstTime: "0")
        UserDefaults.standard.set("", forKey: "Deeplink")
        isDeeplink = ""

        if isRegistered == "1" || isRegistered == "2" || isRegistered == "0" 
        {
            btnBack.isHidden = true
        }
    }
    
    @IBAction func Back_Clicked(_ sender: UIButton) {
      
        if isForgot == "1"
        {
            self.navigationController?.popViewController(animated: true)
        }
        else
        {
            if isSelectExam == "1"// || isRegistered == "1"

            {
//                for controller in self.navigationController!.viewControllers as Array {
//                    if controller.isKind(of: SelectExamVC.self) {
//                        self.navigationController!.popToViewController(controller, animated: true)
//                        break
//                    }
//                }
            }
            else if isSelectExam == "2"// || isRegistered == "2"
            {
//                for controller in self.navigationController!.viewControllers as Array {
//                    if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                        self.navigationController!.popToViewController(controller, animated: true)
//                        break
//                    }
//                }
            }
            else
            {
                for controller in self.navigationController!.viewControllers as Array {
                    //Bhargav Hide
                    ////print(controller)
                    if controller.isKind(of: IntroVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
        }
    }

    
    @IBAction func Ok_Clicked(_ sender: UIButton)
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "501", comment: "Done Button", isFirstTime: "0")

        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as? OTPVC
        //        self.navigationController?.pushViewController(vc!, animated: true)
        //        self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
        //        for controller in self.navigationController!.viewControllers as Array {
        //            if controller.isKind(of: LoginVC.self) {
        //                self.navigationController!.popToViewController(controller, animated: false)
        if isForgot == "1"
        {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SetNewPasswordVC") as? SetNewPasswordVC
//            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            if isSelectExam == "1" || isSelectExam == "2"
            {
                for controller in self.navigationController!.viewControllers as Array {
                    //Bhargav Hide
//                    print(controller)
//                    if controller.isKind(of: SelectExamVC.self) && isSelectExam == "1"
//                    {
//                        self.navigationController!.popToViewController(controller, animated: false)
//                        break
//                    }
//                    if controller.isKind(of: MarketPlaceMultiBoxVC.self) && isSelectExam == "2"
//                    {
//                        self.navigationController!.popToViewController(controller, animated: false)
//                        break
//                    }
                }
                let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                popupVC.selectedIndex = 0
                popupVC.strtemo_Selected = "0"
                selectedPackages = 0
                add(asChildViewController: popupVC, self)
                //break
            }else{
                if isRegistered == "2"
                {
                    //MarketPlaceMultiBoxVC
//                    for controller in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//                        print(controller)
////                        if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
////                            self.navigationController!.popToViewController(controller, animated: false)
////                            break
////                        }
//                    }
                    let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//                    popupVC.selectedIndex = 0
//                    popupVC.strtemo_Selected = "0"
//                    selectedPackages = 0
                    popupVC.selectedIndex = 1
                    popupVC.strtemo_Selected = "1"
                    selectedPackages = 1
                    add(asChildViewController: popupVC, self)

                }
                else if isRegistered == "1"
                {
//                    for controller in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//                        print(controller)
////                        if controller.isKind(of: SelectExamVC.self) {
////                            self.navigationController!.popToViewController(controller, animated: false)
////                            break
////                        }
//                    }
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileEditVC") as? ProfileEditVC
//                    vc?.isHiden = "1"
//                    self.navigationController?.pushViewController(vc!, animated: true)


//                    if IsFreeFirstTime == ""
//                    {
//                        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//                        popupVC.selectedIndex = 1
//                        popupVC.strtemo_Selected = "1"
//                        selectedPackages = 1
//                        add(asChildViewController: popupVC, self)
//                    }else{
                        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                        popupVC.selectedIndex = 1
                        popupVC.strtemo_Selected = "1"
                        selectedPackages = 1
                        add(asChildViewController: popupVC, self)
//                    }





                }else{

//                    if  UserDefaults.standard.bool(forKey:"isFirstTimeShow") == true{
//                        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//                        popupVC.selectedIndex = 0
//                        popupVC.strtemo_Selected = "0"
//                        selectedPackages = 0
//                        add(asChildViewController: popupVC, self)
//                    }else{
                        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                        popupVC.selectedIndex = 1
                        popupVC.strtemo_Selected = "1"
                        selectedPackages = 1
                        add(asChildViewController: popupVC, self)
                   // }




//                    for controller in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//                        print(controller)
//                        if controller.isKind(of: OtherVC.self) {
//                            self.navigationController!.popToViewController(controller, animated: false)
//                            break
//                        }
//                        //else
////                            if controller.isKind(of: DeeplinkTestListVC.self) {
////                                self.navigationController!.popToViewController(controller, animated: false)
////                                break
////                            }
////                            else
////                                if controller.isKind(of: HighlightsVC.self) {
////                                    self.navigationController!.popToViewController(controller, animated: false)
////                                    break
////                                }
//                                    //                 else
//                                    //                    if controller.isKind(of: PackageDetailsVC.self) {
//                                    //                     self.navigationController!.popToViewController(controller, animated: false)
//                                    //                     break
//                                    //                 }else
//                                    //                 if controller.isKind(of: TestListVC.self) {
//                                    //                     self.navigationController!.popToViewController(controller, animated: false)
//                                    //                     break
//                                    //                 }
//                                    //                 else if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                                    //                     controller.tabBarController!.selectedIndex = 0
//                                    //                     //                                controller.tabBarController?.tabBarItem
//                                    //                     self.navigationController!.popToViewController(controller, animated: false)
//                                    //                     break
//                                    //                 }
//                                else
//                                {
//                        }
//                    }
                }
            }
        }
    }
}
