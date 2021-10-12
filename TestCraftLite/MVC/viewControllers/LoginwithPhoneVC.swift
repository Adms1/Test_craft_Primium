//
//  LoginwithPhoneVC.swift
//  TestCraft
//
//  Created by ADMS on 30/04/20.
//  Copyright © 2020 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON

class LoginwithPhoneVC: UIViewController, UITextFieldDelegate, ActivityIndicatorPresenter {

    @IBOutlet var txtPhoneNumber:TweeAttributedTextField!
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet var btnTerms:UIButton!
    @IBOutlet var btnCheckedTerms:UIButton!
    @IBOutlet weak var lblTerms: UILabel!
    let text = "I agree to all Terms & Conditions. An SMS may be sent to authenticate your account, and message and data rates may apply."



    @IBOutlet var txtTitle:UILabel!
    var isSelectExam = ""
//    var strTermsSelected = ""

    override func viewDidLoad() {
        super.viewDidLoad()

//        txtTitle.text = "Continue with Phone"
        // Do any additional setup after loading the view.
        self.txtPhoneNumber.delegate = self
//        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3900", comment: "Forgot Password - Mobile Number", isFirstTime: "0")
        btnForgotPassword.setTitle("Proceed", for: .normal)
        btnForgotPassword.layer.cornerRadius = btnForgotPassword.layer.frame.height / 2.0
        btnForgotPassword.layer.masksToBounds = true
//        btnForgotPassword.addShadowWithRadius(0,btnForgotPassword.frame.width/9,1,color: GetColor.signInText)
        //        btnForgotPassword.setTitleColor(GetColor.signInText, for: .normal)
        btnForgotPassword.setTitleColor(UIColor.white, for: .normal)
        btnForgotPassword.backgroundColor = GetColor.signInText
        self.addDoneButtonOnKeyboard(txt: txtPhoneNumber)
        //        txtPhoneNumber.text = "9015708106"
        // Do any additional setup after loading the view.

//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//            self.txtPhoneNumber.becomeFirstResponder()
//        }

        btnCheckedTerms.setBackgroundImage(UIImage(named: "select_box"), for: .normal)
        btnCheckedTerms.isSelected = false;
        btnCheckedTerms.isHidden = true
        btnTerms.isHidden = true
//        strTermsSelected = "0"


        lblTerms.text = text
        self.lblTerms.textColor = GetColor.darkGray
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions.")
//        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
//        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: "Roboto-Regular", size: 15)!, range: range1)
                underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: GetColor.signInText, range: range1)
        lblTerms.attributedText = underlineAttriString
        lblTerms.isUserInteractionEnabled = true
        lblTerms.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
       // comment for now
       //let privacyRange = (text as NSString).range(of: "Privacy Policy")

       if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: termsRange) {
           print("Tapped terms")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        vc?.strTitle = "Terms & Conditions"
        vc?.strLoadUrl = "\(API.hostName1)\(API.TermsCondition)"
        self.navigationController?.pushViewController(vc!, animated: true)


       }
//       else if gesture.didTapAttributedTextInLabel(label: lblTerms, inRange: privacyRange) {
//           print("Tapped privacy")
//       }
       else {
           print("Tapped none")
       }
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
        //        self.scrlView.contentInset = contentInset
        view.endEditing(true)
        if validated() == true
        {
//            apiForgotPassword()
        self.apiSignUp(strEmail: "", strMobileNo: txtPhoneNumber.text ?? "")

        }
    }

    @IBAction func Submit_Clicked(_ sender: UIButton)
    {
//        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3901", comment: "Reset Password Button", isFirstTime: "0")

        view.endEditing(true)
        if validated() == true
        {
            self.apiSignUp(strEmail: "", strMobileNo: txtPhoneNumber.text ?? "")
        }
    }

    @IBAction func btn_TermsClicked(sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        vc?.strTitle = "Terms & Conditions"
        vc?.strLoadUrl = "\(API.hostName1)\(API.TermsCondition)"
        self.navigationController?.pushViewController(vc!, animated: true)

    }
     @IBAction func btn_box(sender: UIButton) {
//        if (btnCheckedTerms.isSelected == true)
//        {
//            btnCheckedTerms.setBackgroundImage(UIImage(named: "select_box"), for: .normal)
//            btnCheckedTerms.isSelected = false;
//            strTermsSelected = "0"
//        }
//        else
//        {
//            btnCheckedTerms.setBackgroundImage(UIImage(named: "selected_box"), for: .normal)
//            btnCheckedTerms.isSelected = true;
//            strTermsSelected = "1"
//        }
    }

    @IBAction func Back_Clicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

        func validated() -> Bool {
            var valid: Bool = true
            if txtPhoneNumber.text == ""{
                txtPhoneNumber.showInfo("Please enter Mobile Number.")
                valid = false
            }
            else if (txtPhoneNumber.text!.count) != 10
            {
                txtPhoneNumber.showInfo("Please enter 10 digit Mobile Number.")
                valid = false
            }
    //        else if isEmailValid(txtEmail.text!) == false{
    //            txtEmail.showInfo("Please enter Valid Email.")
    //            valid = false
    //        }
            else
            {
                txtPhoneNumber.hideInfo()
            }
//            if strTermsSelected == "0"
//            {
//                self.view.makeToast("Select Terms & Conditions", duration: 3.0, position: .bottom)
//                valid = false
//            }
//
            return valid
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

}


extension LoginwithPhoneVC {

//    func CheckMobileNum()
//    {
//        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
//        {
//            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//            let strStudentMobile = "\(result.value(forKey: "StudentMobile") ?? "")"
//
//            if strStudentMobile == ""
//            {
//                openMobilePupup()
//            }
//        }
//    }

//    func openMobilePupup(){
//        let alert = UIAlertController(title: "Enter your mobile number.", message: "", preferredStyle: UIAlertController.Style.alert)
//        //        alert.view.backgroundColor = GetColor.whiteColor
//        //        alert.addTextField(configurationHandler: configurationTextField)
//        alert.addTextField { (textField) in
//            textField.placeholder = "Mobile Number"
//            textField.keyboardType = .phonePad
//            textField.tag = 1001
//            textField.delegate = self
//            textField.height = 50
//            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
//        }
//
//        action = UIAlertAction(title: "Verify", style: .default) { (_) in
//            //Bhargav Hide
//            ////print("User click Ok button")
//            //            return false
//            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//            //                              let strStudentMobile =
//
//            self.apiSignUp(strEmail: "\(result.value(forKey: "StudentEmailAddress") ?? "")", strMobileNo: self.strStudentMobile)
//
//        }
//        let closeAction = UIAlertAction(title: "Skip", style: .default) { (_) in
//            //Bhargav Hide
//            ////print("User click Ok button")
//        }
//
//        action.isEnabled = false
//        //        alert.addAction(closeAction)
//        alert.addAction(action)
//
//        self.present(alert, animated: true, completion: {
//            //Bhargav Hide
//            ////print("completion block")
//        })
//    }

//    @objc private func textFieldDidChange(_ field: UITextField) {
//        //Bhargav Hide
//        ////print(field.text,field.text?.count)
////        strStudentMobile = field.text ?? ""
////        if field.text!.count == 10
////        {
////            action.isEnabled = true
////        }
////        else
////        {
////            action.isEnabled = false
////        }
//
//        //        action.isEnabled = field.text?.count ?? 10 > 10
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var result = true
//
//        if textField.tag == 1001 {
//            if (string).count > 0 {
//                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789.-").inverted
//                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
//                if textField.text!.count > 9
//                {
//                    result = false
////                    action.isEnabled = true
//                }
//                else
//                {
//                    result = replacementStringIsLegal
////                    action.isEnabled = false
//                }
//            }
//        }
//
//        return result
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true

        if txtPhoneNumber == textField {
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
        }

        return result
    }

    func apiSignUp(strEmail:String,strMobileNo:String)
    {
        strCode = ""
        showActivityIndicator()
        let params = [
            //                "StudentEmailAddress":"\(strEmail)",
            "Mobile":"\(strMobileNo)","AccountTypeID":"10"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.SP_Check_Student_Duplicate_MobileApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.SP_Check_Student_Duplicate_MobileApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let jsonArray = json["data"][0].dictionaryObject
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPVC") as? OTPVC
                    strMobileNumber = self.txtPhoneNumber.text ?? ""
                    strCode = "\(json["data"][0]["OTP"].stringValue )"
                    let strIsReg = "\(json["data"][0]["StudentID"].stringValue)"
                   // self.isSelectExam = "\(json["data"][0]["AccountTypeID"].stringValue)"
                   // print("mmp isselec",self.isSelectExam)
                    if self.isSelectExam == "1" || self.isSelectExam == "2" || self.isSelectExam == "20" 
                    {
                        if UserDefaults.standard.object(forKey: "isLogin") != nil{
                            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                            vc?.txtName = "\(result.value(forKey: "StudentFirstName") ?? "")"
                            vc?.txtLastName = "\(result.value(forKey: "StudentLastName") ?? "")"
                            vc?.txtEmail = "\(result.value(forKey: "StudentEmailAddress") ?? "")"
                            vc?.txtPassword = "\(result.value(forKey: "StudentPassword") ?? "")"
                            vc?.txtAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"//
                        }
                    }
                    else
                    {
                        print("strIsReg:",strIsReg)

                        if strIsReg == "0"
                        {
                            //  apiSignUp()
                            //  self.apiSignUp(St_ID: "0", St_FirstName: "Guest" , St_LastName: "User", St_Email: "", St_Password: "", St_Mobile: "", St_AccountTypeID: "5", St_apple_user_id: "")
                            vc?.txtName = "" //"Guest" "User"
                            vc?.txtLastName = "" //"Guest" "User"
                            vc?.txtAccountTypeID = "10"
                            vc?.isRegistered = "0"
                        }
                        else{
                            vc?.DicReg = jsonArray! as [String : AnyObject]
                            if json["data"][0]["Preference"].count > 0
                            {
                                let jsonArrayPrefrence = json["data"][0]["Preference"][0].dictionaryObject!
                                self.pushPackage(Dic:jsonArrayPrefrence)
                                vc?.isRegistered = "2"
                            }
                            else
                            {
                                vc?.isRegistered = "1"
//
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
//                                //                    SJSwiftSideMenuController.pushViewController(vc!, animated: true)
//                                self.navigationController?.pushViewController(vc!, animated: true)
                            }
//                            vc?.isRegistered = "1"
                        }
                    }
                    vc?.txtMobile = self.txtPhoneNumber.text ?? ""//self.strStudentMobile/
                    vc?.isSelectExam = self.isSelectExam

                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                else
                {
                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
           print(error)
                //                    self.doSomething()
            }
        }
    }
        func pushPackage(Dic: [String:Any])//(CategoryID: String, CategoryID1: String, CategoryID2: String, CategoryID3: String)
        {
            let dictPrice:[String:Any] = ["minPrice":"0", "maxPrice":"5000"]
            UserDefaults.standard.set(dictPrice, forKey: "filter_price")

            strCategoryID = "\(Dic["CourseTypeID"] ?? "")"//"1"// CategoryID //arrData0.joined(separator:",")//Board
            if strCategoryID == "1" //Exam
            {
                strCategoryID1 = "\(Dic["BoardID"] ?? "")"//"1"// CategoryID1 //arrData0.joined(separator:",")//Board
                strCategoryID2 = "\(Dic["StandardID"] ?? "")"//"9"// CategoryID2 //arrData1.joined(separator:",")//Standard
                strCategoryID3 = "\(Dic["SubjectID"] ?? "")"// CategoryID3  //arrData2.joined(separator:",")//Subject
            }
            else
            {
                strCategoryID1 = "\(Dic["BoardID"] ?? "")" //Exam
                strCategoryID2 = "\(Dic["StandardID"] ?? "")"//"9"
                strCategoryID3 = "\(Dic["SubjectID"] ?? "")" // CategoryID3 //arrData2.joined(separator:",")//Subject
            }

            strTutorsId = ""
            strTutorsTitle = ""
            let dict:[String:Any] = ["CategoryID":strCategoryID, "CategoryID1":strCategoryID1, "CategoryID2":strCategoryID2, "CategoryID3":strCategoryID3, "CategoryTitle":strCategoryTitle, "CategoryTitle1":strCategoryTitle1, "CategoryTitle2":strCategoryTitle2, "CategoryTitle3":strCategoryTitle3, "TutorID":strTutorsId,"TutorTitle":strTutorsTitle , "arrPath":arrPath] // arrDataTitle0
            //Bhargav Hide
    ////print("exam_preferences____________________________________: \n",dict)
            UserDefaults.standard.set(dict, forKey: "exam_preferences")
            UserDefaults.standard.set("", forKey: "Deeplink")
    //        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
    //        popupVC.selectedIndex = 1
    //        selectedPackages = 1
    //        add(asChildViewController: popupVC, self)
        }

}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
//{
//    "Status" : "true",
//    "data" : "124362",
//    “isRegister” : “1”,
//    “data” :  {
//        “otp” : “”
//        “isRegister” : “1”,
//        “Regdata” : [
//        {
//            "StatusID" : 1,
//            "OTP" : "",
//            "StudentID" : 169,
//            "AccountTypeID" : 2,
//            "StudentMobile" : "",
//            "Photo" : "",
//            "StudentFirstName" : "ADMS",
//            "StudentEmailAddress" : "admsbuild@gmail.com",
//            "Preference" : [
//
//            ],
//            "StudentPassword" : "",
//            "StudentLastName" : "Build"
//        }
//        ]
//    }
//    "Msg" : "Mobile number is already exists..."
//}

//{
//    Status: "true",
//    data: [
//    {
//    StudentID: 116,
//    StudentFirstName: "bhargav",
//    StudentLastName: "chauhan",
//    StudentEmailAddress: "bhargav@gmail.com",
//    StudentPassword: "123456",
//    StudentMobile: "9429903834",
//    StatusID: 1,
//    AccountTypeID: 1,
//    OTP: "",
//    Photo: "",
//    Preference: [
//    {
//    CourseTypeID: "1",
//    BoardID: "1",
//    StandardID: "10",
//    SubjectID: "4,3",
//    CourseID: "0"
//    }
//    ]
//    }
//    ],
//    Msg: "Mobile number is already exists..."
//}


