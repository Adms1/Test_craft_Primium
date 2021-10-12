//
//  IntroVC.swift
//  TestCraft
//
//  Created by ADMS on 31/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import AuthenticationServices

let _AUTO_SCROLL_ENABLED : Bool = false

class IntroVC: UIViewController, ActivityIndicatorPresenter, GIDSignInDelegate, UITextFieldDelegate  {

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()
    var isSelectExam = ""

    @IBOutlet weak var signInButton: UIView!//GIDSignInButton!
    @IBOutlet weak var FacebookLoginButton: UIButton!//FBSDKLoginButton!
    @IBOutlet weak var GoogleLoginButton: UIButton!//FBSDKLoginButton!
    @IBOutlet weak var EmailLoginButton: UIButton!//FBSDKLoginButton!
    @IBOutlet var lblVersionTitle:UILabel!
    @IBOutlet weak var AppleLogInButton: UIView!//
    @IBOutlet weak var ApplemailLoginButton: UIButton!//ASAuthorizationAppleIDButton!//FBSDKLoginButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var PhoneLoginButton: UIButton!//FBSDKLoginButton!

    @IBOutlet var AppleLoginHeight: NSLayoutConstraint!
    //    var btnGoogleSignIn : UIButton!
    var strIsFirstName = "0"
    var strIsLastName = "0"
    var strIsEmailId = "0"

    var imagesArray = [String]()
//    @IBOutlet weak var slider : CPImageSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.lockOrientation(.portrait)

        lblVersionTitle.text = API.strVersion
//        SJSwiftSideMenuController.hideLeftMenu()
//        SJSwiftSideMenuController.hideRightMenu()
        self.navigationController?.isNavigationBarHidden = true

        // Do any additional setup after loading the view.
//        imagesArray = ["copetitiveExam.png"]//,"Screen_2_1.png","IconApp.png"]
//        slider.images = imagesArray
//        slider.delegate = self
//        slider.autoSrcollEnabled = false
//        slider.enableArrowIndicator = false
//        slider.enablePageIndicator = false
//        slider.enableSwipe = false
//        slider.allowCircular = false
        if #available(iOS 13.0, *) {
            AppleLoginHeight.constant = 50//0.0
            self.setupLoginProviderView()
        } else {
            // Fallback on earlier versions
            AppleLoginHeight.constant = 0.0
        }
//        self.openPopup()
//        let authorizationButton = ASAuthorizationAppleIDButton()
//        authorizationButton.addTarget(self, action: #selector(handleLogInWithAppleIDButtonPress), for: .touchUpInside)
//        loginProviderStackView.addArrangedSubview(authorizationButton)

        if ((UserDefaults.standard.value(forKey: "TrackTokenID")) != nil)
        {
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "200", comment: "Intro Screen", isFirstTime: "0")
        }
        else
        {
            api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
//            self.apiIzumlabs_Track_Create_GameID(strID: "")
        }


        //        let zoom : CGFloat = 0.8
        //        autoSwitch.transform = CGAffineTransform(scaleX: zoom, y: zoom)
        //        arrowSwitch.transform = CGAffineTransform(scaleX: zoom, y: zoom)
        //        indicatorSwitch.transform = CGAffineTransform(scaleX: zoom, y: zoom)
        //        sliderSwitch.transform = CGAffineTransform(scaleX: zoom, y: zoom)
        //        circularSwitch.transform = CGAffineTransform(scaleX: zoom, y: zoom)
        //
        //        autoSwitch.isOn = slider.autoSrcollEnabled
        //        arrowSwitch.isOn = slider.enableArrowIndicator
        //        indicatorSwitch.isOn = slider.enablePageIndicator
        //        sliderSwitch.isOn = slider.enableSwipe
        //        circularSwitch.isOn = slider.allowCircular

        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance()?.delegate = self as? GIDSignInDelegate//uiDelegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //        GIDSignIn.sharedInstance()?.uidelegate = self as? GIDSignInDelegate//uiDelegate = self

        // Automatically sign in the user.
        //         GIDSignIn.sharedInstance()?.restorePreviousSignIn()

        //        signInButton.style = .wide

        //         Uncomment to automatically sign in the user.
        //        GIDSignIn.sharedInstance().signInSilently()
        //        FacebookLoginButton = LoginButton(readPermissions: [ .publicProfile, .Email, .UserFriends ])
        //        FacebookLoginButton.readPermissions = ["email","public_profile"]
        // Obtain all constraints for the button:
        //        let layoutConstraintsArr = FacebookLoginButton!.constraints
        //        // Iterate over array and test constraints until we find the correct one:
        //        for lc in layoutConstraintsArr { // or attribute is NSLayoutAttributeHeight etc.
        //            if ( lc.constant == 28 ){
        //                // Then disable it...
        //                lc.isActive = false
        //                break
        //            }
        //        }

        //        let layoutConstraintsArr1 = signInButton.constraints
        //        // Iterate over array and test constraints until we find the correct one:
        //        for lc in layoutConstraintsArr1 { // or attribute is NSLayoutAttributeHeight etc.
        //            if ( lc.constant == 28 ){
        //                // Then disable it...
        //                lc.isActive = false
        //                break
        //            }
        //        }
        //        signInButton.subviews[0].center = view.center

        //        signInButton.addShadowWithRadius(0,20,0,color: GetColor.blueHeaderText)
        FacebookLoginButton!.addShadowWithRadius(0,25,0,color: GetColor.blueHeaderText)
        GoogleLoginButton.addShadowWithRadius(0,25,0,color: GetColor.blueHeaderText)
        EmailLoginButton.addShadowWithRadius(0,25,0,color: GetColor.blueHeaderText)
        PhoneLoginButton.addShadowWithRadius(0,25,0,color: GetColor.blueHeaderText)

        //        FacebookLoginButton.setImage(UIImage(named: "select_box.png"), for: .normal)



        //        MakeGoogleButton()
        
//        {
//        let St_FirstName = ""
//        let St_LastName = ""
//        let St_Email = ""
//            let alert = UIAlertController(title: "", message: "Please provide following information for the reference", preferredStyle: UIAlertController.Style.alert)
//            alert.addTextField { (textField) in
//                textField.placeholder = "First name"
//                textField.keyboardType = .default
//                textField.tag = 1001
//                textField.delegate = self
//                textField.height = 70
//                textField.text = St_FirstName
//                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
//            }
//            alert.addTextField { (textField) in
//                textField.placeholder = "Last name"
//                textField.keyboardType = .default
//                textField.tag = 1002
//                textField.delegate = self
//                textField.height = 70
//                textField.text = St_LastName
//                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
//            }
//
//            self.action = UIAlertAction(title: "Done", style: .default) { (_) in
//                //Bhargav Hide
//                ////print("User click Ok button")
//                //  "4"
//                let txtFirstname = alert.textFields![0].text //else { return }
//                let textSecondname = alert.textFields![1].text
//                let textEmail = St_Email//alert.textFields![2].text
//                print(txtFirstname ?? "",textSecondname ?? "",textEmail ?? "")
//
//            }
//            if St_FirstName != ""{self.strIsFirstName = "1"}else{self.strIsFirstName = "0"}
//            if St_LastName != ""{self.strIsLastName = "1"}else{self.strIsLastName = "0"}
//            print("St_FirstName, St_LastName",St_FirstName,St_LastName)
//            if St_FirstName == "" || St_LastName == "" { self.action.isEnabled = false }else{ self.action.isEnabled = true }
//            alert.addAction(self.action)
//            self.present(alert, animated: true, completion: {
//                //Bhargav Hide
//                ////print("completion block")
//            })



    }
    //    func MakeGoogleButton(){
    //        let btnSize : CGFloat = 100
    //        btnGoogleSignIn = UIButton(frame: signInButton.frame)
    //        btnGoogleSignIn.center = view.center
    ////        btnGoogleSignIn.setImage(UIImage(named: "google_logo.png"), forState: UIControlState.Normal)
    //        btnGoogleSignIn.addTarget(self, action: #selector(btnSignInPressed), for: UIControl.Event.touchUpInside)
    //
    ////        //Circular button
    ////        btnGoogleSignIn.layer.cornerRadius = btnSize/2
    ////        btnGoogleSignIn.layer.masksToBounds = true
    ////        btnGoogleSignIn.layer.borderColor = UIColor.blackColor().CGColor
    ////        btnGoogleSignIn.layer.borderWidth = 2
    //        signInButton.addSubview(btnGoogleSignIn)
    //
    //    }
    @IBAction func Back_Clicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func Back_Clicked1(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func openPopup()
    {
        let alert = UIAlertController(title: "", message: "Please provide following information for the reference", preferredStyle: UIAlertController.Style.alert)
        //        alert.view.backgroundColor = GetColor.whiteColor
        //        alert.addTextField(configurationHandler: configurationTextField)
        alert.addTextField { (textField) in
            textField.placeholder = "First name"
            textField.keyboardType = .default
            textField.tag = 1001
            textField.delegate = self
//            textField.height = 70
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Last name"
            textField.keyboardType = .default
            textField.tag = 1002
            textField.delegate = self
//            textField.height = 70
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
        }
//        alert.addTextField { (textField) in
//            textField.placeholder = "Email"
//            textField.keyboardType = .emailAddress
//            textField.tag = 1003
//            textField.delegate = self
//            textField.height = 70
//            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
//        }

        self.action = UIAlertAction(title: "Done", style: .default) { (_) in
            //Bhargav Hide
            ////print("User click Ok button")
            //            return false
            let txtFirstname = alert.textFields![0].text //else { return }
            let textSecondname = alert.textFields![1].text
            let textEmail = ""//alert.textFields![2].text
            print(txtFirstname ?? "",textSecondname ?? "",textEmail ?? "")
            //                                  self.apiSignUp(St_ID: "0", St_FirstName: txtFirstname ?? "" , St_LastName: textSecondname ?? "" , St_Email: St_Email, St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID)

        }
        //                        let closeAction = UIAlertAction(title: "Skip", style: .default) { (_) in
        //                        }

        self.action.isEnabled = false
        //        alert.addAction(closeAction)
        alert.addAction(self.action)

        self.present(alert, animated: true, completion: {
            //Bhargav Hide
            ////print("completion block")
        })
    }

    @objc func btnSignInPressed() {
        //        GIDSignIn.sharedInstance().signIn()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //            fetchUserProfile()
        self.tabBarController?.tabBar.isHidden = true
        if isSelectExam == "1000"
        { btnBack.isHidden = false; isSelectExam = "20" } else { btnBack.isHidden = true}
        
        strMyCoin = "0"
        if #available(iOS 13.0, *) {
//            performExistingAccountSetupFlows()
        } else {
            // Fallback on earlier versions
        }

    }

//    func sliderImageTapped(slider: CPImageSlider, index: Int) {
//        //Bhargav Hide
//        ////print("\(index)")
//    }


    // MARK: - Button Click
    @IBAction func Signin_Clicked(_ sender: UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "204", comment: "Sign In", isFirstTime: "0")
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func Email_Clicked(_ sender: UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "203", comment: "Continue with Mobile", isFirstTime: "0")
//
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
//        self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func Phone_Clicked(_ sender: UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "203", comment: "Continue with Mobile", isFirstTime: "0")

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginwithPhoneVC") as? LoginwithPhoneVC
        vc?.isSelectExam = self.isSelectExam
        self.navigationController?.pushViewController(vc!, animated: true)
    }


    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    // }
    //
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    //    return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
    // }
    //
    @IBAction func Facebook_Login_Clicked(_ sender: UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "201", comment: "Continue with Facebook", isFirstTime: "0")

        let fbLoginManager : LoginManager = LoginManager()



//        ["public_profile", "email"]

        fbLoginManager.logIn(permissions: ["public_profile", "email" , "user_posts"], from: self)
        {
            (result, error) -> Void in
            if (error == nil)
            {
                //Bhargav Hide
                ////print(result,error)
                let fbloginresult : LoginManagerLoginResult = result!
                if result!.isCancelled
                {
                    return
                }

                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    //                self.getFBUserData()
                    self.fetchUserProfile()

                }
            }
        }

    }

    func fetchPost(userId:String){

        let parameters1 = ["access_token":AccessToken.current!.tokenString]

        let fbRequest = GraphRequest(graphPath:"/me/feed", parameters: parameters1);
        fbRequest.start(completionHandler: { (connection, result, error) -> Void in

                        if error == nil {

                            print("Friends are : \(result)")

                        } else {

                            print("Error Getting Friends \(error)");

                        }
                    })

//        func getFBPost() {
//            GraphRequest(graphPath: "/me/feed", parameters: [:]).start(completionHandler: { (fbConnectionErr, result, error) in
//               // print(fbConnectionErr)
//                print(result)
//                //print(error)
//            })
//        }


//        let parameters1 = ["access_token":AccessToken.current!.tokenString]
//        let graphRequest : GraphRequest = GraphRequest(graphPath: "me/feed",
//                                                       parameters: parameters1)
//        //        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")
//
//        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
//
//            if ((error) != nil)
//            {
//                //Bhargav Hide
//                ////print("Error took place: \(error ?? "" as! Error)")
//            }
//            else
//            {
//                let json = result as! NSDictionary//JSON(result)
//
//                //Bhargav Hide
//                print("Print entire fetched result: \(result ?? 0)",json)
//
//
//                }
                //
                //                if let profilePictureObj = result.valueForKey("picture") as? NSDictionary
                //                {
                //                    let data = profilePictureObj.valueForKey("data") as! NSDictionary
                //                    let pictureUrlString  = data.valueForKey("url") as! String
                //                    let pictureUrl = NSURL(string: pictureUrlString)
                //
                //                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                //
                //                        let imageData = NSData(contentsOfURL: pictureUrl!)
                //
                //                        dispatch_async(dispatch_get_main_queue()) {
                //                            if let imageData = imageData
                //                            {
                //                                let userProfileImage = UIImage(data: imageData)
                //                                self.userProfileImage.image = userProfileImage
                //                                self.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFit
                //                            }
                //                        }
                //                    }
                //                }
      //  })
//        var Requset : GraphRequest
//
//        print("\(AccessToken.current)")
//
////        var acessToken = String(format:"%@", AccessToken.current?.tokenString) as String
////
////        print("\(acessToken)")
//
//        let parameters1 = ["access_token":AccessToken.current!.tokenString]
////        let parameters1 = ["fields": "tech@testcraft.in"]
//
//
//        Requset  = GraphRequest(graphPath:"me/posts", parameters:parameters1, httpMethod:HTTPMethod(rawValue: "GET"))
//
//        Requset.start(completionHandler: { (connection, result, error) -> Void in
//
////            MBProgressHUD.hideHUDForView(appDelegate.window, animated: true)
//
//            if ((error) != nil)
//            {
//                print("Error: \(error)")
//            }
//            else
//            {
//                print("fetched user: \(result)")
//
////                var dataDict: AnyObject = result!.objectForKey("data")!
//
//            }
//        })
    }

//    }







    @IBAction func Google_Login_Clicked(_ sender: UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "202", comment: "Continue with Gmail", isFirstTime: "0")
        GIDSignIn.sharedInstance().signIn()
        //     GIDSignIn.sharedInstance()?.presentingViewController = self
        //    // Automatically sign in the user.
        //    GIDSignIn.sharedInstance()?.restorePreviousSignIn()


    }

    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.

    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error?) {
        //        myActivityIndicator.stopAnimating()
        //Bhargav Hide
        ////print("gid sign in")
    }

    // Present a view that prompts the user to sign in with Google
    private func signIn(signIn: GIDSignIn!,
                        presentViewController viewController: UIViewController!) {
        //Bhargav Hide
        ////print("gid sign in 1")
        self.present(viewController, animated: true, completion: nil)

    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        //Bhargav Hide
        ////print("gid sign in 2")
        self.dismiss(animated: true, completion: nil)

    }



    func fetchUserProfile()
    {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id,name,email,first_name,last_name"])
        //        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: accessToken.tokenString, version: nil, HTTPMethod: "GET")

        graphRequest.start(completionHandler: { (connection, result, error) -> Void in

            if ((error) != nil)
            {
                //Bhargav Hide
                ////print("Error took place: \(error ?? "" as! Error)")
            }
            else
            {
                let json = result as! NSDictionary//JSON(result)

                //Bhargav Hide
                print("Print entire fetched result: \(result ?? 0)",json)

                let userId : NSString = json.value(forKey: "id") as! NSString

              //  self.fetchPost(userId: String(userId))
                //Bhargav Hide
                ////print("User ID is: \(userId)")

                var fullName = ""
                var givenName = ""
                var familyName = ""
                var email = ""

                if let userName = json.value(forKey: "name") as? String
                {
                    fullName = userName
                }
                if let userfirst_name = json.value(forKey: "first_name") as? String
                {
                    givenName = userfirst_name
                }
                if let userlast_name = json.value(forKey: "last_name") as? String
                {
                    familyName = userlast_name
                }
                if let useremail = json.value(forKey: "email") as? String
                {
                    email = useremail
                }
//                if let user_mobile_phone = json.value(forKey: "user_mobile_phone") as? String
//                {
////                    email = useremail
//                    print("user_mobile_phone: ",user_mobile_phone)
//                }
                print("\(fullName) \n\(givenName) \n\(familyName) \n\(email)");

                if email != ""
                {
                UserDefaults.standard.set("http://graph.facebook.com/\(userId)/picture?type=large", forKey: "ProfilePhoto")
                self.called_Check_Email_API(St_ID: "0", St_FirstName: givenName , St_LastName: familyName, St_Email: email, St_Password: "", St_Mobile: "", St_AccountTypeID: "8", St_apple_user_id: "")
                }else
               {
                self.view.makeToast("Email Not Found.!! Please add email in your FB Account", duration: 5.0, position: .center)

                }
                //
                //                if let profilePictureObj = result.valueForKey("picture") as? NSDictionary
                //                {
                //                    let data = profilePictureObj.valueForKey("data") as! NSDictionary
                //                    let pictureUrlString  = data.valueForKey("url") as! String
                //                    let pictureUrl = NSURL(string: pictureUrlString)
                //
                //                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                //
                //                        let imageData = NSData(contentsOfURL: pictureUrl!)
                //
                //                        dispatch_async(dispatch_get_main_queue()) {
                //                            if let imageData = imageData
                //                            {
                //                                let userProfileImage = UIImage(data: imageData)
                //                                self.userProfileImage.image = userProfileImage
                //                                self.userProfileImage.contentMode = UIViewContentMode.ScaleAspectFit
                //                            }
                //                        }
                //                    }
                //                }
            }
        })
    }
    func logout() {
        LoginManager().logOut()
    }
    private var action: UIAlertAction!
//    var strUserName = ""
//    var strUserName = ""

    func called_Check_Email_API(St_ID:String, St_FirstName:String, St_LastName:String, St_Email:String,St_Password:String, St_Mobile:String,St_AccountTypeID:String,St_apple_user_id:String)
    {
        //        if let _ = AccessToken.current
        //        {
        showActivityIndicator()
        self.logout()

        var params = ["":""]//["Email":"\(St_Email)","apple_user_id":St_apple_user_id]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        var API_temp = API.SP_Check_Student_Duplicate_EmailApi
        if St_AccountTypeID == "9"
        {
            API_temp = API.SP_Check_Student_Duplicate_Email_iOSApi
            params = ["apple_user_id":St_apple_user_id,"UDID":"\(UserDefaults.standard.object(forKey: "UUID") ?? "")","AccountTypeID":St_AccountTypeID]
        }
        else
        {
            params = ["Email":"\(St_Email)","apple_user_id":St_apple_user_id,"UDID":"\(UserDefaults.standard.object(forKey: "UUID") ?? "")","AccountTypeID":St_AccountTypeID]
        }

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

                    let jsonArray = json["data"][0].dictionaryObject!
                    //                        UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")
                    //                        let dic_loginData = ["StudentEmailAddress":"\(jsonArray["StudentEmailAddress"] ?? "")", "StudentID":"\(jsonArray["StudentID"] ?? "")", "StudentFirstName":"\(jsonArray["StudentFirstName"] ?? "")", "StatusID":"\(jsonArray["StatusID"] ?? "")", "StudentLastName":"\(jsonArray["StudentLastName"] ?? "")", "AccountTypeID":"\(jsonArray["AccountTypeID"] ?? "")", "StudentMobile":"\(jsonArray["StudentMobile"] ?? "")", "StudentPassword":"\(jsonArray["StudentPassword"] ?? "")","OTP":"\(jsonArray["OTP"] ?? "")"]
                    UserDefaults.standard.set(jsonArray, forKey: "logindata")
                    UserDefaults.standard.set("1", forKey: "isLogin")
//                    UserDefaults.standard.set("", forKey: "Deeplink")
//                    isDeeplink = ""
                    self.api_Send_Token()

                    if json["data"][0]["Preference"].count > 0
                    {
                        let jsonArrayPrefrence = json["data"][0]["Preference"][0].dictionaryObject!
                        self.pushPackage(Dic:jsonArrayPrefrence, isEmailAvilable: "true")
                    }
                    else
                    {
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
//                        //                    SJSwiftSideMenuController.pushViewController(vc!, animated: true)
//                        self.navigationController?.pushViewController(vc!, animated: true)


                        let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                        popupVC.selectedIndex = 1
                        popupVC.strtemo_Selected = "1"
                        selectedPackages = 1
                        add(asChildViewController: popupVC, self)

                    }

                }
                else
                {
                    if St_AccountTypeID == "9"{
                        let alert = UIAlertController(title: "", message: "Please provide following information for the reference", preferredStyle: UIAlertController.Style.alert)
                        //        alert.view.backgroundColor = GetColor.whiteColor
                        //        alert.addTextField(configurationHandler: configurationTextField)
                        //                        let closeAction = UIAlertAction(title: "Skip", style: .default) { (_) in
                        //                        }
                        //        alert.addAction(closeAction)
                        //                        if
                        //                        {
                        alert.addTextField { (textField) in
                            textField.placeholder = "First name"
                            textField.keyboardType = .default
                            textField.tag = 1001
                            textField.delegate = self
//                            textField.height = 70
                            textField.text = St_FirstName
                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        }
                        alert.addTextField { (textField) in
                            textField.placeholder = "Last name"
                            textField.keyboardType = .default
                            textField.tag = 1002
                            textField.delegate = self
//                            textField.height = 70
                            textField.text = St_LastName
                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        }

                        //                        if St_Email == "" || St_FirstName == "" || St_LastName == ""
                        //                        {
//                        alert.addTextField { (textField) in
//                            textField.placeholder = "Email"
//                            textField.keyboardType = .emailAddress
//                            textField.tag = 1003
//                            textField.delegate = self
//                            textField.height = 70
//                            textField.text = St_Email
//                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
//                        }

                        //                        }

                        self.action = UIAlertAction(title: "Done", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
                            //            return false
                            //                                "4"
                            let txtFirstname = alert.textFields![0].text //else { return }
                            let textSecondname = alert.textFields![1].text
                            let textEmail = St_Email//alert.textFields![2].text
                            print(txtFirstname ?? "",textSecondname ?? "",textEmail ?? "")

//                            self.called_Check_Email_iOS_Befor_Submit_API(St_ID: "0", St_FirstName: txtFirstname ?? "" , St_LastName: textSecondname ?? "" , St_Email: textEmail ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)
                            self.apiSignUp(St_ID: "0", St_FirstName: txtFirstname ?? "" , St_LastName: textSecondname ?? "", St_Email: textEmail, St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)

                            //                                self.called_Check_Email_API(St_ID: "0", St_FirstName: givenName , St_LastName: familyName , St_Email: email , St_Password: "", St_Mobile: "", St_AccountTypeID: "2", St_apple_user_id: "")

                            //                                self.apiSignUp(St_ID: "0", St_FirstName: txtFirstname ?? "" , St_LastName: textSecondname ?? "" , St_Email: textEmail ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)

                        }
                        //                        if St_Email == "" || St_FirstName == "" || St_LastName == ""
                        //                        {
                        if St_FirstName != ""{self.strIsFirstName = "1"}else{self.strIsFirstName = "0"}
                        if St_LastName != ""{self.strIsLastName = "1"}else{self.strIsLastName = "0"}
                        print("St_FirstName, St_LastName",St_FirstName,St_LastName)
                        if St_FirstName == "" || St_LastName == "" { self.action.isEnabled = false }else{ self.action.isEnabled = true }
                        //                        }else{
                        //                            self.action.isEnabled = true
                        //                        }
                        alert.addAction(self.action)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })

                        //                        }
                        //                        else
                        //                        {
                        //                            print("bypasss: ", St_FirstName, St_LastName, St_Email)
                        ////                            self.apiSignUp(St_ID: "0", St_FirstName: St_FirstName, St_LastName: St_LastName, St_Email: St_Email, St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)
                        //
                        //                        }
                        //                        alert.addTextField { (textField) in
                        //                            textField.placeholder = "First name"
                        //                            textField.keyboardType = .default
                        //                            textField.tag = 1001
                        //                            textField.delegate = self
                        //                            textField.height = 70
                        //                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        //                        }
                        //                        alert.addTextField { (textField) in
                        //                            textField.placeholder = "Last name"
                        //                            textField.keyboardType = .default
                        //                            textField.tag = 1002
                        //                            textField.delegate = self
                        //                            textField.height = 70
                        //                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        //                        }
                        //                        alert.addTextField { (textField) in
                        //                            textField.placeholder = "Email"
                        //                            textField.keyboardType = .emailAddress
                        //                            textField.tag = 1003
                        //                            textField.delegate = self
                        //                            textField.height = 70
                        //                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        //                        }


                        //                        self.present(alert, animated: true, completion: {
                        //                            //Bhargav Hide
                        //                            ////print("completion block")
                        //                        })


                    }
                    else
                    {
                        self.apiSignUp(St_ID: "0", St_FirstName: St_FirstName , St_LastName: St_LastName , St_Email: St_Email, St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)
                    }

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print(error)
                self.hideActivityIndicator()
            }
        }
        //        }
    }

        func called_Check_Email_iOS_Befor_Submit_API(St_ID:String, St_FirstName:String, St_LastName:String, St_Email:String,St_Password:String, St_Mobile:String,St_AccountTypeID:String,St_apple_user_id:String)
        {
            //        if let _ = AccessToken.current
            //        {
            showActivityIndicator()
            self.logout()

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
                params = ["Email":"\(St_Email)","apple_user_id":St_apple_user_id,"UDID":"\(UserDefaults.standard.object(forKey: "UUID") ?? "")"]
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

                        let alert = UIAlertController(title: "", message: "Please provide following information for the reference", preferredStyle: UIAlertController.Style.alert)
                        alert.addTextField { (textField) in
                            textField.placeholder = "First name"
                            textField.keyboardType = .default
                            textField.tag = 1001
                            textField.delegate = self
//                            textField.height = 70
                            textField.text = St_FirstName
                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        }
                        alert.addTextField { (textField) in
                            textField.placeholder = "Last name"
                            textField.keyboardType = .default
                            textField.tag = 1002
                            textField.delegate = self
//                            textField.height = 70
                            textField.text = St_LastName
                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
                        }

                        //                        if St_Email == "" || St_FirstName == "" || St_LastName == ""
                        //                        {
//                        alert.addTextField { (textField) in
//                            textField.placeholder = "Email"
//                            textField.keyboardType = .emailAddress
//                            textField.tag = 1003
//                            textField.delegate = self
//                            textField.height = 70
//                            textField.text = St_Email
//                            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
//                        }

                        //                        }

                        self.action = UIAlertAction(title: "Done", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
                            //            return false
                            let txtFirstname = alert.textFields![0].text //else { return }
                            let textSecondname = alert.textFields![1].text
                            let textEmail = St_Email//alert.textFields![2].text
                            print(txtFirstname ?? "",textSecondname ?? "",textEmail ?? "")
//                            self.apiSignUp(St_ID: "0", St_FirstName: txtFirstname ?? "" , St_LastName: textSecondname ?? "" , St_Email: textEmail ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)
                            self.called_Check_Email_iOS_Befor_Submit_API(St_ID: "0", St_FirstName: txtFirstname ?? "" , St_LastName: textSecondname ?? "" , St_Email: textEmail ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)

                        }
                        //                        if St_Email == "" || St_FirstName == "" || St_LastName == ""
                        //                        {
                        if St_FirstName != ""{self.strIsFirstName = "1"}else{self.strIsFirstName = "0"}
                        if St_LastName != ""{self.strIsLastName = "1"}else{self.strIsLastName = "0"}
                        print("St_FirstName, St_LastName",St_FirstName,St_LastName)
                        if St_FirstName == "" || St_LastName == "" { self.action.isEnabled = false }else{ self.action.isEnabled = true }
                        //                        }else{
                        //                            self.action.isEnabled = true
                        //                        }
                        alert.addAction(self.action)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })
                        self.view?.makeToast("Email already exists", duration: 3.0, position: .bottom)


                    }
                    else
                    {
                        self.apiSignUp(St_ID: "0", St_FirstName: St_FirstName , St_LastName: St_LastName , St_Email: St_Email, St_Password: "", St_Mobile: "", St_AccountTypeID: St_AccountTypeID, St_apple_user_id: St_apple_user_id)

                    }
                case .failure(let error):
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                    print(error)
                    self.hideActivityIndicator()
                }
            }
            //        }
        }



    func apiSignUp(St_ID:String, St_FirstName:String, St_LastName:String, St_Email:String,St_Password:String, St_Mobile:String, St_AccountTypeID:String, St_apple_user_id:String)
    {
        showActivityIndicator()
//        var result : NSMutableDictionary = [:]
        var StdIDTemp = "0"
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
//            result = UserDefaults.standard.value(forKey: "logindata") as! NSMutableDictionary
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            StdIDTemp = "\(result.value(forKey: "StudentID") ?? "")"
        }
        //        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")",

        let params = ["StudentID":StdIDTemp,//"\(St_ID)",
            "StudentFirstName":"\(St_FirstName)",
            "StudentLastName":"\(St_LastName)",
            "StudentEmailAddress":"\(St_Email)",
            "StudentPassword":"\(St_Password)",
            "StudentMobile":"\(St_Mobile)",
            "StatusID":"1",
            "AccountTypeID":St_AccountTypeID,
            "apple_user_id":St_apple_user_id,
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
                    //                    UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")
                    //                    let dic_loginData = ["StudentEmailAddress":"\(jsonArray["StudentEmailAddress"] ?? "")", "StudentID":"\(jsonArray["StudentID"] ?? "")", "StudentFirstName":"\(jsonArray["StudentFirstName"] ?? "")", "StatusID":"\(jsonArray["StatusID"] ?? "")", "StudentLastName":"\(jsonArray["StudentLastName"] ?? "")", "AccountTypeID":"\(jsonArray["AccountTypeID"] ?? "")", "StudentMobile":"\(jsonArray["StudentMobile"] ?? "")", "StudentPassword":"\(jsonArray["StudentPassword"] ?? "")","OTP":"\(jsonArray["OTP"] ?? "")"]
                    UserDefaults.standard.set(jsonArray, forKey: "logindata")
                    UserDefaults.standard.set("1", forKey: "isLogin")
                    self.api_Send_Token()
                    if json["data"][0]["Preference"].count > 0
                    {
                        let jsonArrayPrefrence = json["data"][0]["Preference"][0].dictionaryObject!
                        self.pushPackage(Dic:jsonArrayPrefrence, isEmailAvilable: "false")
                    }
                    else
                    {
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
                        //                    SJSwiftSideMenuController.pushViewController(vc!, animated: true)
                        //self.navigationController?.pushViewController(vc!, animated: true)


//                        if  UserDefaults.standard.bool(forKey:"isFirstTimeShow") == true{
//                            let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
//                            popupVC.selectedIndex = 0
//                            popupVC.strtemo_Selected = "0"
//                            selectedPackages = 0
//                            add(asChildViewController: popupVC, self)
//                        }else{
                            let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                            popupVC.selectedIndex = 1
                            popupVC.strtemo_Selected = "1"
                            selectedPackages = 1
                            add(asChildViewController: popupVC, self)
                       // }
                    }
                }
                else
                {
                    //                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                    //                    //            self.navigationController?.pushViewController(vc!, animated: true)
                    //                    SJSwiftSideMenuController.pushViewController(vc!, animated: true)
                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
    //MARK: GIDSignIn Delegate

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId : String = user.userID                  // For client-side use only!
            //Bhargav Hide
            ////print("User id is \(userId)")

            let idToken : String = user.authentication.idToken // Safe to send to the server
            //Bhargav Hide
            print("Authentication idToken is \(idToken)")
            let fullName : String = user.profile.name
            //Bhargav Hide
            print("User full name is \(fullName)")
            let givenName : String = user.profile.givenName
            //Bhargav Hide
            print("User given profile name is \(givenName)")
            let familyName : String = user.profile.familyName
            //Bhargav Hide
            print("User family name is \(familyName)")
            let email : String = user.profile.email
            //Bhargav Hide
            print("User email address is \(email)")
            //             let userId = user.userID                  // For client-side use only!
            //            let idToken = user.authentication.idToken // Safe to send to the server
            //            let fullName = user.profile.name
            //            let givenName = user.profile.givenName
            //            let familyName = user.profile.familyName
            //            let email = user.profile.email
            //            //Bhargav Hide
            ////print("\(user.userID) \(user.authentication.idToken) \(user.profile.name) \(user.profile.givenName) \(user.profile.familyName) \(user.profile.email)")
            //            self.called_Check_Email_API(St_ID: "0", St_FirstName: givenName ?? "", St_LastName: familyName ?? "", St_Email: email ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: "2")

            if user.profile.hasImage
            {
                let pic : String = "\(user.profile.imageURL(withDimension: 100) ?? NSURL(fileURLWithPath: "") as URL)"
                //Bhargav Hide
                ////print(pic)
                UserDefaults.standard.set("\(pic)", forKey: "ProfilePhoto")
            }
            else
            {
                UserDefaults.standard.set("", forKey: "ProfilePhoto")
            }
            self.called_Check_Email_API(St_ID: "0", St_FirstName: givenName , St_LastName: familyName , St_Email: email , St_Password: "", St_Mobile: "", St_AccountTypeID: "7", St_apple_user_id: "")

            //  self.apiSignUp(St_ID: "0", St_FirstName: givenName ?? "" , St_LastName: familyName ?? "" , St_Email: email ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: "2")
            // ...
        } else {
            //Bhargav Hide
            ////print("ERROR ::\(error.localizedDescription)")
        }
    }

    //        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
    //                  withError error: Error!) {
    //
    //            if let error = error {
    //                //Bhargav Hide
    ////print("errorrrrr......\n \(error.localizedDescription)")
    //            } else {
    //                // Perform any operations on signed in user here.
    //
    ////                let userId = user.userID                  // For client-side use only!
    ////                let idToken = user.authentication.idToken // Safe to send to the server
    ////                let fullName = user.profile.name
    ////                let givenName = user.profile.givenName
    ////                let familyName = user.profile.familyName
    ////                let email = user.profile.email
    ////                //Bhargav Hide
    ////print("\(user.userID) \(user.authentication.idToken) \(user.profile.name) \(user.profile.givenName) \(user.profile.familyName) \(user.profile.email)")
    ////                self.called_Check_Email_API(St_ID: "0", St_FirstName: givenName ?? "", St_LastName: familyName ?? "", St_Email: email ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: "2")
    ////
    ////                if user.profile.hasImage
    ////                {
    ////                    let pic : String = "\(user.profile.imageURL(withDimension: 100) ?? NSURL(fileURLWithPath: "") as URL)"
    ////                    //Bhargav Hide
    ////print(pic)
    ////                    UserDefaults.standard.set("\(pic)", forKey: "ProfilePhoto")
    ////
    ////                }
    ////                else
    ////                {
    ////                UserDefaults.standard.set("", forKey: "ProfilePhoto")
    ////                }
    ////    //            self.apiSignUp(St_ID: "0", St_FirstName: givenName ?? "" , St_LastName: familyName ?? "" , St_Email: email ?? "", St_Password: "", St_Mobile: "", St_AccountTypeID: "2")
    ////                // ...
    //            }
    //        }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        //Bhargav Hide
        ////print("didDisconnectWith",user)
    }

    func pushPackage(Dic: [String:Any],isEmailAvilable: String)//(CategoryID: String, CategoryID1: String, CategoryID2: String, CategoryID3: String)
    {
        let dictPrice:[String:Any] = ["minPrice":"0", "maxPrice":"5000"]
        UserDefaults.standard.set(dictPrice, forKey: "filter_price")
        //        params = ["BoardID":strCategoryID1, "StandardID":strCategoryID2, "CourseTypeID": strCategoryID,"SubjectID":strCategoryID3, "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]// new1

        strCategoryID = "\(Dic["CourseTypeID"] ?? "")"//"1"// CategoryID //arrData0.joined(separator:",")//Board
        if strCategoryID == "1" //Exam
        {
            strCategoryID1 = "\(Dic["BoardID"] ?? "")"//"1"// CategoryID1 //arrData0.joined(separator:",")//Board
            strCategoryID2 = "\(Dic["StandardID"] ?? "")"//"9"// CategoryID2 //arrData1.joined(separator:",")//Standard
            strCategoryID3 = "\(Dic["SubjectID"] ?? "")"// CategoryID3  //arrData2.joined(separator:",")//Subject
            //                        strCategoryTitle1 = arrDataTitle0.joined(separator:", ")//Board
            //                        strCategoryTitle2 = arrDataTitle1.joined(separator:", ")//Standard
            //                        strCategoryTitle3 = arrDataTitle2.joined(separator:", ")//Subject
            //Bhargav Hide
            ////print("Type:\(strCategoryID), Board:\(strCategoryID1), Standard:\(strCategoryID2), Subject:\(strCategoryID3)")
        }
        else
        {
            //            params = ["BoardID":strCategoryID1, "StandardID":"", "CourseTypeID": strCategoryID, "SubjectID":strCategoryID3, "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]// new1

            strCategoryID1 =  "\(Dic["BoardID"] ?? "")"//Exam
            //            strCategoryID1 =  "\(Dic["CourseID"] ?? "")"//Exam
            strCategoryID2 = "\(Dic["StandardID"] ?? "")"//"9"
            strCategoryID3 = "\(Dic["SubjectID"] ?? "")" // CategoryID3 //arrData2.joined(separator:",")//Subject
            //                        strCategoryTitle1 = arrDataTitle0.joined(separator:", ")//Exam
            //                        strCategoryTitle3 = arrDataTitle2.joined(separator:", ")//Subject
            //Bhargav Hide
            ////print("Type:\(strCategoryID), Exam:\(strCategoryID1), Standard:\(strCategoryID2), Subject:\(strCategoryID3)")

        }

        strTutorsId = ""
        strTutorsTitle = ""
        //                    strTutorsId = "\(exam_preferences.value(forKey: "TutorID") ?? "")"
        //                    strTutorsTitle = "\(exam_preferences.value(forKey: "TutorTitle") ?? "")"

        let dict:[String:Any] = ["CategoryID":strCategoryID, "CategoryID1":strCategoryID1, "CategoryID2":strCategoryID2, "CategoryID3":strCategoryID3, "CategoryTitle":strCategoryTitle, "CategoryTitle1":strCategoryTitle1, "CategoryTitle2":strCategoryTitle2, "CategoryTitle3":strCategoryTitle3, "TutorID":strTutorsId,"TutorTitle":strTutorsTitle , "arrPath":arrPath] // arrDataTitle0
        UserDefaults.standard.set(dict, forKey: "exam_preferences")
//        UserDefaults.standard.set("", forKey: "Deeplink")
//        isDeeplink = ""

//        for controller in self.navigationController!.viewControllers as Array {
//            //Bhargav Hide
//            print(controller)
//            if controller.isKind(of: DashboardVC.self) {
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }else
//            if controller.isKind(of: OtherVC.self) {
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }else
//            if controller.isKind(of: DeeplinkTestListVC.self) {
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }else
//            if controller.isKind(of: HighlightsVC.self)
//            {
//                if isEmailAvilable == "true"
//                {
//                    for controller1 in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//                        print(controller1)
//                        if controller1.isKind(of: MarketPlaceMultiBoxVC.self) {
//                            controller1.tabBarController!.selectedIndex = 0
//                            self.navigationController!.popToViewController(controller1, animated: false)
//                            break
//                        }
//                    }
//                }
//                else{
//                    self.navigationController!.popToViewController(controller, animated: false)
//                    break
//                }
//            }else
//            if controller.isKind(of: TestListVC.self) {
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }
//            else{
                let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
                if isDeeplink == "" {
                    popupVC.selectedIndex = 1
                    popupVC.strtemo_Selected = "1"
                    selectedPackages = 1
                } else {
                    popupVC.selectedIndex = 0
                    popupVC.strtemo_Selected = "0"
                    selectedPackages = 0
                }
                UserDefaults.standard.set("", forKey: "Deeplink")
                isDeeplink = ""
                //                popupVC.selectedIndex = 1
                //                selectedPackages = 1
                add(asChildViewController: popupVC, self)
            //}


       // }

    }

}
extension IntroVC
{
    func apiIzumlabs_Track_Create_GameID(strID:String)
    {
////        let params = ["gameid":"6616E8DC-917C-473D-ACA1-4540D7AC9488"]
////        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
//        //Bhargav Hide
//        print("API, Params: \n",API.getsessionIDCreateApi)
//          let headers = [
//            "content-type": "application/x-www-form-urlencoded",
//            "cache-control": "no-cache",
//            "postman-token": "4d4b8efc-991a-0645-5f14-405007a70f9b"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: API.getsessionIDCreateApi)! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            debugPrint("debug",response ?? "")
//            //                let json = JSON(response.data!)
////                            print(response.request ?? "")  // original URL request
////                            print(response.response ?? "") // URL response
////                            print(response.data ?? "")     // server data
////                            print(response.result)   // result of response serialization
//
//
//          if (error != nil) {
//            print("error",error)
//          } else {
//            let httpResponse = response as? HTTPURLResponse
//            print("httpResponse",httpResponse)
//          }
//        })
//
//        dataTask.resume()
////        let todosEndpoint: String = API.getsessionIDCreateApi
////        Alamofire.request(API.getsessionIDCreateApi, method: .get , parameters: nil, encoding: JSONEncoding.default).responseString(completionHandler: {
////            (request: NSURLRequest, response: HTTPURLResponse?, responseBody: String?, error: NSError?) -> Void in
////
////                // Convert the response to NSData to handle with SwiftyJSON
////                if let data = (responseBody as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
////                    let json = JSON(data: data)
////                    println(json)
////                }
////        })
//
////        Alamofire.request(API.getsessionIDCreateApi, method: .post, encoding: JSONEncoding.default)
////            .responseJSON { response in
//////                debugPrint("debug",response)
//////                let json = JSON(response.data!)
////                print(response.request ?? "")  // original URL request
////                print(response.response ?? "") // URL response
////                print(response.data ?? "")     // server data
////                print(response.result)   // result of response serialization
////
////                if let JSON = response.result.value {
////                    print("JSON: \(JSON)")
////                }
////
////                switch response.result {
////                case .success(let value):
////                    let json = JSON(value)
////                    //Bhargav Hide
////                    print("json",json)//TrackTokenID
//////                    UserDefaults.standard.set("", forKey: "TrackTokenID")
////
////                //                if(json["Status"] == "true" || json["Status"] == "1") {}else{}
////                case .failure(let error):
////                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
////                    print("error",error)
////
////                }
//
//////                if let data = response.result.value{
//////                    // Response type-1
//////                    if  (data as? [[String : AnyObject]]) != nil{
//////                        print("data_1: \(data)")
//////                    }
//////                    // Response type-2
//////                    if  (data as? [String : AnyObject]) != nil{
//////                        print("data_2: \(data)")
//////                    }
//////                }
////            }
//
////        Alamofire.request(API.getsessionIDCreateApi, method: .get, parameters: params, headers: headers).validate().responseJSON { response in
////            switch response.result {
////            case .success(let value):
////                let json = JSON(value)
////                //Bhargav Hide
////                print(json)//TrackTokenID
////                UserDefaults.standard.set("", forKey: "TrackTokenID")
////
//////                if(json["Status"] == "true" || json["Status"] == "1") {}else{}
////            case .failure(let error):
////                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
////                print(error)
////
////            }
////        }
    }
    @available(iOS 13.0, *)
    private func setupLoginProviderView() {
        // Set button style based on device theme
        let isDarkTheme = view.traitCollection.userInterfaceStyle == .dark
        let style: ASAuthorizationAppleIDButton.Style = isDarkTheme ? .black : .black//.white : .black

        // Create and Setup Apple ID Authorization Button
        let authorizationButton = ASAuthorizationAppleIDButton(type: .default, style: style)
        authorizationButton.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
        authorizationButton.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 60, height: 50)
        authorizationButton.clipsToBounds = true
        authorizationButton.addShadowWithRadius(0,25,0,color: GetColor.blueHeaderText)
        // Add Height Constraint
        let heightConstraint = authorizationButton.heightAnchor.constraint(equalToConstant: 50)
        authorizationButton.addConstraint(heightConstraint)

//        Add Apple ID authorization button into the stack view
        AppleLogInButton.addSubview(authorizationButton)

//        let AppleLogInButton = ASAuthorizationAppleIDButton()
//
////        AppleLogInButton.frame = CGRect(x: 0, y: 0, width: GoogleLoginButton.bounds.width, height: GoogleLoginButton.frame.height)
////        btnAuthorization.center = AppleLogInButton.center
////                btnAuthorization.frame.size = GoogleLoginButton.bounds.size
//        AppleLogInButton.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
//
////        AppleLogInButton.addSubview(btnAuthorization)
////        btnAuthorization.frame.size = GoogleLoginButton.bounds.size

    }
    override func viewDidLayoutSubviews() {
//        AppleLogInButton.subviews[1].frame.size = self.AppleLogInButton.bounds.size
    }

    @available(iOS 13.0, *)
    @objc func actionHandleAppleSignin() {

        let appleIDProvider = ASAuthorizationAppleIDProvider()

        let request = appleIDProvider.createRequest()

        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])

        authorizationController.delegate = self

        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding

        authorizationController.performRequests()

    }

    @available(iOS 13.0, *)
    private func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(), ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }
    @available(iOS 13.0, *)
    @objc private func handleLogInWithAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self as! ASAuthorizationControllerPresentationContextProviding
        authorizationController.performRequests()
    }

}

extension IntroVC : ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account in your system.
            // For the purpose of this demo app, store the these details in the keychain.
//            KeychainItem.currentUserIdentifier = appleIDCredential.user
//            KeychainItem.currentUserFirstName = appleIDCredential.fullName?.givenName
//            KeychainItem.currentUserLastName = appleIDCredential.fullName?.familyName
//            KeychainItem.currentUserEmail = appleIDCredential.email

            print("appleIDCredential - \(appleIDCredential)")
            print("User - \(appleIDCredential.user)")
            print("User Name - \(appleIDCredential.fullName?.description ?? "N/A")")
            print("User Email - \(appleIDCredential.email ?? "N/A")")
            print("Real User Status - \(appleIDCredential.realUserStatus.rawValue)")

            if let identityTokenData = appleIDCredential.identityToken,
                let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                print("Identity Token \(identityTokenString)")
            }
            let userName = "\(appleIDCredential.fullName?.description ?? "N/A")"//json.value(forKey: "name") as? String
            let userfirst_name = "\(appleIDCredential.fullName?.givenName ?? userName)" //json.value(forKey: "name") as? String
            let userlast_name = "\(appleIDCredential.fullName?.familyName ?? "")"//json.value(forKey: "name") as? String
            let useremail = "\(appleIDCredential.email ?? "")"//json.value(forKey: "name") as? String
            let userIdentifier = "\(appleIDCredential.user)"//json.value(forKey: "name") as? String

            UserDefaults.standard.set("", forKey: "ProfilePhoto")

            self.called_Check_Email_API(St_ID: "0", St_FirstName: userfirst_name , St_LastName: userlast_name, St_Email: useremail, St_Password: "", St_Mobile: "", St_AccountTypeID: "9", St_apple_user_id: userIdentifier)

            //Show Home View Controller
//            HomeViewController.Push()
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password

            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
                let alertController = UIAlertController(title: "Keychain Credential Received",
                                                        message: message,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
extension IntroVC {

//extension LogInViewController : ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//}

    @objc private func textFieldDidChange(_ field: UITextField) {
        //Bhargav Hide
////print(field.text,field.text?.count)
//        strStudentMobile = field.text ?? ""
        if field.tag == 1001{if field.text!.count > 0{strIsFirstName = "1"}else{strIsFirstName = "0"}}
        if field.tag == 1002{if field.text!.count > 0{strIsLastName = "1"}else{strIsLastName = "0"}}
//        if field.tag == 1003
//        {
//            if field.text!.count > 0
//            {
//                if isEmailValid(field.text!) == false{
////                           txtEmail.showInfo("Please enter valid email.")
////                           valid = false
//                    strIsEmailId = "0"
//                }
//                else
//                {
//                    strIsEmailId = "1"
//                }
//            }
//            else
//            {strIsEmailId = "0"}
//        }
        if strIsFirstName == "1" && strIsLastName == "1" //&& strIsEmailId == "1"
        {action.isEnabled = true}else{action.isEnabled = false}
//        action.isEnabled = field.text?.count ?? 10 > 10
    }
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
//                    action.isEnabled = true
//                }
//                else
//                {
//                    result = replacementStringIsLegal
//                    action.isEnabled = false
//                }
//            }
//        }
//
//        return result
//    }
}
