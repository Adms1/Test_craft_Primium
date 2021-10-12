//
//  PaymentSuccessVC.swift
//  TestCraftLite
//
//  Created by ADMS on 13/04/21.
//

import UIKit

class PaymentSuccessVC: UIViewController {

    @IBOutlet weak var btnClickDashboard:UIButton!
    @IBOutlet weak var imgFailSuccess:UIImageView!
    @IBOutlet weak var lblPaymentText:UILabel!

    var strPaymentStatus:String = ""
    var setRootvc:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        btnClickDashboard.isHidden = false
        imgFailSuccess.isHidden = false
        lblPaymentText.isHidden = false

        btnClickDashboard.layer.cornerRadius = btnClickDashboard.layer.frame.height / 2.0
        btnClickDashboard.layer.masksToBounds = true


        if strPaymentStatus == "success"{
            lblPaymentText.text = "Your transation has been successfully completed."
            imgFailSuccess.image = UIImage(named:"true-green-dot.png")
        }else{
            lblPaymentText.text = "Your transation has been failed."
            imgFailSuccess.image = UIImage(named:"false-red-dot.png")
        }


    }

    @IBAction func btnClickGoToDashbaord(){


        if self.setRootvc == "MyPackageListVCViewController"
        {
            for controller in self.navigationController!.viewControllers as Array {
                                        //Bhargav Hide
                            ////print(controller)
                                        if controller.isKind(of: MyPackageListVCViewController.self) {
                                            self.navigationController!.popToViewController(controller, animated: true)
                                            break
                                        }

                                    }
        }else{

            self.tabBarController?.selectedIndex = 0
            self.navigationController?.popToRootViewController(animated: false)

//            let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//            popupVC.selectedIndex = 0
//            add(asChildViewController: popupVC, self)

        }


    }
    
}
