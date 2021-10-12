//
//  ProfileEditVC.swift
//  TestCraft
//
//  Created by ADMS on 09/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
import SDWebImage

class ProfileEditVC: UIViewController, UITextFieldDelegate, ActivityIndicatorPresenter {

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var strAccountTypeID = ""
    var strStatusID = ""
    var strStudentID = ""
    //    var keyboardDelegate:ViewControllerDelegate?
    var isHiden = ""
    @IBOutlet var txtName:TweeAttributedTextField!
    @IBOutlet var txtLastName:TweeAttributedTextField!
    @IBOutlet var txtEmail:TweeAttributedTextField!
    //    @IBOutlet var txtPassword:TweeAttributedTextField!
    //    @IBOutlet var txtConfirmPassword:TweeAttributedTextField!
    @IBOutlet var txtMobile:TweeAttributedTextField!
    @IBOutlet weak var btnProfileUpdate: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet var BackWidthConstraint: NSLayoutConstraint!

    @IBOutlet var PhoneNumberConstraint: NSLayoutConstraint!
    @IBOutlet var scrlView: UIScrollView!
    @IBOutlet var imgProfile: UIImageView!

    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3400", comment: "Update Profile Screen", isFirstTime: "0")

        if isHiden == "1"
        {
            btnBack.isHidden = true
            BackWidthConstraint.constant = 15
            self.tabBarController?.tabBar.isHidden = true
        }
        else
        {
            btnBack.isHidden = false
            BackWidthConstraint.constant = 50
        }
        self.txtName.delegate = self
        self.txtLastName.delegate = self
        self.txtEmail.delegate = self
        //        self.txtPassword.delegate = self
        //        self.txtConfirmPassword.delegate = self
        self.txtMobile.delegate = self
        self.btnProfileUpdate.addShadowWithRadius(0,btnProfileUpdate.frame.width/9,1,color: GetColor.signInText)
        //        self.btnProfileUpdate.setTitleColor(GetColor.signInText, for: .normal)

        //        self.imgProfile.addShadowWithRadius(4,6,1,color: GetColor.themeBlueColor)
        let url = URL.init(string: "" + ("").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        imgProfile.clipsToBounds = true

        imgProfile.addShadowWithRadius(0,imgProfile.frame.width/2,0,color: UIColor.darkGray)
        imgProfile?.sd_setImage(with: url, placeholderImage: UIImage(named: "person_placeholder.jpg"), options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
            if error != nil {
                //Bhargav Hide
                ////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                //                self.imgProfile.setImageForName("", backgroundColor: nil, circular: true, textAttributes: nil, gradient: true)
                return
            }
            self.imgProfile.image = fetchedImage
        }

        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            txtName.placeholderColor = GetColor.themeBlueColor
            txtLastName.placeholderColor = GetColor.themeBlueColor
            txtEmail.placeholderColor = GetColor.themeBlueColor
            //            txtPassword.placeholderColor = GetColor.themeBlueColor
            //            txtConfirmPassword.placeholderColor = GetColor.themeBlueColor
            txtMobile.placeholderColor = GetColor.themeBlueColor

            strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
            strStatusID = "\(result.value(forKey: "StatusID") ?? "")"
            strStudentID = "\(result.value(forKey: "StudentID") ?? "")"
            self.txtName.text = "\(result.value(forKey: "StudentFirstName") ?? "")"
            self.txtLastName.text = "\(result.value(forKey: "StudentLastName") ?? "")"
            self.txtEmail.text = "\(result.value(forKey: "StudentEmailAddress") ?? "")"
            //            self.txtPassword.text = "\(result.value(forKey: "StudentPassword") ?? "")"
            //            self.txtConfirmPassword.text = "\(result.value(forKey: "StudentPassword") ?? "")"
            self.txtMobile.text = "\(result.value(forKey: "StudentMobile") ?? "")"
            if strAccountTypeID == "1"
            {
                
            }
            else
            {
                //                txtPassword.isHidden = true
                //                txtConfirmPassword.isHidden = true
                txtEmail.isEnabled = false
                PhoneNumberConstraint.constant = 33
                if strAccountTypeID == "2"
                {
                    self.txtMobile.isUserInteractionEnabled = true
                    self.txtMobile.isHidden = false

                }
                if strAccountTypeID == "3"
                {
                    self.txtMobile.isUserInteractionEnabled = true
                    self.txtMobile.isHidden = false

                }
                if strAccountTypeID == "4"
                {
                    txtEmail.isEnabled = true
                    txtEmail.isUserInteractionEnabled = true
                    //                    self.txtEmail.isHidden = true
                    self.txtMobile.isHidden = true
                }
                if strAccountTypeID == "5"
                {
                    txtEmail.isEnabled = true
                    txtEmail.isUserInteractionEnabled = true
                    self.txtEmail.textColor = GetColor.blackColor
                    self.addDoneButtonOnKeyboard(txt: txtEmail)
                    //                    self.txtEmail.isHidden = true
//                    self.txtMobile.isHidden = true
                }

            }
        }
        self.addDoneButtonOnKeyboard(txt: txtMobile)
        self.addDoneButtonOnKeyboard(txt: txtLastName)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case self.txtName:
            self.txtLastName.becomeFirstResponder()
            break
        case self.txtLastName:
            //            if strAccountTypeID == "1"
            //            {
            //                self.txtPassword.becomeFirstResponder()
            //            }
            //            else
            //            {
            if strAccountTypeID == "5"
            {
                self.txtEmail.becomeFirstResponder()
            }
            else
            {
                view.endEditing(true)
            }
            //            }
            break
            //        case self.txtEmail:
            //            self.txtPassword.becomeFirstResponder()
            //            break
            //        case self.txtPassword:
            //            self.txtConfirmPassword.becomeFirstResponder()
            //            break
            //        case self.txtConfirmPassword:
            //            self.txtMobile.becomeFirstResponder()
        //            break
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if txtMobile == textField {
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
        else
        {
            guard range.location == 0 else {
                return true
            }

            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        }
        
        return result
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // left menu toggle
    @IBAction func toggleLeftSideMenutapped(_ sender: AnyObject) {
        //        SJSwiftSideMenuController.toggleLeftSideMenu()
        navigationController?.popViewController(animated: true)

    }
    @IBAction func logoutClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
            UserDefaults.standard.set("0", forKey: "isLogin")
            vc?.isSelectExam = "1000"
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"isLogin")
            prefs.removeObject(forKey:"logindata")
            prefs.removeObject(forKey:"exam_preferences")
            prefs.removeObject(forKey:"filter_price")
            self.navigationController?.pushViewController(vc!, animated: false)
        }))
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }

    @IBAction func Signup_Clicked(_ sender: UIButton) {
        self.view.endEditing(true)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3401", comment: "Update Button", isFirstTime: "0")
        if validated() == true
        {
            if strAccountTypeID == "4"
            {
                called_Check_Email_iOS_Befor_Submit_API()
            }
            else
            {
//                apiSignUp()
                apiValidationCheckEmailPhone()
            }
        }
    }
    @IBAction func Back_Clicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func validate(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.whitespaces) == nil
    }

    func validated() -> Bool {
        var valid: Bool = true

        if txtName.text == ""
        {
            txtName.showInfo("Please enter first name.")
            valid = false
        }
        else
        {
            txtName.hideInfo()
        }
        if txtLastName.text == ""
        {
            txtLastName.showInfo("Please enter last name.")
            valid = false
        }
        else
        {
            txtLastName.hideInfo()
        }
        //        if strAccountTypeID == "4"
        //        {
        //            txtEmail.hideInfo()
        //            print("no check email")
        //        }
        //        else
        //        {
        if txtEmail.text == ""{
            txtEmail.showInfo("Please enter email.")
            valid = false
        }
        else if isEmailValid(txtEmail.text!) == false{
            txtEmail.showInfo("Please enter valid email.")
            valid = false
        }
        else
        {
            txtEmail.hideInfo()
        }
        //        }
        //        if strAccountTypeID == "1"
        //        {
        //
        //            if txtPassword.text == ""{
        //                txtPassword.showInfo("Please enter password.")
        //                valid = false
        //            }
        //            else
        //            {
        //                txtPassword.hideInfo()
        //            }
        //            if txtConfirmPassword.text == ""{
        //                txtConfirmPassword.showInfo("Please enter Confirm Password.")
        //                valid = false
        //            }
        //            else if txtPassword.text != txtConfirmPassword.text{
        //                txtConfirmPassword.showInfo("Password & Confirm Password did not matched.")
        //                valid = false
        //            }
        //            else
        //            {
        //                txtConfirmPassword.hideInfo()
        //            }
        //        }
        //        else
        //        {
        //        }
        if strAccountTypeID == "2"
        {
                if txtMobile.text == ""{
//                    txtMobile.showInfo("Please enter Mobile Number.")
                    valid = true
                }
                else if (txtMobile.text!.count) != 10
                {
                    txtMobile.showInfo("Please enter 10 digit Mobile Number.")
                    valid = false
                }
                else
                {
                    txtMobile.hideInfo()
                }
        }
        return valid
    }
    func apiValidationCheckEmailPhone()
    {
        showActivityIndicator()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params = ["StudentID":strStudentID,
            "Email":"\(txtEmail.text ?? "")",
            "Mobile":"\(txtMobile.text ?? "")",
            "TypeID":strAccountTypeID]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Check_Email_Mobile_By_Type_NewApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Check_Email_Mobile_By_Type_NewApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
//                    let jsonArray = json["data"][0].dictionaryObject!
                    self.apiSignUp()
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
        showActivityIndicator()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        
        let params = ["StudentID":strStudentID,
                      "StudentFirstName":"\(txtName.text ?? "")",
            "StudentLastName":"\(txtLastName.text ?? "")",
            "StudentEmailAddress":"\(txtEmail.text ?? "")",
            "StudentPassword":"\(result.value(forKey: "StudentPassword") ?? "")",
            "StudentMobile":"\(txtMobile.text ?? "")",
            "StatusID":"1",
            "AccountTypeID":strAccountTypeID,
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
                    self.navigationController?.popViewController(animated: true)
                   // self.tabBarController?.selectedIndex = 1 // does not animate


                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

//                    let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//            //                    popupVC.selectedIndex = 0
//            //                    popupVC.strtemo_Selected = "0"
//            //                    selectedPackages = 0
//                    popupVC.selectedIndex = 1
                   // add(asChildViewController: popupVC, self)


//                    let popview = BaseTabBarViewController(coder: <#NSCoder#>)
//                    popview.selele


//                    let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
////                    popupVC.selectedIndex = 0
////                    popupVC.strtemo_Selected = "0"
////                    selectedPackages = 0
//                    popupVC.selectedIndex = 1
////                    popupVC.strtemo_Selected = "1"
////                    selectedPackages = 1
//                    let frontNavigationController = UINavigationController(rootViewController: popupVC)
//                    self.appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
//                    self.appDelegate?.window?.rootViewController = frontNavigationController
//                    self.appDelegate?.window?.makeKeyAndVisible()



//                    let alert = UIAlertController(title: "", message: "\(json["Msg"])", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                     //   self.navigationController?.popViewController(animated: true)
//
//                        switch action.style{
//                        case .default:
//                            //Bhargav Hide
//                            print("default")
//
//                        case .cancel:
//                            //Bhargav Hide
//                            print("cancel")
//
//                        case .destructive:
//                            //Bhargav Hide
//                            print("destructive")
//
//
//                        }}))
//                    self.present(alert, animated: true, completion: nil)
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
    func called_Check_Email_iOS_Befor_Submit_API()
    {
        //        if let _ = AccessToken.current
        //        {
        showActivityIndicator()
        //                self.logout()

        var params = ["":""]//["Email":"\(St_Email)","apple_user_id":St_apple_user_id]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        let API_temp = API.SP_Check_Student_Duplicate_EmailApi
        //            if St_AccountTypeID == "4"
        //            {
        //                API_temp = API.SP_Check_Student_Duplicate_Email_iOSApi
        //                params = ["apple_user_id":St_apple_user_id]
        //            }else
        //            {
        params = ["Email":"\(txtEmail.text ?? "")","UDID":"\(UserDefaults.standard.object(forKey: "UUID") ?? "")"]
        //            }

        print("API, Params: \n",API_temp,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API_temp, method: .post, parameters: params, headers: headers).validate().responseJSON { response in

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    self.hideActivityIndicator()
                    //                            self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    self.view?.makeToast("Email already exists", duration: 3.0, position: .bottom)
                }
                else
                {
                    //                            self.apiSignUp(St_ID: "0", St_FirstName: St_FirstName , St_LastName: St_LastName , St_Email: St_Email, St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)
                    //                            self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    self.apiSignUp()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                self.hideActivityIndicator()
            }
        }
    }
}
