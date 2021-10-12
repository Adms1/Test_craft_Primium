//
//  OTPVC.swift
//  TestCraft
//
//  Created by ADMS on 06/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
//import KWVerificationCodeView
import Toast_Swift
import Alamofire
import SwiftyJSON
var strMobileNumber = ""
var strCode = ""

class OTPVC: UIViewController, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    //    @IBOutlet var txtOTP:TweeAttributedTextField!
    @IBOutlet weak var btnVerifyCode: UIButton!
    @IBOutlet weak var verificationCodeView: PinCodeTextField!//KWVerificationCodeView!
    @IBOutlet weak var txtOne: UITextField!//KWVerificationCodeView!

//    @IBOutlet weak var txtOTP1: UITextField!
//    @IBOutlet weak var txtOTP2: UITextField!
//    @IBOutlet weak var txtOTP3: UITextField!
//    @IBOutlet weak var txtOTP4: UITextField!
//    @IBOutlet weak var txtOTP5: UITextField!
//    @IBOutlet weak var txtOTP6: UITextField!


    @IBOutlet var scrlView: UIScrollView!
    @IBOutlet var lblDisplayMsg: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    var txtName = ""
    var txtLastName = ""
    var txtEmail = ""
    var txtPassword = ""
    var txtConfirmPassword = ""
    var txtMobile = ""
    var txtAccountTypeID = ""
    @IBOutlet var lblMsgWithNumber: UILabel!
    //    var strMobileNumber = ""
    //    var strCode = ""
    var isSelectExam = ""
    var isRegistered = ""
    var intCount = 0
    var DicReg : [String : AnyObject] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        btnVerifyCode.layer.cornerRadius = 30.0
        btnVerifyCode.layer.frame.height / 2.0
        btnVerifyCode.layer.masksToBounds = true


        // Do any additional setup after loading the view.
//        btnVerifyCode.addShadowWithRadius(0,btnVerifyCode.frame.width/9,1,color: GetColor.signInText)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "400", comment: "Verification Code Screen", isFirstTime: "0")
        print("DicReg : ",DicReg)
        //        btnVerifyCode.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            //            self.verificationCodeView.becomeFirstResponder()
            self.txtOne.becomeFirstResponder()
//
        }
        //        scrlView.contentSize = CGSizeMake(400, 2300)
        scrlView.contentSize = CGSize(width: scrlView.contentSize.width, height: 600)
        
        //        verificationCodeView.delegate = self
        //        verificationCodeView.keyboardType = .default
        //        verificationCodeView.keyboardType = .phonePad
        //        if #available(iOS 12.0, *) {
        //            txtotp.textContentType = .oneTimeCode
        //            txtotp.keyboardType = .numberPad
        //        } else {
        //            // Fallback on earlier versions
        //        }

        //        if #available(iOS 12.0, *) {
        //            txtOne.textContentType = .oneTimeCode
        //        }
        //self.txtOne.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        //self.txtOne.becomeFirstResponder()



        //

        self.addDoneButtonOnKeyboard()
        //Bhargav Hide
        ////print("OTP CODE:",strCode)
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        //        self.view.addGestureRecognizer(tapGesture)
        self.lblDisplayMsg.text = ""

        //        var result:[String:String] = [:]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
            if strMobileNumber != ""{
                lblMsgWithNumber.text = "Please enter verification code sent to +91 " + strMobileNumber
            }else{
                let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

                lblMsgWithNumber.text = "Please enter verification code sent to +91 " + "\(result.value(forKey: "StudentMobile") ?? "")"}
        }
        else if strMobileNumber != ""
        {
            lblMsgWithNumber.text = "Please enter verification code sent to +91 " + strMobileNumber
        }
        //        if isOTPScreenOpen == "1"
        //        {
        //            for controller in self.navigationController!.viewControllers as Array {
        //                //Bhargav Hide
        ////print(controller)
        //                if controller.isKind(of: SelectExamVC.self) {
        ////                    SelectExamVC.removeFromParent(<#T##UIViewController#>)
        //                    var navigationArray = self.navigationController!.viewControllers as Array //To get all UIViewController stack as Array
        //                    navigationArray.remove(at: (navigationArray.count) - 2) // To remove previous UIViewController
        //
        //                    break
        //                }
        //            }
        //        }
        //        else
        //        {
        //
        //        }
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

        // Keyboard Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrlView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 60
        scrlView.contentSize = CGSize(width: scrlView.contentSize.width, height: contentInset.bottom)
        //        scrlView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)

        scrlView.contentInset = contentInset
        scrlView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)

    }
    
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        //        scrlView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        scrlView.contentInset = contentInset
        scrlView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        //        aTextField.resignFirstResponder()
        view.endEditing(true)

    }

    

    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        //        verificationCodeView.inputAccessoryView = doneToolbar
        //        otpView.inputAccessoryView = doneToolbar

        txtOne.inputAccessoryView = doneToolbar

    }
    
    @objc func doneButtonAction(){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        //        self.scrlView.contentInset = contentInset
        view.endEditing(true)
    }
    override public var prefersStatusBarHidden: Bool {
        return false
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @objc private func pinCodeNextAction() {
        //Bhargav Hide
        ////print("next tapped")
    }

    @IBAction func VerifyCode_Clicked(_ sender: UIButton)
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "402", comment: "Verify The Code Button", isFirstTime: "0")
        view.endEditing(true)
        if validated() == true
        {
            //        if verificationCodeView.hasValidCode() {
            if isForgot == "1"
            {
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SetNewPasswordVC") as? SetNewPasswordVC
//                self.navigationController?.pushViewController(vc!, animated: true)
            }
            else
            {
                //            api_Verify_Account()
                if isSelectExam == "1" || isSelectExam == "2"
                {
                    apiUpdate()
                }
                else
                {
                    if isRegistered == "1" || isRegistered == "2" 
                    {
                        UserDefaults.standard.set(DicReg, forKey: "logindata")
                        //                        UserDefaults.standard.set(DicReg["Preference"]?[0], forKey: "exam_preferences")

                        UserDefaults.standard.set("1", forKey: "isLogin")
                        self.api_Send_Token()

                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessVC") as? SuccessVC
                        UserDefaults.standard.set(strCode, forKey: "OTP")
                        vc?.DicReg = DicReg
                        vc?.isRegistered = isRegistered
                        self.navigationController?.pushViewController(vc!, animated: true)
                        // self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

                    }else{
                        apiSignUp()
                    }
                }
            }
            //        Success_msg()
        }
        else
        {
            //            self.view.makeToast("Please enter OTP.", duration: 3.0, position: .bottom)
            // txtOTP.showInfo("Please enter OTP.")
        }
        
    }
    
    @IBAction func Resend_Clicked(_ sender: UIButton) {
        //Resend OTP Code
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "401", comment: "Resend Link", isFirstTime: "0")

        apiResend()
    }

    @IBAction func Back_Clicked(_ sender: UIButton) {
        //        navigationController?.popViewController(animated: true)
        if isForgot == "1"
        {
            self.navigationController?.popViewController(animated: true)
        }
        else if isSelectExam == "1" || isSelectExam == "2"
        {
            self.navigationController?.popViewController(animated: true)
        }
        else {
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

    func validated() -> Bool {
        var valid: Bool = true
        let strOTPCode : String = "\(txtOne.text ?? "")"
        let trimmedString = strOTPCode.removeWhitespace()//.trimmingCharacters(in: .whitespaces)
        self.lblDisplayMsg.text = ""
        if trimmedString == ""{
            //            txtOTP.showInfo("Please enter OTP.")
            self.view.makeToast("Please enter OTP.", duration: 3.0, position: .bottom)
            valid = false
        }
        else if trimmedString.count < 6
        {
            //Bhargav Hide
            ////print("Final_____ :",trimmedString)
            valid = false
        }
        else if strOTPCode != strCode{
            //            txtOTP.showInfo("Please enter OTP.")
            //            self.view.makeToast("OTP not matched.", duration: 3.0, position: .bottom)
            self.lblDisplayMsg.text = "Invalid code, Please re-enter."
            self.txtOne.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.txtOne.becomeFirstResponder()
            }

            valid = false
        }


        return valid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    //    func api_Verify_Account()
    //    {
    //        strCode = ""
    //        showActivityIndicator()
    //        let params = ["MobileNumber":strMobileNumber]
    //        let headers = [
    //            "Content-Type": "application/x-www-form-urlencoded"
    //        ]
    //        //Bhargav Hide
    //print("API, Params: \n",API.Verify_AccountApi,params)
    //
    //        Alamofire.request(API.Verify_AccountApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
    //            self.hideActivityIndicator()
    //
    //            switch response.result {
    //            case .success(let value):
    //
    //                let json = JSON(value)
    //                //Bhargav Hide
    ////print(json)
    //
    //                if(json["Status"] == "true" || json["Status"] == "1") {
    ////                    let jsonArray = json["data"].stringValue//[0].dictionaryObject!
    ////                    UserDefaults.standard.set(jsonArray, forKey: "logindata")
    ////                    UserDefaults.standard.set("1", forKey: "isLogin")
    ////
    ////                    strCode = "\(jsonArray)" // OTP
    ////                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
    //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessVC") as? SuccessVC
    //                    self.navigationController?.pushViewController(vc!, animated: true)
    //
    //                }
    //                else
    //                {
    //                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
    //                }
    //            case .failure(let error):
    //                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
    //
    //            }
    //        }
    //    }
    func apiUpdate()
    {
        showActivityIndicator()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params =  ["StudentID":"\(result.value(forKey: "StudentID") ?? "")",
                       "StudentFirstName":txtName,
                       "StudentLastName":txtLastName,
                       "StudentEmailAddress":txtEmail,
                       "StudentPassword":txtPassword,
                       "StudentMobile":txtMobile,
                       "StatusID":"1",
                       "AccountTypeID":txtAccountTypeID,
                       "apple_user_id":"",
                       "deviceid":"1",
                       "UDID":"\(UserDefaults.standard.object(forKey: "UUID") ?? "")"]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.EditProfileApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.EditProfileApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let jsonArray = json["data"][0].dictionaryObject!
                    UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")
                    UserDefaults.standard.set("1", forKey: "isLogin")
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessVC") as? SuccessVC
//                    vc!.isSelectExam = self.isSelectExam//"1"
//                    self.navigationController?.pushViewController(vc!, animated: true)

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

    func apiSignUp()
    {
        strCode = ""
        showActivityIndicator()
        var StdIDTemp = "0"
        var result : NSMutableDictionary = [:]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            
            result = UserDefaults.standard.value(forKey: "logindata") as! NSMutableDictionary
            let Temp_AccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
            if (Temp_AccountTypeID == "5"){
                StdIDTemp = "\(result.value(forKey: "StudentID") ?? "")"}
        }
        //        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")",

        let params = ["StudentID":StdIDTemp,//"\(St_ID)",
                      "StudentFirstName":txtName,
                      "StudentLastName":txtLastName,
                      "StudentEmailAddress":txtEmail,
                      "StudentPassword":txtPassword,
                      "StudentMobile":txtMobile,
                      "StatusID":"1",
                      "AccountTypeID":txtAccountTypeID,
                      "apple_user_id":"",
                      "deviceid":"1",
                      "UDID":"\(UserDefaults.standard.object(forKey: "UUID") ?? "")"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.RegistrationApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.RegistrationApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let jsonArray = json["data"][0].dictionaryObject!
                    UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")
                    UserDefaults.standard.set("1", forKey: "isLogin")
                    self.api_Send_Token()

                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessVC") as? SuccessVC
                   // vc?.DicReg = self.DicReg
                    vc?.isRegistered = self.isRegistered
                    self.navigationController?.pushViewController(vc!, animated: true)

                }
                else
                {
                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print("API, error: \n",API.RegistrationApi,error)
            }
        }
    }

    func apiResend()
    {
        strCode = ""
        self.lblDisplayMsg.text = ""

        showActivityIndicator()
        let params = ["StudentMobile":strMobileNumber]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.ReSendOTPApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API.ReSendOTPApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let jsonArray = json["data"].stringValue//[0].dictionaryObject!
                    //                    UserDefaults.standard.set(jsonArray, forKey: "logindata")
                    //                    UserDefaults.standard.set("1", forKey: "isLogin")
                    self.txtOne.text = ""
                    self.txtOne.becomeFirstResponder()
                    strCode = "\(jsonArray)" // OTP
                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .center)

                    //                    UserDefaults.standard.set(jsonArray, forKey: "logindata")
                    //                    UserDefaults.standard.set("1", forKey: "isLogin")
                    //
                    //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuccessVC") as? SuccessVC
                    //                    self.navigationController?.pushViewController(vc!, animated: true)
                    //
                    //                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    
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


}
// MARK: - KWVerificationCodeViewDelegate
//extension OTPVC: KWVerificationCodeViewDelegate {
//    func didChangeVerificationCode() {
////        btnVerifyCode.isEnabled = verificationCodeView.hasValidCode()
//        //Bhargav Hide
////print("\(verificationCodeView.text ?? "")")
//        if validated() == true
//        {
//            view.endEditing(true)
//        }
//    }
//}
extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
extension OTPVC: PinCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        let value = textField.text ?? ""
        //Bhargav Hide
        ////print("value changed: \(value)")
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        return true
    }
}

