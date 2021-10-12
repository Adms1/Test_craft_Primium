//
//  Help Files.swift
//  Chat
//
//  Created by Bhargav on 26/04/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
//import TransitionButton
//import SDWebImage
//import TransitionButton
import Alamofire
import SwiftyJSON
//import SwiftGifOrigin
import Foundation
import WebKit;
import FBSDKCoreKit
import FBSDKCoreKit.FBSDKSettings

//import FBSDKCoreKit
//import FBSDKCoreKit.FBSDKSettings

var bundleDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String

// isForgotVC
var isForgot = ""
var strForgotStudentID = ""
var isContinuePurchsedFromDetailScreen = ""

var Package_placeHolder = UIImage(named: "")
var Persion_placeHolder = UIImage(named: "")//"pro_pic1.png")


var strMinPrice = ""
var strMaxPrice = ""
var strMyCoin = "0"

var arrPath = [String]()
// Level 0

// Level 1 CategoryID
var strCategoryID = ""
var strCategoryTitle = ""

// Level 2 BoardID
var strCategoryID1 = ""
var strCategoryTitle1 = ""

// Level 3 StandardID
var strCategoryID2 = ""
var strCategoryTitle2 = ""

// Level 4
var strCategoryID3 = ""
var strCategoryTitle3 = ""

// Level 5
var strCategoryID4 = ""
var strCategoryTitle4 = ""

//DeepLink Process
var isDeeplink = ""

// first time free subscription

var IsFreeFirstTime = ""
//    var IsFree = ""
//var temp_Order_ID = ""
//var temp_PaymentTransaction_ID = ""
//
//var strCouponCode = ""

var FirstTimeCourseTypeID:Int = 0
var FirstTimeBoardId:Int = 0
var FirstTimeStandardId:Int = 0


var dictJson:JSON = []
var UserOpenglobalSection:Int = -1
var UserOpenglobalIndex:Int = -1


var UserOpenStanderd:String = ""
var UserOpenBoard:String = ""


var firstTimestrSelectCoin:String = ""
var firstTimeunlockTest_InAppPurchase_Selected_ProductId = ""



//Payment
var Order_ID:String!
var PaymentTransaction_ID:String!

#if DEBUG
    let verifyReceiptURL = "https://sandbox.itunes.apple.com/verifyReceipt"
#else
    let verifyReceiptURL = "https://buy.itunes.apple.com/verifyReceipt"
#endif

    let kInAppProductPurchasedNotification = "InAppProductPurchasedNotification"
    let kInAppPurchaseFailedNotification   = "InAppPurchaseFailedNotification"
    let kInAppProductRestoredNotification  = "InAppProductRestoredNotification"
    let kInAppPurchasingErrorNotification  = "InAppPurchasingErrorNotification"

//    let unlockTestInAppPurchase1ProductId_0_99 = "com.tc.testcraft.product1"//"com.testing.iap1"
//    let unlockTestInAppPurchase2ProductId_1_99 = "com.tc.testcraft.product2"
//    let autorenewableSubscriptionProductId = "com.testing.autorenewablesubscription"
//    let nonrenewingSubscriptionProductId = "com.testing.nonrenewingsubscription"

//MarketPlaceVC
var selectedPackages = 0
var strTutorsId = ""
var strTutorsTitle = ""

//MarketPlaceVC
var selectedTutors = 0


//ExploreVC
var arrRecentSearches = [String]()
var kAppStoreID = "1491298929"

// MARK: - API

struct API {
    static let strVersion:String  = "Ver. No.: 2.120210305"
    static let strGameID:String   = "6616E8DC-917C-473D-ACA1-4540D7AC9488"

    static let hostName:String    = "\(bundleDisplayName == "TestCraft Premium" ? "https://webservice.testcraft.in/" : "http://demowebservice.testcraft.in/")" //"LIVE" : "TEST"

    static let verifyReceiptURLInappPurchase:String    = "\(bundleDisplayName == "TestCraft Premium" ? "https://buy.itunes.apple.com/verifyReceipt" : "https://sandbox.itunes.apple.com/verifyReceipt/")" //"LIVE" : "TEST"


    static let baseUrl:String     = "\(hostName)webservice.asmx/"
    static let hostName1:String   = "\(bundleDisplayName == "TestCraft Premium" ? "http://testcraft.in/" : "http://demo.testcraft.in/")" //"LIVE" : "TEST"
    static let PaymentMode:String = "\(bundleDisplayName == "TestCraft Premium" ? "LIVE" : "TEST")" //"LIVE" : "TEST")"
    
    static let TermsCondition:String       = "TCTerms.aspx"
    static let PrivacyPolicy:String        = "PrivacyPolicyMobile.aspx"
    static let ContactUs:String            = "\(baseUrl)Send_Enquiry"

    static let boardImageBannerUrl         = "https://testcraft.in/Banners_Lite/"
    
//    static let hostName:String          = "http://demowebservice.testcraft.in/" // Local
//    static let baseUrl:String           = "\(hostName)webservice.asmx/" // Local
//    static let hostName1:String         = "http://demo.testcraft.in/" // Local
//    static let PaymentMode:String       = "TEST"

//    static let hostName:String          = "http://webservice.testcraft.in/" // Live
//    static let baseUrl:String           = "\(hostName)WebService.asmx/" // Live
//    static let hostName1:String         = "http://testcraft.in/" // Live
//    static let PaymentMode:String       = "LIVE"

    
    static let invoiceUrl:String        = "\(hostName1)InvoiceDetail.aspx?ID="
    static let SubcriptionInvoiceDetailUrl:String        = "\(hostName1)SubcriptionInvoiceDetail.aspx?ID="
    static let imageUrl:String          = "\(hostName1)upload/"
    static let imageUrl2:String         = "\(hostName1)"
//    http://testcraft.in/SubcriptionInvoiceDetail
    //static let QueImg:String            =  "https://testcraftquestion.s3.ap-south-1.amazonaws.com/Question/"
    static let QueImg:String              =  "" //"https://content.testcraft.co.in/question/"
    static var PaymentUrl                                       = "\(baseUrl)CheckOut" //GeneratePaymentRequest"
    static var UpdatePaymentUrl                                 = "\(baseUrl)Update_Payment_Request_Free" //Update_Payment_Request"
    static var PaymentViaEmailUrl                               = "\(baseUrl)SendPurchaseRequestMail"
//    static var TraknPayUrl                                      = "https://biz.traknpay.in/v1/paymentrequest"
    static var TraknPayUrl                                      = "https://biz.traknpay.in/v2/paymentrequest"
    static var Get_Student_PaymentTransaction_ListUrl           = "\(baseUrl)Get_Student_PaymentTransaction_List"
    static var Get_Student_SubcriptionPaymentTransaction_List   = "\(baseUrl)Get_Student_SubcriptionPaymentTransaction_List"
    static var Add_CartUrl                                      = "\(baseUrl)Add_Cart" //GeneratePaymentRequest"
    static let Promo_Code_CheckApi:String                       = "\(baseUrl)ValidateCouponCode"
    static let WebBrowserPaymentApi:String                      = "\(hostName1)MobilePayment.aspx" //MobilePayment.aspx"
    static let RedeemCouponApi:String                           = "\(baseUrl)ValidateCouponCode"
    static let UsedCouponListApi:String                         = "\(baseUrl)"
    static let Refer_CodeApi:String                             = "\(baseUrl)GetStudentCode"

//    static let izumlabsToken:String                                = "6616E8DC-917C-473D-ACA1-4540D7AC9488"
//    static let getsessionIDCreateApi:String                        = "http://izumlabs.com/getsession.asp?gameid=\(izumlabsToken)"

    static let KnowledgeGepReport:String     = "\(hostName)SubjectSummaryReport.aspx"
    static let TestSummaryReport:String     = "\(hostName)AllTestSummaryReport.aspx"

    // MARK:
    
//    static let addDeviceDetailStaffApi:String                        = "\(baseUrl)AddDeviceDetailStaff"
//    static let deleteDeviceDetailStaffApi:String                     = "\(baseUrl)DeleteDeviceDetailStaff"
    
    static let loginApi:String                                       = "\(baseUrl)Get_Student_Login"
    static let RegistrationApi:String                                = "\(baseUrl)Add_Student_iOS"
    static let Registration_MobileApi:String                         = "\(baseUrl)Add_Student_Mobile"
    static let ReSendOTPApi:String                                   = "\(baseUrl)ReSendOTP"
    static let SP_Check_Student_Duplicate_EmailApi:String            = "\(baseUrl)SP_Check_Student_Duplicate_Email" //SP_Check_Student_Duplicate_Email_UDID
    static let SP_Check_Student_Duplicate_Email_iOSApi:String        = "\(baseUrl)SP_Check_Student_Duplicate_Email_iOS"
    static let EditProfileApi:String                                 = "\(baseUrl)Update_Student"
    static let Check_Email_Mobile_By_Type_NewApi:String              = "\(baseUrl)Check_Email_Mobile_By_Type_New"
    static let ForgotPasswordApi:String                              = "\(baseUrl)Forgot_Password"
    static let ChangePasswordApi:String                              = "\(baseUrl)Change_Password"
    static let ProfileChangePasswordApi:String                       = "\(baseUrl)Update_Student"
    static let Verify_AccountApi:String                              = "\(baseUrl)Verify_Account"
    static let Check_Verify_AccountApi:String                        = "\(baseUrl)Check_Verify_Account"
    static let Verify_Account_Before_RegistrationApi:String          = "\(baseUrl)Verify_Account_Before_Registration"
    static let SP_Check_Student_Duplicate_MobileApi:String           = "\(baseUrl)SP_Check_Student_Duplicate_Mobile"
    static let Get_Activity_ActionApi:String                         = "\(baseUrl)Get_Activity_Action"
    static let Add_Student_TokenApi:String                           = "\(baseUrl)Add_Student_Token"

    static let Get_MyCoin_Api:String                                 = "\(baseUrl)Get_StudentCoin"
    static let Get_CoinList_Api:String                               = "\(baseUrl)Get_Coin"
    static let purchase_Coin_Api:String                              = "\(baseUrl)Add_StudentCoin"

    static let Get_CourseType_ListApi:String                         = "\(baseUrl)Get_CourseType_List"
    static let Get_Course_ListApi:String                             = "\(baseUrl)Get_Course_List"
    static let Get_BoardStandard_ListApi:String                      = "\(baseUrl)Get_BoardStandard_List"
    static let Get_CourseSubject_ListApi:String                      = "\(baseUrl)Get_CourseSubject_List"
    static let Get_BoardStandardSubject_ListApi:String               = "\(baseUrl)Get_BoardStandardSubject_List"
    static let Get_Tutor_By_TutorIDApi:String                        = "\(baseUrl)Get_Tutor_By_TutorID"
    static let Get_TestPackageName_By_IDApi:String                   = "\(baseUrl)Get_TestPackageName_By_ID"
    static let Get_TestPackageName_By_TutorIDApi:String              = "\(baseUrl)Get_TestPackageName_By_TutorID"
    static let Get_TestPackageName_By_Search_CriteriaApi:String      = "\(baseUrl)Get_TestPackageName_By_Search_Criteria_new"
    static let Get_TestPackage_By_IDApi:String                       = "\(baseUrl)Get_TestPackage_By_ID_New"//Get_TestPackage_By_ID"
    static let Check_StudentSubscription_By_PackageApi:String                       = "\(baseUrl)Check_StudentSubscription_By_Package"

    
    static let Get_ChapterListApi:String                             = "\(baseUrl)Get_ChapterList"
    static let Get_Get_Course_Subject_ListApi:String                 = "\(baseUrl)Get_Course_Subject_List"
    static let Get_Course_SectionTemplateApi:String                  = "\(baseUrl)Get_Course_SectionTemplate_List" //Get_Course_SectionTemplate"
    static let Get_Template_DetailApi:String                         = "\(baseUrl)Get_Template_Detail" //Get_Course_SectionTemplate"

    static let Get_TutorApi:String                                   = "\(baseUrl)Get_Tutor"
    static let Get_TutorNameBy_CriteriaApi:String                    = "\(baseUrl)Get_TutorNameBy_Criteria"
    
    static let Get_StandardApi:String                                = "\(baseUrl)Get_Standard"
    static let Get_SubjectApi:String                                 = "\(baseUrl)Get_Subject"
    static let Get_TestPackageName_AutoCompleteApi:String            = "\(baseUrl)Get_TestPackageName_AutoComplete"

//    static let GeneratePaymentRequestApi:String                      = "\(baseUrl)GeneratePaymentRequest"
    static let Update_Payment_RequestApi:String                      = "\(baseUrl)Update_Payment_Request"
    
    static let Add_StudentTestPackageApi:String                      = "\(baseUrl)Add_StudentTestPackage"
    static let Get_StudentTestPackageApi:String                      = "\(baseUrl)Get_StudentTestPackage"
    static let Get_StudentTestPackage_By_SubjectApi:String           = "\(baseUrl)Get_StudentTestPackage_By_Subject"

    static let Get_Student_Subcription_Subject:String           = "\(baseUrl)Get_Student_Subcription_Subject"



    static let Get_StudentTestPackage_By_Subject_DetailApi:String                   = "\(baseUrl)Get_StudentTestPackage_By_Subject_2"

    static let Get_StudentTest_Lite:String                   = "\(baseUrl)Get_StudentTest_Lite"
    static let Get_StudentTest_Lite_New:String                   = "\(baseUrl)Get_StudentTest_Lite_New"


    static let Get_StudentTest_Progress_Lite:String                   = "\(baseUrl)Get_StudentTest_Progress_Lite"


    static let Get_StudentTest_SelfTest_Lite:String                            = "\(baseUrl)Get_StudentTest_SelfTest_Lite"

    static let Get_SelfTestListApi:String                            = "\(baseUrl)Get_SelfTestList"
    static let Get_StudentTestApi:String                             = "\(baseUrl)Get_StudentTest"
    static let Get_Student_TestQuestionApi:String                    = "\(baseUrl)Get_Student_TestQuestion"
    static let Get_Student_TestQuestionNewApi:String                 = "\(baseUrl)Get_Student_StudentTestAnswer_New_aws" //Get_Student_StudentTestAnswer_New"
    static let Insert_Test_AnswerApi:String                          = "\(baseUrl)Insert_Test_Answer"
    static let Insert_Test_HintApi:String                            = "\(baseUrl)Insert_Test_Hint"
    static let Add_StudentTestAnswerApi:String                       = "\(baseUrl)Add_StudentTestAnswer" //old

    static let Pre_Submit_TestApi:String                             = "\(baseUrl)Pre_Submit_Test"
    static let Submit_TestApi:String                                 = "\(baseUrl)Submit_Test" //old
    static let Report_IssueApi:String                                = "\(baseUrl)Insert_IssueReport"
    static let Get_TestPackage_InstructionApi:String                 = "\(baseUrl)Get_TestPackage_Instruction"
    static let Get_StudentTest_SW_AnalysisApi:String                 = "\(baseUrl)Get_StudentTest_SW_Analysis"

    static let Get_Student_StudentTestAnswerApi:String               = "\(baseUrl)Get_Student_StudentTestAnswer"
    static let Get_Student_StudentTestAnswerNewApi:String            = "\(baseUrl)Get_Student_StudentTestAnswer_New_aws" //Get_Student_StudentTestAnswer_New"
    static let Get_StudentTestAnswer_ReportApi:String                = "\(baseUrl)Get_StudentTestAnswer_Report"

    static let Insert_AppRatingApi:String                            = "\(baseUrl)Insert_AppRating"
    static let Get_AppRatingRatingApi:String                         = "\(baseUrl)Get_AppRating"

    static let Get_TutorRatingApi:String                             = "\(baseUrl)Get_TutorRating"
    static let Insert_TutorRatingApi:String                          = "\(baseUrl)Insert_TutorRating"
    static let Insert_StorePrefranceApi:String                       = "\(baseUrl)Add_Student_Preference"
    static let Subject_wise_marksApi:String                          = "\(baseUrl)Subject_wise_marks"

    static let Add_Seach_HistoryApi:String                           = "\(baseUrl)Add_Seach_History"
    static let Get_Seach_HistoryApi:String                           = "\(baseUrl)Get_Seach_History"
    static let Get_ExamLangApi:String                                = "\(baseUrl)Get_DeepLink"
    static let Get_GuestUser_TestApi:String                          = "\(baseUrl)Get_GuestUser_Test"
    static let GetNotificationApi:String                             = "\(hostName)"

    static let Get_ContentCountApi:String                            = "\(baseUrl)Get_ContentCount"
    static let Insert_StudentSubscriptionApi:String                  = "\(baseUrl)Insert_StudentSubscription"
    static let Insert_StudentSubscription_TempApi:String             = "\(baseUrl)Insert_StudentSubscription_Temp"
    static let Get_Subcription_Course_PriceApi:String             = "\(baseUrl)Get_Subcription_Course_Price"
    static let Check_Subcription_FreeTrialApi:String             = "\(baseUrl)Check_Subcription_FreeTrial"

    static let Get_StudentSubscriptionTempApi:String                 = "\(baseUrl)Get_StudentSubscriptionTemp"
    static let Get_ContentCountTempApi:String                        = "\(baseUrl)Get_ContentCountTemp"
    static let Remove_StudentSubscription_TempApi:String             = "\(baseUrl)Remove_StudentSubscription_Temp"
    static let Confirm_StudentSubscriptionApi:String                 = "\(baseUrl)Confirm_StudentSubscription"

    static var SubscriptionPaymentUrl                                = "\(baseUrl)SubscriptionCheckOut" //GeneratePaymentRequest"
    static var SubscriptionUpdatePaymentUrl                          = "\(baseUrl)Update_Subscription_Payment_Request"

//    static var Create_SelfTest_Bord_Api:String                       = "\(baseUrl)Create_SelfTest"
//    static var Create_SelfTest_Competitive_Api:String                = "\(baseUrl)Create_SelfTest"
    static let Create_SelfTest_Bord_Api:String                       = "\(baseUrl)Create_SelfTest"
    static let Create_SelfTest_Competitive_Api:String                = "\(baseUrl)Create_SelfTest_CE"

    static let Get_SelfTest_QueLimit_Board_Api:String                = "\(baseUrl)Get_SelfTest_QueLimit_Board"
//    static let Create_SelfTest_Competitive_Api:String                = "\(baseUrl)"

}
//// MARK: - ActivityIndicatorPresenter

public protocol ActivityIndicatorPresenter {
    
    /// The activity indicator
    var activityIndicatorView: UIView { get }
    var activityIndicator: UIActivityIndicatorView { get }
    var imgView: UIImageView { get }
    /// Show the activity indicator in the view
    func showActivityIndicator()
    
    /// Hide the activity indicator in the view
    func hideActivityIndicator()
}

public extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            self.activityIndicatorView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)  // UIColorFromHex(rgbValue: 0xffffff, alpha: 0.8) UIColor.clear//
            
            let loadingView: UIView = UIView()
            loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)//CGRectMake(0, 0, 80, 80)
            loadingView.center =  CGPoint(x: self.view.bounds.size.width / 2, y: self.view.bounds.height / 2)
            //uiView.center
           // loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
            //                        self.loadingView.clipsToBounds = true
            loadingView.backgroundColor = UIColor.clear//UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)

            loadingView.layer.cornerRadius = 10
            //            var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
//            let imgView: UIImageView = UIImageView()
            self.imgView.frame = CGRect(x: 10, y: 10, width: 60, height: 60)//CGRectMake(0, 0, 80, 80)

            self.imgView.clipsToBounds = true
            self.imgView.contentMode = .scaleAspectFit
//            self.imgView.setGIFImage(name: "Testcraftlogo2.gif")
//            let imageView = UIImageView(image: ui)

           // self.imgView.loadGif(name: "Testcraftlogo2.gif")
            let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "Testcraftlogo2", withExtension: "gif")!)
            let advTimeGif = UIImage.sd_image(withGIFData: imageData!)
            self.imgView.image = advTimeGif

//            self.imgView.image = UIImage.animatedImageNamed(banner, duration: 1)
//            UIImage(named: "Testcraftlogo2.gif")
            self.imgView.layer.cornerRadius = 10
            self.imgView.center = CGPoint(x: loadingView.bounds.size.width / 2, y: loadingView.bounds.height / 2)

           // self.imgView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)

          //  self.activityIndicator.style = .gray
           // self.activityIndicator.frame = CGRect(x: 10, y: 10, width: 70, height: 70) //or whatever size you would like
          //  self.activityIndicator.center = CGPoint(x: loadingView.bounds.size.width / 2, y: loadingView.bounds.height / 2)
            loadingView.addSubview(self.imgView)
           // loadingView.addSubview(self.activityIndicator)
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.addSubview(loadingView)
            self.imgView.startAnimating()
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
//            self.imgView.image = nil
//            self.imgView.stopAnimating()
            self.imgView.removeFromSuperview()

            self.activityIndicator.removeFromSuperview()
            self.activityIndicatorView.removeFromSuperview()
            
        }
    }
    
    
}
func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}

protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }
}

// Conformance
extension UIView: Bluring {}


func isEmailValid(_ value: String) -> Bool {
    do {
        if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
            return false
        }
    } catch {
        return false
    }
    return true
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
    class func rbgA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
        return color
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
}
class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

extension UICollectionView {

        func setEmptyMessageImg(_ message: String) {
    //        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
    //        messageLabel.text = message
    //        messageLabel.textColor = .red
    //        messageLabel.numberOfLines = 0;
    //        messageLabel.textAlignment = .center;
    //        messageLabel.font = UIFont(name: "System-Regular", size: 30)
    //        messageLabel.sizeToFit()
            let messageLabel = UIImageView(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
            messageLabel.image = UIImage(named: "no_package_found")
    //        messageLabel.text = message
    //        messageLabel.textColor = .red
    //        messageLabel.numberOfLines = 0;
    //        messageLabel.textAlignment = .center;
    //        messageLabel.font = UIFont(name: "System-Regular", size: 30)
    //        messageLabel.sizeToFit()

            self.backgroundView = messageLabel;
        }


    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 20, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .red
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "System-Regular", size: 30)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
extension String {
    func removeFormatAmount() -> Double {
        let formatter = NumberFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = ","
        
        return formatter.number(from: self) as! Double? ?? 0
    }
//}
//extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


//// MARK: - Constants
//
struct Constants {
    //
        static let storyBoard              = UIStoryboard.init(name: "Main", bundle: nil)
    //    static let appDelegate             = UIApplication.shared.delegate as! AppDelegate
    //    static let window                  = UIApplication.shared.keyWindow
    static let studentPlaceholder      = UIImage.init(named: "person_placeholder.jpg")
    //    static let dropDownPlaceholder     = "-Please Select-"
    //    static let documentsDirectoryURL   = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    //    static let FontNameArray:[String]  = ["Shruti.ttf", "Shivaji05.ttf", "Gujrati-Saral-1.ttf", "h-saral1.TTF", "h-saral2.TTF", "h-saral3.TTF", "Arvinder.ttf", "H-SARAL0.TTF", "G-SARAL2.TTF", "G-SARAL3.TTF", "G-SARAL4.TTF"]
}
extension UITableView {

    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }

    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                     let indexPath = IndexPath(row: 0, section: 0)
                     self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }

    enum scrollsTo {
        case top,bottom
    }
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        //        border.layer.masksToBounds = true
        self.addSublayer(border)
        
    }
    
}

@objc protocol SuccessFailedDelegate
{
    //    @objc optional func MobileDuplicateDelegate()
    @objc optional func SuccessFailedStatus()
}

// MARK: - Error Messages

struct Message {
//
//    // ----- Login -----
//
//    static let userNameError:String             = "Please enter username"
//    static let passwordError:String             = "Please enter password"
//    static let passwordValidationError:String   = "Password must be 3-12 characters."
//    static let userError:String                 = "Invalid username/password"
//
//    // ----- Profile -----
//
//    static let currentPwdError:String           = "Please enter current password"
//    static let currentPwdNotMatchError:String   = "Current password doesn't match."
//    static let newPwdError:String               = "Please enter new password"
//    static let newCPwdError:String              = "Please enter confirm new password"
//    static let newCCPwdError:String             = "Confirm password should be same as new password"
//
//    // ----- Request -----
//
//    static let subjectError:String              = "Please enter subject"
//    static let descriptionError:String          = "Please enter description"
//
//    // ----- Marks -----
//
//    static let sectionError:String              = "Please select section"
//    static let testError:String                 = "Please select subject"
//
//    // ----- Leave -----
//
//    static let leaveDaysError:String            = "Please select leave days"
//    static let headNameError:String             = "Please select head"
//    static let reasonError:String               = "Please enter valid reason"
//
//    // ----- Add TimeTable -----
//
//    static let standardError:String             = "Please choose grade"
//    static let classError:String                = "Please choose sections"
//    static let subjectIdError:String            = "Please choose subject"
//    static let startTimeHourError:String        = "Please choose start time hour"
//    static let startTimeMinuteError:String      = "Please choose start time minute"
//    static let endTimeHourError:String          = "Please choose end time hour"
//    static let endTimeMinuteError:String        = "Please choose end time minute"
//
//    // ----- Api Success Message -----
//
//    static let attendenceAddSuccess:String         = "Attendance added successfully."
//    static let attendenceUpdateSuccess:String      = "Attendance updated successfully."
//    static let subjectAddSuccess:String            = "Subjects added successfully."
//    static let testAddSuccess:String               = "Test added successfully."
//    static let testUpdateSuccess:String            = "Test updated successfully."
//    static let requestSentSuccess:String           = "Request sent successfully."
//    static let homeworkStatusAddSuccess:String     = "HomeWork status added successfully."
//    static let homeworkStatusUpdateSuccess:String  = "HomeWork status updated successfully."
//    static let leaveDeleteSuccess:String           = "Leave deleted successfully."
//    static let hwCwSuccess:String                  = "HomeWork/ClassWork added successfully."
//
//    // ----- Api Failure Message -----
//
//    static let timeOutError:String                 = "Please try again later."
//    static let internetFailure:String              = "Network unavailable. \(timeOutError)"
//    static let serverError:String                  = "Oops, Skool360 Bhadaj server is down keep calm and try after sometime. Thank you!"
//    static let failure:String                      = "Something went wrong."
//    static let noRecordFound:String                = "No records are found."
//    static let noClassDetailFound:String           = "No class details are found."
//    static let noHWFound:String                    = "Please add home work then update status."
//    static let cwNotFound:String                   = "Please add classwork"
//    static let noSectionSelect:String              = "Please select any one section"
//    static let noGradeSelect:String                = "Please select any grade"
//    static let noSubjectSelect:String              = "Please select any subject"
//
//    // ----- Updation Message -----
//
    static let appUpdateTitle:String               = "Update Available"
    static let appUpdateMsg:String                 = "A new version of {} is available. Please update to version () now."
//
//    // ----- Logout Message -----
//
//    static let logOutMsg:String                    = "Are you sure you want to logout?"
//    static let statusUpdate:String                 = "Are you sure you want to update status?"
//    static let deleteLeave:String                  = "Are you sure you want to delete leave?"
//}

//struct FontType {
//
//    static let regularFont:UIFont      = FontHelper.regular(size: DeviceType.isIpad ? 16 : 13)
//    static let mediumFont:UIFont       = FontHelper.medium(size: DeviceType.isIpad ? 16 : 13)
//    static let boldFont:UIFont         = FontHelper.bold(size: DeviceType.isIpad ? 16 : 13)
//}
//
//struct DeviceType {
//
//    static let isIphone5:Bool          = { return UIScreen.main.bounds.size.width <= 320 }()
//    static let isIpad                  = UIDevice.current.userInterfaceIdiom == .pad
}
//
struct GetColor {
    
    static var headerColor:UIColor              = UIColor.rbg(r: 248, g: 150, b: 36)
    static var shadowColor:UIColor              = UIColor.clear.withAlphaComponent(0.2)
    static var blue:UIColor                     = UIColor.rbg(r: 23, g: 145, b: 216)
    static var green:UIColor                    = UIColor.rbg(r: 107, g: 174, b: 24)
    static var red:UIColor                      = UIColor.rbg(r: 255, g: 0, b: 0)
    static var orange:UIColor                   = GetColor.headerColor
    static var yellow:UIColor                   = UIColor.rbg(r: 216, g: 184, b: 52)
    static var pink:UIColor                     = UIColor.rbg(r: 246, g: 68, b: 141)
    static var seaGreen:UIColor                 = UIColor(rgb: 0x00B7C5) //UIColor.rbg(r: 246, g: 68, b: 141)
    static var themeBlueColor:UIColor           = UIColor(rgb: 0x3EA7E0)
    static var blueHeaderText:UIColor           = UIColor(rgb: 0x0077DF) // Blue
    static var blueHeaderBg:UIColor             = UIColor(rgb: 0xF7FCFF)
    static var signInText:UIColor               = GetColor.themeBlueColor//UIColor(rgb: 0x82C0E5)
    static var lightGray:UIColor                = UIColor(rgb: 0x1B91EF)
    static var lightGrayInnerStart:UIColor                = UIColor(rgb: 0xA3A3A3)




    static var SagmentDefaultColor:UIColor      = UIColor(rgb: 0x464A59)
    static var darkGray:UIColor                 = UIColor(rgb: 0x585858)
    static var darkGreen:UIColor                = UIColor(rgb: 0x009115)//00FF00)
    static var tomatoRed:UIColor                = UIColor(rgb: 0xff5546)

    static var dotColorCurrent:UIColor          = UIColor(rgb: 0x3EA7E0)
    static var dotColorAnswered:UIColor         = UIColor(rgb: 0x81A817)//.rbg(r: 216, g: 184, b: 52) // 81A817
    static var dotColorUnAnswered:UIColor       = UIColor(rgb: 0xEE6B60)//.rbg(r: 255, g: 0, b: 0) // EE6B60
    static var dotColorReviewLater:UIColor      = UIColor(rgb: 0xDFCB58)//UIColor(rgb: 0x61D397)//.rbg(r: 107, g: 174, b: 24) // 61D397
    static var dotColorNotVisited:UIColor       = UIColor(rgb: 0xEAEAEA)
    static var dotColorGray:UIColor             = UIColor(rgb: 0x5C5C5C)
    static var dotColorWhite:UIColor            = UIColor(rgb: 0xFFFFFF)
    static var ColorGrayF5F5F5:UIColor          = UIColor(rgb: 0xF5F5F5)

    static var successPopupGreenColor:UIColor   = UIColor(rgb: 0x1B91EF)
    static var successPopupPinkColor:UIColor    = UIColor(rgb: 0xF53F85)
    static var dark_green:UIColor               = UIColor(rgb: 0x47841F)
    static var lightGray1:UIColor               = UIColor(rgb: 0x808080)
    static var whiteColor:UIColor               = UIColor(rgb: 0xFFFFFE)
    static var blackColor:UIColor               = UIColor(rgb: 0x000001)
    static var SectionColor:UIColor             = UIColor(rgb: 0xEFEFEF)
    static var LightYellowColor:UIColor               = UIColor(rgb: 0xFDFCDC)
    static var borderColorPayment:UIColor               =  UIColor.rbg(r: 27, g: 145, b: 239)

}
 func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text

    label.sizeToFit()
    return label.frame.height
}
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
//        if <#condition#> {
//
//        }
        return NetworkReachabilityManager()!.isReachable
    }
}

//struct FontHelper {
//    static func regular(size: CGFloat) -> UIFont {
//        return UIFont(name: "HelveticaNeue", size: size)!
//    }
//
//    static func medium(size: CGFloat) -> UIFont {
//        return UIFont(name: "HelveticaNeue-Medium", size: size)!
//    }
//
//    static func bold(size: CGFloat) -> UIFont {
//        return UIFont(name: "HelveticaNeue-Bold", size: size)!
//    }
//}

//// MARK: - Store Data
//
//var staffID: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "StaffID") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "StaffID")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var newHostUrl: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "HostUrl") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "HostUrl")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var locationID: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "LocationID") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "LocationID")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var birthDate: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "DOB") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "DOB")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var birthdayWiseDone: Bool?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "BirthdayWish") as? Bool {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "BirthdayWish")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//var deviceToken: String?
//{
//    get {
//        if let returnValue = UserDefaults.standard
//            .object(forKey: "DeviceToken") as? String {
//            return returnValue
//        } else {
//            return nil //Default value
//        }
//    }
//    set {
//        UserDefaults.standard.set(newValue, forKey: "DeviceToken")
//        UserDefaults.standard.synchronize()
//    }
//}
//
//// MARK: - Functions
//
//func addBorder(_ obj:AnyObject)
//{
//    obj.layer.cornerRadius = 5.0
//    obj.layer.borderColor  = GetColor.blue.cgColor
//    obj.layer.borderWidth  = 0.5
//}
//
func add(asChildViewController viewController: UIViewController, _ selfVC:UIViewController) {
    
    selfVC.addChild(viewController)
    selfVC.view.addSubview(viewController.view)
    viewController.view.frame = selfVC.view.bounds
    viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    viewController.didMove(toParent: selfVC)
}
var isGotoDashBoard = ""

func BackToDashbord(VC: UIViewController){
    isGotoDashBoard = ""
    for controller in VC.navigationController!.viewControllers as Array {
        //Bhargav Hide
////print(controller)
//        if controller.isKind(of: DashboardVC.self) {
//            VC.navigationController!.popToViewController(controller, animated: false)
////            break
//        }
    }
}

//
//// MARK: - Class
//
//class CustomButton: UIButton {
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//}
//
//class SquareButton: UIButton {
//
//    override func awakeFromNib() {
//        addBorder(self)
//    }
//}
//
//class ShadowButton: UIButton {
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//
//    override func awakeFromNib() {
//        self.addShadowWithRadiusForButton(3, 0)
//    }
//}
//
//class AnimatedButton: TransitionButton {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = GetColor.blue
//        self.setTitle("LOGIN", for: .normal)
//        self.setTitleColor(.white, for: .normal)
//        self.titleLabel?.font = FontHelper.bold(size: 16)
//        self.cornerRadius = 5.0
//        self.spinnerColor = .white
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class CustomImageView: UIImageView {
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//}
//
//class PlaceHolderImageView: UIImageView {
//
//    @IBInspectable open var strImageName: String!
//
//    override func awakeFromNib() {
//        self.image = UIImage.init(named: strImageName)?.withRenderingMode(.alwaysTemplate)
//    }
//}
//
//class RoundedImageView: UIImageView {
//
//    @IBInspectable open var borderColor: UIColor = UIColor.white {
//        didSet {
//            self.layer.borderColor  = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable open var strImageName: String = "" {
//        didSet {
//            self.loadIconsFromLocal(strImageName)
//        }
//    }
//
//    override func awakeFromNib() {
//        self.layer.cornerRadius = self.frame.size.width/2
//        self.clipsToBounds      = true
//        self.layer.borderWidth  = 2.0
//    }
//}
//
//class CustomTextView: UITextView {
//
//    override func awakeFromNib() {
//        addBorder(self)
//    }
//}
//
//class CustomTextField: UITextField {
//
//    override func awakeFromNib() {
//        addBorder(self)
//    }
//}
//
//class ErrorVC: UIViewController {
//
//    override func viewDidLoad() {
//
//    }
//}

//class CustomLable: UILabel {
//
//    @IBInspectable var topInset: CGFloat = 5.0
//    @IBInspectable var bottomInset: CGFloat = 5.0
//    @IBInspectable var leftInset: CGFloat = 5.0
//    @IBInspectable var rightInset: CGFloat = 5.0
//
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
//    }
//
//    override var intrinsicContentSize: CGSize {
//        get {
//            var contentSize = super.intrinsicContentSize
//            contentSize.height += topInset + bottomInset
//            contentSize.width += leftInset + rightInset
//            return contentSize
//        }
//    }
//
//    override func awakeFromNib() {
//        self.layer.cornerRadius = 3.0
//        self.clipsToBounds      = true
//
//        self.layer.borderColor  = UIColor.lightGray.withAlphaComponent(0.5).cgColor
//        self.layer.borderWidth  = 0.5
//    }
//}
//
//class HeaderView: UIView {
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubview(loadViewFromNib())
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        addSubview(loadViewFromNib())
//    }
//
//    private func loadViewFromNib() -> UIView {
//        let headerView:UIView = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//        headerView.frame = self.bounds
//        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        headerView.addShadowWithRadius(2, 0)
//        return headerView
//    }
//}

//var isFromPTM:Bool = false
//class CustomViewController: UIViewController {
//    var arrStandards:[String] = []
////    var strStdID:String!
//    let dicStandards:NSMutableDictionary = [:]
//
//    var selectedIndex:NSInteger = -1
//    var btnDate:UIButton!
//    var finishedLoadingInitialTableCells = false
//
//    override func viewDidAppear(_ animated: Bool) {
//        isFromPTM = false
//        self.initalization()
//    }
//
//    func initalization()
//    {
//        if(!(self is DeshboardVC)) {
//            (self.view.subviews[0].subviews[0].subviews[0] as! UIButton).setTitle(self.title?.uppercased(), for: .normal)
//            (self.view.subviews[0].subviews[0].subviews[1] as! UIButton).addTarget(self, action: #selector(logOut), for: .touchUpInside)
//            (self.view.subviews[0].subviews[0].subviews[2] as! UIButton).addTarget(self, action: #selector(back), for: .touchUpInside)
//        }
//    }
//
//    @IBAction func logOut()
//    {
//        Functions.showCustomAlert("Logout", Message.logOutMsg) { (_) in
//            let params = ["StaffID" : staffID!,
//                          "DeviceID" : UIDevice.current.identifierForVendor!.uuidString]
//
//            Functions.callApi(vc: self, api: API.deleteDeviceDetailStaffApi, params: params) { (json,error) in
//                if(json != nil){
//                    Constants.appDelegate.registerForPushNotification(false)
//                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
//                    Constants.appDelegate.rootViewController("ViewController")
//                }
//            }
//        }
//    }
//
//    //    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell:
//    //        UITableViewCell, forRowAt indexPath: IndexPath) {
//    //        let rotationAngleInRadians = 360.0 * CGFloat(M_PI/360.0)
//    //        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, -500, 100, 0)
//    ////        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
//    //        cell.layer.transform = rotationTransform
//    //        UIView.animate(withDuration: 1.0, animations: {cell.layer.transform = CATransform3DIdentity})
//    //    }
//
//    //    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    //    {
//    //        //1. Setup the CATransform3D structure
//    //        var rotation = CATransform3DMakeRotation( CGFloat((90.0 * M_PI)/180), 0.0, 0.7, 0.4);
//    //        rotation.m34 = 1.0 / -600
//    //
//    //
//    //        //2. Define the initial state (Before the animation)
//    //        cell.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
//    //        cell.alpha = 0;
//    //
//    //        cell.layer.transform = rotation;
//    //        cell.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
//    //
//    //
//    //        //3. Define the final state (After the animation) and commit the animation
//    //        cell.layer.transform = rotation
//    //        UIView.animate(withDuration: 0.8, animations:{cell.layer.transform = CATransform3DIdentity})
//    //        cell.alpha = 1
//    //        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//    //        UIView.commitAnimations()
//    //
//    //    }
//
//    //    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    //        //if (shownIndexes.contains(indexPath) == false) {
//    //            //shownIndexes.append(indexPath)
//    //
//    ////            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//    ////            cell.layer.shadowColor = UIColor.black.cgColor
//    ////            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
//    ////            cell.alpha = 0
//    ////
//    ////            UIView.beginAnimations("rotation", context: nil)
//    ////            UIView.setAnimationDuration(0.5)
//    ////            cell.transform = CGAffineTransform(translationX: 0, y: 0)
//    ////            cell.alpha = 1
//    ////            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//    ////            UIView.commitAnimations()
//    //        //}
//    //
//    //        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//    //        UIView.animate(withDuration: 0.3, animations: {
//    //            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//    //        },completion: { finished in
//    //            UIView.animate(withDuration: 0.1, animations: {
//    //                cell.layer.transform = CATransform3DMakeScale(1,1,1)
//    //            })
//    //        })
//    //    }
//
//    @IBAction func back()
//    {
//        if (self is AddDailyWorkVC)
//        {
//////                self.navigationController?.pushPopTransition(controller,false)
//////                self.navigationController?.pushPopTransition(Constants.storyBoard.instantiateViewController(withIdentifier: "DailyWorkVC"),true)
////                self.performSegue(withIdentifier: "DailyWorkVC", sender: self)
////
//////                break
////            var viewController:DailyWorkVC = Constants.storyBoard.instantiateViewController(withIdentifier: "DailyWorkVC") as! DailyWorkVC
////            viewController.title = "Daily Work"
////
////            add(asChildViewController: viewController, self)
////            return viewController
//            guard parent != nil else { return }
//
//            willMove(toParentViewController: nil)
//            removeFromParentViewController()
//            view.removeFromSuperview()
//
//            }
//            else
//            {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
////    }
//}

//// MARK: - Extensions
//
//extension String {
//    func isValidEmail() -> Bool {
//        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count)) != nil
//    }
//
//    func toDate( dateFormat format  : String) -> Date
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        if let date = dateFormatter.date(from: self)
//        {
//            return date
//        }
//        return Date()
//    }
//
//    func removeHtmlFromString(inPutString: String) -> String{
//        var str:String = inPutString
//        str = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//        str = str.replacingOccurrences(of: "&nbsp;", with: "")
//        return str.components(separatedBy: .whitespacesAndNewlines).joined()
//    }
//
//    func stringFromHTML(_ string: String?) -> NSAttributedString?
//    {
//        guard let data = data(using: .utf8) else { return NSAttributedString() }
//        do{
//            let attrStr:NSAttributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
//
//            let newStr:NSMutableAttributedString = attrStr.mutableCopy() as! NSMutableAttributedString
//
//            var range:NSRange = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines)
//
//            // Trim leading characters from character set.
//            while range.length != 0 && range.location == 0 {
//                newStr.replaceCharacters(in: range, with: "")
//                range = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines)
//            }
//
//            // Trim trailing characters from character set.
//            range = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines, options: .backwards)
//            while range.length != 0 && NSMaxRange(range) == newStr.length {
//                newStr.replaceCharacters(in: range, with: "")
//                range = (newStr.string as NSString).rangeOfCharacter(from: .whitespacesAndNewlines, options: .backwards)
//            }
//            return NSAttributedString.init(attributedString: newStr)
//        } catch
//        {
//            //Bhargav Hide
////print("html error\n",error)
//        }
//        return nil
//    }
//}
//
//extension NSMutableDictionary {
//    func sortedDictionary(_ dict:NSMutableDictionary)->([String],[String]) {
//
//        let values = (dict.allKeys as! [String]).sorted {
//            (s1, s2) -> Bool in return s1.localizedStandardCompare(s2) == .orderedAscending
//        }
//
//        var sortedArray:[String] = []
//        for item in values {
//            sortedArray.append(item.components(separatedBy: "-").last!)
//        }
//        return (values, sortedArray)
//    }
//
//    func keyedOrValueExist(key: Key) -> Value? {
//        return self[key] ?? nil
//    }
//}
//
//extension Date {
//    func toString( dateFormat format  : String ) -> String
//    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: self)
//    }
//}
//
//extension UIColor {
//    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
//        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
//        return color
//    }
//}
//
extension String {
    var withoutHtmlTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options:
            .regularExpression, range: nil).replacingOccurrences(of: "&[^;]+;", with:
                "", options:.regularExpression, range: nil)
    }
}
//extension UIView {
//    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//
//        self.layer.mask = mask
//    }
//}

extension UIView {
    //    func shake() {
    //        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    //        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    //        animation.duration = 0.6
    //        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    //        layer.add(animation, forKey: "shake")
    //    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addShadowWithRadius(_ sRadius:CGFloat, _ cRadius:CGFloat, _ bRadius:CGFloat, color: UIColor)
    {
        if cRadius > 0 {
            self.layer.cornerRadius = cRadius
        }
        if bRadius > 0 {
            //            self.layer.borderColor  = UIColor.lightGray.cgColor
            self.layer.borderColor  = color.cgColor
            
            self.layer.borderWidth  = bRadius
        }
        
        self.layer.shadowColor = GetColor.shadowColor.cgColor
        self.layer.shadowRadius = sRadius
        self.layer.shadowOffset = CGSize(width:0.0,height:sRadius)
        self.layer.shadowOpacity = 1.0
    }
    
    func addGradiantColor( first_color: UIColor, color: UIColor)
    {
        let gradient = CAGradientLayer()
        gradient.frame = self.frame
        gradient.colors = [first_color.cgColor, first_color.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
//
//}
//
//extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
}

//
extension UIButton {
    func makeSemiCircle(){
        let circlePath = UIBezierPath.init(arcCenter: CGPoint(x:self.bounds.size.width / 2, y:0), radius: self.bounds.size.height, startAngle: 0.0, endAngle: 180, clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        self.layer.mask = circleShape
    }
    
    //    func addShadowWithRadiusForButton(_ qty:CGFloat, _ radius:CGFloat, color: UIColor)
    //    {
    //        self.addShadowWithRadius(qty, radius, <#CGFloat#>, color: color)
    //    }
    
    //    func loadIconsFromLocal(_ iconName:String)
    //    {
    //        let fileURL = Constants.documentsDirectoryURL.appendingPathComponent("\(iconName).png")
    //
    //        if FileManager.default.fileExists(atPath: fileURL.path) {
    //            self.setImage(UIImage.init(contentsOfFile: fileURL.path), for: .normal)
    //            return
    //        }
    //
    //        let url:URL = URL.init(string: "\(API.iconsLinkUrl)\(iconName).png")!
    //
    //        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    //
    //        Alamofire.download(
    //            url,
    //            method: .get,
    //            parameters: nil,
    //            encoding: JSONEncoding.default,
    //            headers: nil,
    //            to: destination).downloadProgress(closure: { (progress) in
    //
    //            }).response { response in
    //
    //                if let localURL = response.destinationURL {
    //                    //Bhargav Hide
////print(localURL)
    //                    self.setImage(UIImage.init(contentsOfFile: localURL.path), for: .normal)
    //                }
    //        }
    //    }
}
//
extension UIImageView {
//    public func setImageWithFadeFromURL(url: URL, placeholderImage placeholder: UIImage? = nil, animationDuration: Double = 0.3, finish:@escaping ()->Void) {
//
//        self.sd_setImage(with: url, placeholderImage: placeholder, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
//            if error != nil {
//                //Bhargav Hide
//////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
//                self.image = placeholder
//                return
//            }
//            self.alpha = 0
//            self.image = fetchedImage
//            UIView.transition(with: self, duration: (cacheType == .none ? animationDuration : 0), options: .transitionCrossDissolve, animations: { () -> Void in
//                self.alpha = 1
//            }, completion: { (finished: Bool) in
//                //                finish
//            })
//        }
//    }
    
//    public func cancelImageLoad() {
//        self.sd_cancelCurrentImageLoad()
//    }
    
    //    func getImagesfromLocal(_ strImageName:String)
    //    {
    //        let strNewImageName:String = "\(strImageName.replacingOccurrences(of: "/", with: "_")).png"
    //
    //        let fileURL = Constants.documentsDirectoryURL.appendingPathComponent("\(strNewImageName)")
    //
    //        if FileManager.default.fileExists(atPath: fileURL.path) {
    //            //Bhargav Hide
////print("Image Is there")
    //            self.image = UIImage.init(contentsOfFile: fileURL.path)
    //        }else{
    //            self.storeImages(fileURL,strNewImageName)
    //        }
    //    }
    //
    //    func storeImages(_ imageUrl:URL ,_ imageName:String)
    //    {
    //        let strImageLink:String = "\(API.imagesLinkUrl)\(imageName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
    //
    //        self.sd_setImage(with: URL.init(string: strImageLink), completed: { (fetchedImage, error, _, _) in
    //
    //            if(error != nil){
    //                return
    //            }
    //
    //            do {
    //                try UIImagePNGRepresentation(fetchedImage!)!.write(to: imageUrl)
    //                //Bhargav Hide
////print("Image added successfully")
    //            } catch {
    //                //Bhargav Hide
////print(error)
    //            }
    //        })
    //    }
    
    //    func loadIconsFromLocal(_ iconName:String)
    //    {
    //        let fileURL = Constants.documentsDirectoryURL.appendingPathComponent("\(iconName).png")
    //
    //        if FileManager.default.fileExists(atPath: fileURL.path) {
    //            self.image = UIImage.init(contentsOfFile: fileURL.path)
    //            return
    //        }
    //
    //        let url:URL = URL.init(string: "\(API.iconsLinkUrl)\(iconName).png")!
    //
    //        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
    //
    //        Alamofire.download(
    //            url,
    //            method: .get,
    //            parameters: nil,
    //            encoding: JSONEncoding.default,
    //            headers: nil,
    //            to: destination).downloadProgress(closure: { (progress) in
    //
    //            }).response { response in
    //
    //                if let localURL = response.destinationURL {
    //                    //Bhargav Hide
////print(localURL)
    //                    self.image = UIImage.init(contentsOfFile: localURL.path)
    //                }
    //        }
    //    }
}

////let sharedAlert = AlertPopupInternet()
//extension Notification.Name {
//      static let postNotifi = Notification.Name("AlertPopupInternet")
//}

extension UIViewController {


    func AlertPopupInternet() {
        let alert = UIAlertController(title: "No Internet connection", message: "Please check your internet connection and try again", preferredStyle: .alert)
//        let imageView = UIImageView(frame: CGRect(x: 60, y: 80, width: 150, height: 150))
//        imageView.image = UIImage(named: "AppIcon") // Your image here...
//        imageView.contentMode = .scaleAspectFit
//        imageView.roundCorners(corners: .allCorners, radius: 30)
//        alert.view.addSubview(imageView)
////        imageView.translatesAutoresizingMaskIntoConstraints = false
//        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
//        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
//        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 260.0))
//        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 290.0))

//        let height = NSLayoutConstraint(item: alert.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 290)
//        let width = NSLayoutConstraint(item: alert.view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 260)
//        alert.view.addConstraint(height)
//        alert.view.addConstraint(width)

        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                                        switch action.style{
                                        case .default:

                                            self.viewWillAppear(true)
                                        case .cancel:
                                            print("cancel")

                                        case .destructive:
                                            print("destructive")

                                        //                @unknown default:
                                        //                    print("destructive")
                                        }}))
        self.navigationController?.present(alert, animated: true, completion: nil)
//        self.window?.rootViewController?.present(alert, animated: true, completion: nil)


    }

    func api_Activity_Action(Type:String, gameid:String, gamesessionid:String, actionid:String, comment:String, isFirstTime:String)
    {

        let params = ["Type":Type, "gameid":gameid, "gamesessionid":gamesessionid, "actionid":actionid,"comment":comment]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_Activity_ActionApi,params)

        Alamofire.request(API.Get_Activity_ActionApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            //            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                                print("\(API.Get_Activity_ActionApi) : ",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let jsonArray = "\(json["data"])"//[0].dictionaryObject!
                    //                    print("json",json)//TrackTokenID
                    if isFirstTime == "1"
                    {UserDefaults.standard.set(jsonArray, forKey: "TrackTokenID")}
                    if UserDefaults.standard.object(forKey: "FistInstall") == nil{
                        self.api_Activity_Action(Type: "1", gameid: API.strGameID, gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "100", comment: "ios_App Install", isFirstTime: "0")
                        UserDefaults.standard.set("true", forKey: "FistInstall")
                        print("FistInstall")
                    }else{
                        print("Not FistInstall")
        //                rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "100", comment: "ios_App Install", isFirstTime: "0")
                    }
                }
                else
                {
                    //                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                print("",error)

            //                self.view.makeToast("Somthing wrong....", duration: 3.0, position: .bottom)
            }
        }
    }
    func api_Send_Token()
    {
        //        showActivityIndicator()
        var param = ["":""]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {

            // && ((UserDefaults.standard.object(forKey: "DeviceToken")) != nil)
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            //            param = ["StudentID":"\(result["StudentID"] ?? "")","TokenID":"\(UserDefaults.standard.object(forKey: "DeviceToken") ?? "")"]    // APNs
            param = ["StudentID":"\(result["StudentID"] ?? "")","TokenID":"\(UserDefaults.standard.object(forKey: "fcmToken") ?? "")", "deviceid":"1"] //FCM
        }
        else
        {
            print("Token Not ganrete.")
            return
        }

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Add_Student_TokenApi,param)

        Alamofire.request(API.Add_Student_TokenApi, method: .post, parameters: param, headers: headers).validate().responseJSON { response in
            //            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print("\(API.Add_Student_TokenApi) : ",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    //                    let jsonArray = "\(json["data"])"//[0].dictionaryObject!
                    //                    print("json",json)//TrackTokenID
                    //                    if isFirstTime == "1"
                    //                    {UserDefaults.standard.set(jsonArray, forKey: "TrackTokenID")}
                }
                else
                {
                    //                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                print("",error)

            //                self.view.makeToast("Somthing wrong....", duration: 3.0, position: .bottom)
            }
        }
    }

    //        func Get_Coin_API() -> String
    //        {
    //            //        showActivityIndicator()
    //            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
    //
    //            let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
    //            let headers = [
    //                "Content-Type": "application/x-www-form-urlencoded"
    //            ]
    //            //Bhargav Hide
    //
    ////Get_MyCoin_Api
    ////Get_CoinList_Api
    ////Get_purchase_Api
    //
    //            print("API, Params: \n",API.Get_MyCoin_Api,params)
    //
    //            Alamofire.request(API.Get_MyCoin_Api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
    //    //            self.hideActivityIndicator()
    //
    //                switch response.result {
    //                case .success(let value):
    //
    //                    let json = JSON(value)
    //                    //Bhargav Hide
    //                    print("\(API.Get_Activity_ActionApi) : ",json)
    //
    //                    if(json["Status"] == "true" || json["Status"] == "1") {
    //                        let jsonArray = "\(json["data"])"//[0].dictionaryObject!
    //    //                    print("json",json)//TrackTokenID
    //                        strMyCoin = "\(jsonArray)"
    //                    }
    //                    else
    //                    {
    //                        self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
    //                    }
    ////                    return strMyCoin
    //
    //                case .failure(let error):
    //                    print("",error)
    ////                    return strMyCoin
    //                    self.view.makeToast("Somthing wrong....", duration: 3.0, position: .bottom)
    //                }
    ////                return strMyCoin
    //            }
    //            return strMyCoin
    //        }
    func Get_Coin_Globle_API()
    {
        //        showActivityIndicator()
       // let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params = ["StudentID":"14395"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_MyCoin_Api,params)

        Alamofire.request(API.Get_MyCoin_Api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            //            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print("\(API.Get_Activity_ActionApi) : ",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let jsonArray = "\(json["data"])"//[0].dictionaryObject!
                    //                    print("json",json)//TrackTokenID
                    strMyCoin = "\(jsonArray)"
                }
                else
                {
                    //  self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                print("Somthing wrong....",error)
            //      return strMyCoin
            //      self.view.makeToast("Somthing wrong....", duration: 3.0, position: .bottom)
            }
            //      return strMyCoin
        }
        //  return strMyCoin
    }

//    func requestTrackingPermission() {
////        if #available(iOS 14, *) {
//            Settings.isAutoLogAppEventsEnabled = true
//////            ATTrackingManager.requestTrackingAuthorization { (status) in
//////                switch status {
//////                    case .authorized:
//////                        Settings.setadve//setAdvertiserTrackingEnabled(true)  //Cannot find 'FBAdSettings' in scope
//////                    ...
//////                }
//////            }
////        } else {
////            // Fallback on earlier versions
////        }
//    }

    func logFBEvent(Event_Name:String, device_Name: String, valueToSum: Double)
    {
        let parameters = [
            AppEvents.ParameterName("Device_Name").rawValue: device_Name
        ]
        print("Custom Event_Name:\(Event_Name)\nValueToSum:\(valueToSum)\nparameters:\(parameters)")
        AppEvents.logEvent(.init("\(Event_Name)"), valueToSum: valueToSum, parameters: parameters)
//        AppEvents.l
    }
}

//extension UIViewController {
//    func getDynamicFont()
//    {
//        var font:CGFont!
//        var error: Unmanaged<CFError>?
//        var success:Bool = false
//
//        for fontName in Constants.FontNameArray {
//
//            //let strFontName:String = "\(fontName).ttf"
//            let url:URL = URL.init(string: "\(API.fontLinkUrl)\(fontName)")!
//            let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//
//            Alamofire.download(
//                url,
//                method: .get,
//                parameters: nil,
//                encoding: JSONEncoding.default,
//                headers: nil,
//                to: destination).downloadProgress(closure: { (progress) in
//
//                }).response { response in
//
//                    if let localURL = response.destinationURL {
//                        ////Bhargav Hide
////print(localURL)
//
//                        let data = try? Data(contentsOf: localURL)
//                        font = CGFont(CGDataProvider(data: data! as CFData)!)
//
//                        success = CTFontManagerRegisterGraphicsFont(font, &error)
//                        if !success {
//                            //Bhargav Hide
////print("Error loading font. Font is possibly already registered.")
//                        }
//                    }
//            }
//        }
//    }
//}
//
//extension UICollectionViewCell {
//    func scaleWithBounceAnimation(){
//        self.transform = CGAffineTransform(scaleX: 0, y: 0)
//        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(rawValue: 0), animations: {
//            self.transform = CGAffineTransform.identity
//        })
//    }
//}
//
//extension Notification.Name {
//    static let refreshData          = Notification.Name(
//        rawValue: "refreshData")
//}
//
//
// MARK: - Enums
//
//enum ErrorType {
//    case userName, password, confirmPassword
//    case subject, description
//}
//
enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

import CoreTelephony

class NetworkManager:UIViewController {

    //shared instance
    static let shared = NetworkManager()
    var strStatus = ""
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    var window: UIWindow?
    var strMsgDisplay = ""

    func startNetworkReachabilityObserver() {
        self.checkNetworkTimer.invalidate()

        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
                self.strStatus = "notReachable"
                if self.strMsgDisplay == "no"
                {
                }
                else
                {
                    let alert = UIAlertController(title: "Alert", message: "The network is not reachable", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                    switch action.style{
                                                    case .default:
                                                        print("default")
                                                        //                                                        self.viewWillAppear(true)
                                                        if var topController = UIApplication.shared.keyWindow?.rootViewController {
                                                            while let presentedViewController = topController.presentedViewController {
                                                                topController = presentedViewController
                                                            }
                                                            // topController should now be your topmost view controller
                                                            topController.viewWillAppear(true)
                                                            print("current vc _____",topController)
                                                        }
                                                    //self.window?.rootViewController?.viewWillAppear(true)
                                                    case .cancel:
                                                        print("cancel")

                                                    case .destructive:
                                                        print("destructive")

                                                    //                @unknown default:
                                                    //                    print("destructive")
                                                    }}))
                    //                self.navigationController.present(alert, animated: true, completion: nil)
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
                }
            case .unknown :
                print("It is unknown whether the network is reachable")
                self.strStatus = "notReachable"

            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                self.strStatus = "ethernetOrWiFi"

            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                self.strStatus = "wwan"
                self.checkNetworkTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.checkNetwork), userInfo: nil, repeats: true)
            //            activeTimer = Timer.scheduledTimer(timeInterval: durationTime, target: self, selector: #selector(self.slideImage), userInfo: nil, repeats: true)

            //Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: Selector(("checkNetwork")), userInfo: nil, repeats: true)
            //{
            //
            //}
            }
        }

        // start listening
        reachabilityManager?.startListening()
    }
    var checkNetworkTimer = Timer()


    @objc func checkNetwork()
    {
        NSLog("Celluler Network Metho Start....")
        let networkInfo = CTTelephonyNetworkInfo()
        let networkString = networkInfo.currentRadioAccessTechnology ?? ""
        let tecnology = RadioAccessTechnology(rawValue: networkString)
        print("strStatus...........................................",tecnology?.description ?? "")
        print(tecnology?.description ?? "")
        if tecnology?.description == strcellulerNetworkGloble//strSelectedNetwork == NetworkManager.shared.strStatus
        {}
        else
        {
            if tecnology?.description == "2G"
            {
                strcellulerNetworkGloble = "2G"
                // timer.invalidate()
                self.window?.rootViewController?.view.makeToast("The internet connection is very poor..", duration: 3.0, position: .bottom)
            }
            else if tecnology?.description == "3G"
            {
                strcellulerNetworkGloble = "3G"
                // timer.invalidate()
                self.window?.rootViewController?.view.makeToast("The internet connection is slow.. ", duration: 3.0, position: .bottom)
            }
            else if tecnology?.description == "4G"
            {
                strcellulerNetworkGloble = "4G"
            }
            else
            {
                strcellulerNetworkGloble = ""
            }
        }
    }
}

extension UINavigationController {
    func pushPopTransition(_ pushPopVC:UIViewController, _ isPush:Bool) {
        let transition = CATransition()
        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transition.type = kCATransitionMoveIn
        //        switch arc4random()%4 {
        //        case 0:
        //            transition.subtype = kCATransitionFromTop
        //        case 1:
        //            transition.subtype = kCATransitionFromBottom
        //        case 2:
        //        default:
        //        }
        if isPush {
//            transition.subtype = kCATransitionFromLeft
            self.view.layer.add(transition, forKey: nil)
            self.pushViewController(pushPopVC, animated: false)
        }else{
//            transition.subtype = kCATransitionFromRight
            self.view.layer.add(transition, forKey: nil)
            self.popToViewController(pushPopVC, animated: false)
        }
    }
}
