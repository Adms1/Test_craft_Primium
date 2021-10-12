//
//  ContactUsVC.swift
//  TestCraft
//
//  Created by ADMS on 30/12/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON

class ContactUsVC: UIViewController , UITextFieldDelegate, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var strProfileUpdate = "0"

    @IBOutlet var txtName:TweeAttributedTextField!
    @IBOutlet var txtLastName:TweeAttributedTextField!
    @IBOutlet var txtEmail:TweeAttributedTextField!
    @IBOutlet var txtMobile:TweeAttributedTextField!
    @IBOutlet var txtComment:TweeAttributedTextField!
    @IBOutlet var scrlView: UIScrollView!
    @IBOutlet var btnSendEnquiry:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set the textFieldDelegates
        self.txtName.delegate = self
        self.txtLastName.delegate = self
        self.txtEmail.delegate = self
        self.txtMobile.delegate = self
        self.txtComment.delegate = self

      //  api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "300", comment: "Registration", isFirstTime: "0")

        self.addDoneButtonOnKeyboard(txt: txtComment)
//        txtComment
        btnSendEnquiry.addShadowWithRadius(0,btnSendEnquiry.frame.width/9,1,color: GetColor.signInText)
        btnSendEnquiry.setTitleColor(UIColor.white, for: .normal)
        btnSendEnquiry.backgroundColor = GetColor.signInText

        // Keyboard Notifications
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
             NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
                if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
                {
                    let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                    txtName.placeholderColor = GetColor.themeBlueColor
                    txtLastName.placeholderColor = GetColor.themeBlueColor
//                    txtEmail.placeholderColor = GetColor.themeBlueColor
//                    txtMobile.placeholderColor = GetColor.themeBlueColor
//        //            txtConfirmPassword.placeholderColor = GetColor.themeBlueColor
////                    txtMobile.placeholderColor = GetColor.themeBlueColor

                    let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
//                    strStatusID = "\(result.value(forKey: "StatusID") ?? "")"
//                    strStudentID = "\(result.value(forKey: "StudentID") ?? "")"
                    self.txtName.text = "\(result.value(forKey: "StudentFirstName") ?? "")"
                    self.txtLastName.text = "\(result.value(forKey: "StudentLastName") ?? "")"
        //            self.txtPassword.text = "\(result.value(forKey: "StudentPassword") ?? "")"
        //            self.txtConfirmPassword.text = "\(result.value(forKey: "StudentPassword") ?? "")"
                    self.txtMobile.text = "\(result.value(forKey: "StudentMobile") ?? "")"
                    if self.txtMobile.text != ""
                    {
                        txtMobile.placeholderColor = GetColor.themeBlueColor
                    }
                    if strAccountTypeID == "4"
                    {
                        self.txtEmail.text = ""
                    }
                    else
                    {
                        self.txtEmail.text = "\(result.value(forKey: "StudentEmailAddress") ?? "")"
                        txtEmail.placeholderColor = GetColor.themeBlueColor

                    }
//                    if strAccountTypeID == "1"
//                    {
//
//                    }
//                    else
//                    {
//        //                txtPassword.isHidden = true
//        //                txtConfirmPassword.isHidden = true
//                        txtEmail.isEnabled = false
//                        PhoneNumberConstraint.constant = 33
//                        if strAccountTypeID == "4"
//                        {
//                            self.txtEmail.isHidden = true
//                            self.txtMobile.isHidden = true
//                        }
//                    }
                }


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrlView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 60
        scrlView.contentInset = contentInset

    }
    @objc func keyboardWillHide(notification: NSNotification)
    {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrlView.contentInset = contentInset

    }
    func addDoneButtonOnKeyboard(txt:UITextField){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        txt.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrlView.contentInset = contentInset
        view.endEditing(true)
        if validated() == true
        {
            apiSendEnquiry()
            print("Send Successfully...")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case self.txtName:
            self.txtLastName.becomeFirstResponder()
            break
        case self.txtLastName:
            self.txtEmail.becomeFirstResponder()
            break
        case self.txtEmail:
            self.txtMobile.becomeFirstResponder()
            break
        case self.txtMobile:
            self.txtComment.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard range.location == 0 else {
            return true
        }
        if txtMobile == textField {
            var result = true
            if (string).count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789.-").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                if textField.text!.count > 9
                {
                    result = false
                }
                else
                {
                    result = replacementStringIsLegal
                }
            }
            return result

        }
        else{
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0}
    }


    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func SendEnquiry_Clicked(_ sender: UIButton) {
        self.view.endEditing(true)

        if validated() == true
        {
            apiSendEnquiry()
        }
    }
    @IBAction func Back_Clicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func validated() -> Bool {
        var valid: Bool = true
        if txtName.text == ""{
            //            self.view.makeToast("Please enter First Name.", duration: 3.0, position: .bottom)
            txtName.showInfo("Please enter first name.")

            valid = false
        }
        else
        {
            txtName.hideInfo()
        }
        if txtLastName.text == ""{
            //            self.view.makeToast("Please enter Last Name.", duration: 3.0, position: .bottom)
            txtLastName.showInfo("Please enter last name.")
            valid = false
        }
        else
        {
            txtLastName.hideInfo()
        }
        if txtEmail.text == ""{
            //            self.view.makeToast("Please enter Email.", duration: 3.0, position: .bottom)
            txtEmail.showInfo("Please enter email.")
            valid = false
        }
        else if isEmailValid(txtEmail.text!) == false{
            //            self.view.makeToast("Please enter Valid Email.", duration: 3.0, position: .bottom)
            txtEmail.showInfo("Please enter valid email.")
            valid = false
        }
        else
        {
            txtEmail.hideInfo()
        }
        if txtMobile.text == ""{
            //            self.view.makeToast("Please enter Mobile Number.", duration: 3.0, position: .bottom)
            //            txtMobile.errorMessage = "Please enter Mobile Number."
            txtMobile.showInfo("Please enter your Mobile Number.")
            valid = false
        }
        else if (txtMobile.text!.count) != 10 //&& (txtMobile.text!.count) < 11
        {
            //            self.view.makeToast("Please enter 10 digit Mobile Number.", duration: 3.0, position: .bottom)
            //            txtMobile.errorMessage = "Please enter 10 digit Mobile Number"
            txtMobile.showInfo("Please enter 10 digit mobile number.")
            valid = false
        }
        else
        {
            txtMobile.hideInfo()
        }
        if txtComment.text == ""{
            //            self.view.makeToast("Please enter Mobile Number.", duration: 3.0, position: .bottom)
            //            txtMobile.errorMessage = "Please enter Mobile Number."
            txtComment.showInfo("Please enter your comment.")
            valid = false
        }
        else
        {
            txtComment.hideInfo()
        }

        return valid
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    func apiSendEnquiry()
    {
        //     api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "301", comment: "Proceed", isFirstTime: "0")
        showActivityIndicator()
        let params = ["FirstName":"\(txtName.text ?? "")",
            "LastName":"\(txtLastName.text ?? "")",
            "Email":"\(txtEmail.text ?? "")",
            "Mobile":"\(txtMobile.text ?? "")",
            "Comment":"\(txtComment.text ?? "")"]//,
//            "StatusID":"2",
//            "AccountTypeID":"1"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.ContactUs,params)
                       if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                           return
                       }
        
        Alamofire.request(API.ContactUs, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
//                    let jsonArray = json["data"][0].dictionaryObject!
//                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    let alert = UIAlertController(title: "Your information send successfuly", message: "", preferredStyle: .alert)
//                    alert.setTitleImage(UIImage(named: "risk_blue"))
                    // Add actions
                    //                let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    //        action.actionImage = UIImage(named: "close")
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                        //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                        //                    SJSwiftSideMenuController.pushViewController(vc!, animated: false)
                        self.navigationController?.popViewController(animated: false)


                    }))
                    self.present(alert, animated: true, completion: nil)

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
