//
//  DashboardVC.swift
//  TestCraft
//
//  Created by ADMS on 17/06/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage

class DashboardVC: UIViewController , ActivityIndicatorPresenter {

    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var tblDashbord:UITableView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblPath:UILabel!
    var strDisplayMsg = ""
    var arrMyPackageList = [getSubscriptionModel]()

    @IBOutlet var btnAddNewPackage:UIButton!
    @IBOutlet var viewPlaceHolderScreen:UIView!

    @IBOutlet var viewDashboardLogin:UIView!
    @IBOutlet var btnLogin:UIButton!


    var temp_Order_ID = ""
    var temp_PaymentTransaction_ID = ""
    var IsFree = ""

    var strPrice = ""
    var strListPrice = ""

//    var arrDashbord = [String]()
//    var arrDashbord_img = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogin.layer.cornerRadius = 6.0
        btnLogin.layer.masksToBounds = true

        btnLogin.layer.borderColor = GetColor.lightGray.cgColor
        btnLogin.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
        lblTitle.text = "Dashboard"
//        arrDashbord = ["Single Test", "Test Packages", "Tutors"]
//        arrDashbord_img = ["Astronomy.png", "Astronomy.png", "Astronomy.png"]

        tblDashbord.reloadData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UINavigationBar.appearance().barTintColor = UIColor.green
//        UIBarButtonItem.appearance().tintColor = UIColor.red

        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                viewDashboardLogin.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
        //        lblTitle.text = "" //+ arrPath.joined(separator:",")
                strDisplayMsg = ""


//                if  UserDefaults.standard.bool(forKey:"isFirstTimeShow") == true{
//                    Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(FirstTimeBoardId)", StandardID: "\(FirstTimeStandardId)", TypeID: "\(FirstTimeCourseTypeID)")
//                }else{
                    apiMyPackages()
               // }
                
              //
                isGotoDashBoard = ""
                btnAddNewPackage.addShadowWithRadius(5,12,0,color: UIColor.lightGray)
                api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "810", comment: "Dashboard", isFirstTime: "0")
            }
        }else{
            self.tabBarController?.tabBar.isHidden = false
            viewDashboardLogin.isHidden = false
            self.btnLogin.isHidden = false
        }
    }
    @IBAction func filterClicked(_ sender: UIButton) {
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterVC") as? FilterVC
//                self.navigationController?.pushViewController(vc!, animated: true)
    }

    @IBAction func BackClicked(_ sender: AnyObject) {
//        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.view.removeFromSuperview()

//        for controller in self.navigationController!.viewControllers as Array {
//            //Bhargav Hide
////print(controller)
////            if controller.isKind(of: YourPreferencesVC.self) {
////                self.navigationController!.popToViewController(controller, animated: true)
////
////                break
////            }
//        }
    }
    @IBAction func btnLoginClick(_ sender: AnyObject) {
        //viewDashboardLogin.isHidden
        viewDashboardLogin.isHidden = true

       // let appDelegate = UIApplication.shared.delegate as? AppDelegate

                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroVC") as UIViewController
         rootVC.logFBEvent(Event_Name: "Facebook_user_install", device_Name: "iOS", valueToSum: 1)
         if ((UserDefaults.standard.value(forKey: "TrackTokenID")) == nil)
         {
             rootVC.api_Activity_Action(Type: "0", gameid: API.strGameID, gamesessionid: "", actionid: "", comment: "", isFirstTime: "1")
         }
         else{
//            if UserDefaults.standard.object(forKey: "isLogin") != nil{
             // exist
             rootVC.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "101", comment: "Spalsh Screen", isFirstTime: "0")
//            }
         }
        UserDefaults.standard.setValue("", forKey: "isFirstTimeShow")

        self.navigationController?.pushViewController(rootVC, animated: true)

//         let frontNavigationController = UINavigationController(rootViewController: rootVC)
//        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
//        appDelegate?.window?.rootViewController = frontNavigationController
//        appDelegate?.window?.makeKeyAndVisible()

    }

    @IBAction func AddNewPackageClicked(_ sender: AnyObject) {
//        self.tabBarController?.tabBar.isHidden = true
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectExamVC") as? SelectExamVC
//        SJSwiftSideMenuController.pushViewController(vc!, animated: false)
        self.tabBarController!.selectedIndex = 1

    }

    @IBAction func logoutClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
//            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
            vc?.isSelectExam = "1000"
            UserDefaults.standard.set("0", forKey: "isLogin")
            let prefs = UserDefaults.standard
            prefs.removeObject(forKey:"isLogin")
            prefs.removeObject(forKey:"filter_price")
            prefs.removeObject(forKey:"logindata")
            prefs.removeObject(forKey:"exam_preferences")
            prefs.removeObject(forKey:"filter_price")
//            SJSwiftSideMenuController.pushViewController(vc!, animated: false)
        }))
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func apiMyPackages()
    {
        showActivityIndicator()
        arrMyPackageList.removeAll()
        //        let params = ["BoardID":strCategoryID1,"StandardID":"9","CourseTypeID": strCategoryID,"SubjectID":"1"]
        var params = ["":""]
//        var result:[String:String] = [:]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
//            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
//        }
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        params = ["StudentID":"\(result["StudentID"] ?? "")",
            "SubjectID":"","isCompetitive":"", "StandardID":"", "BoardID":"", "CourseID":""]
        }
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_Student_Subcription_Subject,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblDashbord.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_Student_Subcription_Subject, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                self.strDisplayMsg = ""//"Package not available."
                let json = JSON(value)
                //Bhargav Hide
                print("mmp responce",json)

                if(json["Status"] == "true" || json["Status"] == "2") {
                    let arrData = json["data"].array
                    for value in arrData! {
                       // var arrTestType = [PackageDetailsModal]()
                       // let arrSubValue:[JSON] = value["PackageList"].array!
//                        //
//                        for values in arrSubValue {
//                            //                                                    let TestTypeModel:PackageDetailsModal = PackageDetailsModal.init(id: "", TestTypeName: values["TestTypeName"].stringValue, TestQuantity: values["TestQuantity"].stringValue)
//                            let TestTypeModel:PackageDetailsModal = PackageDetailsModal.init(TestPackageID: values["StudentTestPackageID"].stringValue, TestPackageName: values["TestPackageName"].stringValue, TestPackageDescription: values["TestPackageDescription"].stringValue, TestPackageSalePrice: values["TestPackageSalePrice"].stringValue, TestPackageListPrice: values["TestPackageListPrice"].stringValue, NumberOfTest: values["NumberOfTest"].stringValue, image: values["image"].stringValue, selected: "0", packageStartDate: values["PurchaseDate"].stringValue, packageEndDate: values["ExpirationDate"].stringValue, Subject: values["Subject"].stringValue, TutorId: values["TutorID"].stringValue, TutorName: values["TutorName"].stringValue, InstituteName: values["InstituteName"].stringValue, arrTestType: [],isCompetitive: values["isCompetitive"].stringValue,std: "\(values["StandardName"].stringValue)",stdId: "\(values["StandardID"].stringValue)", BoardID: "\(values["BoardID"].stringValue)", NumberOfComletedTest: "\(values["NumberOfComletedTest"].stringValue)") // old
//
//                            arrTestType.append(TestTypeModel)
//                        }
                        //                        let pckgDetModel:PackageDetailsModal = PackageDetailsModal.init(TestPackageID: value["StudentTestPackageID"].stringValue, TestPackageName: value["TestPackageName"].stringValue, TestPackageDescription: value["TestPackageDescription"].stringValue, TestPackageSalePrice: value["TestPackageSalePrice"].stringValue, TestPackageListPrice: value["TestPackageListPrice"].stringValue, NumberOfTest: value["NumberOfTest"].stringValue, image: value["image"].stringValue, selected: "0", packageStartDate: value["PurchaseDate"].stringValue, packageEndDate: value["ExpirationDate"].stringValue, Subject: value["Subject"].stringValue, TutorId: value["TutorID"].stringValue, TutorName: value["TutorName"].stringValue, InstituteName: value["InstituteName"].stringValue, arrTestType: arrTestType) // old
                        let pckgDetModel:getSubscriptionModel = getSubscriptionModel.init(ID: value["ID"].intValue, StandardID: value["StandardID"].stringValue, isSubscription: value["isSubscription"].stringValue, isCompetitive: value["isCompetitive"].boolValue, Icon: value["Icon"].stringValue, StandardName: value["StandardName"].stringValue, BannerIcon: value["BannerIcon"].stringValue, TestSummary: value["TestSummary"].stringValue, Performance: value["Performance"].stringValue, BoardID: value["BoardID"].stringValue, ExpirationDate: value["ExpirationDate"].stringValue, IsExpired: value["IsExpired"].stringValue, Name: value["Name"].stringValue, PackageList: value["PackageList"].stringValue)

                        //.init(id: value["SubjectID"].stringValue, title: value["SubjectName"].stringValue, subTitle: "", price: "", image: "", selected: "0")

                        self.arrMyPackageList.append(pckgDetModel)
                    }
                    if self.arrMyPackageList.count > 0
                    {
                        self.viewPlaceHolderScreen.isHidden = true
                        self.viewDashboardLogin.isHidden = true
                    }
                    else
                    {
                        self.viewPlaceHolderScreen.isHidden = false
                        self.viewDashboardLogin.isHidden = true


                    }

                    DispatchQueue.main.async {
                        self.tblDashbord.reloadData()
                    }



                   // self.viewPlaceHolderScreen.isHidden = true


                    //                        var arrTestType = [PackageDetailsModal]()
                    //                        let arrSubValue:[JSON] = value["TestType"].array!

                    //                        let pckgDetModel:MyPackageListModal = MyPackageListModal.init(packageid: value["StudentTestPackageID"].stringValue, packageName: value["TestPackageName"].stringValue, packageimage: value[""].stringValue, packageDescription: value[""].stringValue, packageStartDate: value["PurchaseDate"].stringValue, packageEndDate: value["ExpirationDate"].stringValue, packageNumberOfTest:value["NumberOfTest"].stringValue, packagePrice:value["TestPackageSalePrice"].stringValue)
                    //
                    //                        self.arrMyPackageList.append(pckgDetModel)
                    //                    }

                    //                    self.tblPackageDetail.reloadData()


                }
                else
                {
                    self.viewPlaceHolderScreen.isHidden = true
                    self.viewDashboardLogin.isHidden = false
                    self.btnLogin.isHidden = true
                }
            case .failure(let error):
                if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                    // show Alert
                    self.hideActivityIndicator()
                    print("The network is not reachable")
                    // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                    return
                }
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

                //Bhargav Hide
print(error)
            }
//            if self.arrMyPackageList.count > 0
//            {
               // self.tblDashbord.reloadData()
//            }
        }
    }
}
extension DashboardVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return arrMyPackageList.count
        tableView.backgroundView = nil;
        if self.arrMyPackageList.count > 0 { return self.arrMyPackageList.count }
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = self.strDisplayMsg
            noDataLabel.textColor     = UIColor.red
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            return 0
        }

    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "DashBordTableViewCell"
        var cell: DashBordTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? DashBordTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "DashBordTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DashBordTableViewCell
        }
        cell.topbgView1.addShadowWithRadius(0,12,0,color: UIColor.lightGray)

        cell.imgBackGround.addShadowWithRadius(0,12,0,color: UIColor.lightGray)
        cell.imgBackGround.clipsToBounds = true
        if(self.arrMyPackageList.count > 0)
        {
//            if arrMyPackageList[indexPath.row].Subject == "Social Science"
//            {
//                cell.imgBackGround.image = UIImage(named: "Social_Science.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Science"
//            {
//                cell.imgBackGround.image = UIImage(named: "Science.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Mathematics"
//            {
//                cell.imgBackGround.image = UIImage(named: "Mathematics.jpeg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Hindi"
//            {
//                cell.imgBackGround.image = UIImage(named: "Hindi.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "English"
//            {
//                cell.imgBackGround.image = UIImage(named: "English_2.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Accountancy"
//            {
//                cell.imgBackGround.image = UIImage(named: "Account.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Hindi"
//            {
//                cell.imgBackGround.image = UIImage(named: "Hindi.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Gujarati"
//            {
//                cell.imgBackGround.image = UIImage(named: "Gujarati.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Statistics"
//            {
//                cell.imgBackGround.image = UIImage(named: "Stat.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Economics"
//            {
//                cell.imgBackGround.image = UIImage(named: "Stat.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Physics"
//            {
//                cell.imgBackGround.image = UIImage(named: "Physics.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Biology"
//            {
//                cell.imgBackGround.image = UIImage(named: "Biology.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "Businss Stuydies"
//            {
//                cell.imgBackGround.image = UIImage(named: "Businss_Stuydies.jpg")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "JEE Main"
//            {
//                cell.imgBackGround.image = UIImage(named: "Subject_JEE_Main_4.png")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "JEE Advance"
//            {
//                cell.imgBackGround.image = UIImage(named: "Subject_JEE_Main_4.png")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "NEET"
//            {
//                cell.imgBackGround.image = UIImage(named: "Subject_NEET.png")
//            }
//            else if arrMyPackageList[indexPath.row].Subject == "GUJCET"
//            {
//                cell.imgBackGround.image = UIImage(named: "Gujcet.png")
//            }else{
//                cell.imgBackGround.image = UIImage(named: "Grey.jpg")
//
//            }
            //                cell.topbgView1.backgroundColor = UIColor(rgb: 0xF8FCFF)    economics

            cell.lblTitle.text = "\(arrMyPackageList[indexPath.row].StandardName ?? "")" + "\n" + "\(arrMyPackageList[indexPath.row].Name ?? "")"
            //        cell.lblStartDate.text = arrMyPackageList[indexPath.row].packageStartDate ?? ""
            //        cell.lblEndDate.text = arrMyPackageList[indexPath.row].packageEndDate ?? ""
            //        cell.lblPrice.text = "₹" + "\(arrMyPackageList[indexPath.row].TestPackageSalePrice ?? "")"
            if arrMyPackageList[indexPath.row].ExpirationDate == ""
            {cell.lblExDate.text = ""
            }else
            {
                if arrMyPackageList[indexPath.row].IsExpired == "1"
                {
                    cell.lblExDate.text = "Expire: \(arrMyPackageList[indexPath.row].ExpirationDate ?? "")" // Expired
                }else{
                    cell.lblExDate.text = "Expire: \(arrMyPackageList[indexPath.row].ExpirationDate ?? "")"
                }
            }
            cell.lblSubTitle.isHidden = true

            print("image","\(API.imageUrl) + \(arrMyPackageList[indexPath.row].BannerIcon ?? "")")
//            cell.imgBackGround.sd_setImage(with: URL(string: "\(API.imageUrl)\(arrMyPackageList[indexPath.row].BannerIcon ?? "")"))

            if arrMyPackageList[indexPath.row].Name == "GUJCET - English"
            {
                cell.imgBackGround.sd_setImage(with: URL(string: API.imageUrl + "Gujcet.png"))
            }else{
                if let imgurl = arrMyPackageList[indexPath.row].BannerIcon {
                    cell.imgBackGround.sd_setImage(with: URL(string: API.imageUrl + imgurl))
                }
            }





//            cell.lblSubTitle.text = "\(arrMyPackageList[indexPath.row].arrTestType.count)" + " Packages"
//                  print("\(arrMyPackageList[indexPath.row].BannerIcon ?? "")")
//                  let url = URL.init(string: "\(API.imageUrl) + \(arrMyPackageList[indexPath.row].BannerIcon ?? "")".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                  //        let url = URL.init(string: "https://content.testcraft.co.in/question/" + (arrHeaderSub3Title[indexPath.row].image ?? "").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
//                  cell.imgBackGround.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
//                      if error != nil {
//                          return
//                      }
//                  }

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyPackageListVCViewController") as? MyPackageListVCViewController


        vc!.strTitle = "\(arrMyPackageList[indexPath.row].StandardName ?? "") \(arrMyPackageList[indexPath.row].Name ?? "")"
        vc!.strtempSubjectID = "\(arrMyPackageList[indexPath.row].ID ?? 0)"
        vc!.strIsCompetitive = "\(arrMyPackageList[indexPath.row].isCompetitive ?? false)"

        if arrMyPackageList[indexPath.row].isCompetitive == true{
            vc!.CourseTypeID = 2
            vc!.courseName = "\(arrMyPackageList[indexPath.row].Name ?? "")"
        }else{
            vc!.CourseTypeID = 1
            vc!.courseName = "\(arrMyPackageList[indexPath.row].StandardName ?? "")"

        }
        vc!.strtempStandardID = "\(arrMyPackageList[indexPath.row].StandardID ?? "")"
        vc!.strtempStandardName = "\(arrMyPackageList[indexPath.row].StandardName ?? "")"
        vc!.strtempBoardID = "\(arrMyPackageList[indexPath.row].BoardID ?? "")"
        vc!.istempSubscription = "\(arrMyPackageList[indexPath.row].isSubscription ?? "")"
//        vc!.isSubscription = "\(arrMyPackageList[indexPath.row].TestPackageDescription ?? "")"
        vc!.isExpired = "\(arrMyPackageList[indexPath.row].IsExpired ?? "")"

//          var istempSubscription = ""
//
//                vc!.arrSubPackageList = [self.arrMyPackageList[indexPath.row]]
//                strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
//                strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
//                arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
//                vc!.strPackageID = "\(arrMyPackageList[indexPath.row].TestPackageID ?? "")"
//                vc!.strSetTitle = "\(arrMyPackageList[indexPath.row].TestPackageName ?? "")"//TestPackageName
        self.navigationController?.pushViewController(vc!, animated: true)
    }
//    @objc func TestClicked(sender:UIButton) {
//
//        let buttonRow = sender.tag
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
//        //        vc!.arrPackageDetail = [self.arrHeaderSub3Title[indexPath.row]]
//        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
//        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
//        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
//
//        self.navigationController?.pushViewController(vc!, animated: true)
//
//
//    }
//    @objc func ViewPackageClicked(sender:UIButton) {
//
//        let buttonRow = sender.tag
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PackageDetailsVC") as? PackageDetailsVC
//        vc!.arrPackageDetail = [self.arrMyPackageList[buttonRow]]
//        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
//        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
//        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
//        vc!.strNotDisplay = "1"
//        self.navigationController?.pushViewController(vc!, animated: true)
//
//    }
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        return arrDashbord.count//arrMyPackageList.count
//        if self.arrDashbord.count > 0 { return self.arrDashbord.count }
//        else
//        {
//            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            noDataLabel.text          = "Package not purchesed."
//            noDataLabel.textColor     = UIColor.red
//            noDataLabel.textAlignment = .center
//            tableView.backgroundView  = noDataLabel
//            tableView.separatorStyle  = .none
//            return 0
//        }
//
//    }
//    //My heightForRowAtIndexPath method
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130//UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let identifier = "DashBordTableViewCell"
//        var cell: DashBordTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? DashBordTableViewCell
//        if cell == nil {
//            tableView.register(UINib(nibName: "DashBordTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
//            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DashBordTableViewCell
//        }
//        cell.lblTitle.text = arrDashbord[indexPath.row]//"GUB 10th Maths"//arrMyPackageList[indexPath.row].packageName ?? ""
//        cell.lblSubTitle.isHidden = true
//        cell.topbgView1.addShadowWithRadius(2,30,1,color: UIColor.lightGray)
//        cell.topbgView1.backgroundColor = UIColor(rgb: 0xF8FCFF)
//        cell.imgBackGround.image = UIImage(named: arrDashbord_img[indexPath.row])
//        return cell
//
//
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0
//        {
//            selectedPackages = 1
//        }
//        else if indexPath.row == 1
//        {
//            selectedPackages = 0
//        }
//        else
//        {
//            selectedPackages = indexPath.row
//        }
//
//        self.tabBarController?.tabBar.isHidden = false
//
////            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategory3VC") as? SubCategory3VC
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MarketPlaceVC") as? MarketPlaceVC
////            vc!.strDisplayPackages = "\(indexPath.row)"
//            self.navigationController?.pushViewController(vc!, animated: true)
////        }
//    }
}


extension DashboardVC{
    func Get_Subcription_Course_Price_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
    {
        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)

        api = API.Get_Subcription_Course_PriceApi
        params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "CourseID":CourseID, "BoardID":BoardID, "StandardID":StandardID, "TypeID":TypeID, "IsFree":IsFree]

        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            //self.tblList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                //                self.btnPrice.isHidden = true
                //                self.lblPrice.isHidden = true
                //                self.btnPayNow.isHidden = true

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "True") {
                    //                    self.Get_ContentCount_API()
                    //                        let strQuestion = "\(json["data"]["Question"].stringValue)"
                    //                        let TestPackage = "\(json["data"]["TestPackage"].stringValue)"
                    self.strPrice = "\(json["data"]["Price"].stringValue)"
                    self.strListPrice = "\(json["data"]["ListPrice"].stringValue)"
                    //                    self.strPrice = "0"
                    //                        self.btnPrice.isHidden = false
                    //                        self.btnPayNow.isHidden = false
                    //                        self.lblPrice.isHidden = false
                    //                        self.lblPrice.text = ""
                    //                        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    //                        let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strListPrice)")//, attributes: attrs )
                    //                        attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    //                        attributeString.append(attributeString1)
                    //                        let attributedStringColor = [NSAttributedString.Key.foregroundColor : GetColor.blueHeaderText];
                    //
                    //                        if self.strPrice == "0" {
                    //                            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    //                            attributeString.append(attributeString2)
                    //
                    //                        }else{
                    //    //                        self.lblPrice.text = "₹ \(self.strPrice)"
                    //                            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)", attributes: attributedStringColor)
                    //                            attributeString.append(attributeString2)
                    //
                    //                        }
                    //                        self.lblPrice.attributedText = attributeString
                    self.Check_Subcription_FreeTrial_API()
                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)

                    let alert = UIAlertController(title: "\(json["Msg"].stringValue)", message: "", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                        //Bhargav Hide
                        //                        self.popUpViewSubscription.isHidden = false
                        //                        self.pushPackage(strTemp:"")
                    }
                    alert.addAction(action1)
                    //                            alert.addAction(actionContinue)
                    self.present(alert, animated: true, completion: {
                        //Bhargav Hide
                        ////print("completion block")
                    })
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }

    func Check_Subcription_FreeTrial_API()
    {
        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)
        params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")"]

        //Bhargav Hide
        print("API, Params: \n",API.Check_Subcription_FreeTrialApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            //            self.collectionView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Check_Subcription_FreeTrialApi, method: .post, parameters: params, headers: headers).validate().responseJSON { [self] response in
            self.hideActivityIndicator()
            // self.popUpSubViewSubscription.isHidden = false

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
                //                self.btnPrice.isHidden = false
                //                self.btnPayNow.isHidden = false
                //                self.lblPrice.isHidden = false
                //                self.lblPrice.text = ""

                if(json["Status"] == "true" || json["Status"] == "1") {

                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strPrice)")//, attributes: attrs )
                    attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    attributeString.append(attributeString1)
                    let attributedStringColor = [NSAttributedString.Key.foregroundColor : GetColor.borderColorPayment.cgColor];
                    //                    if self.strPrice == "0" {
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    attributeString.append(attributeString2)

                    //                    }else{
                    //////                        self.lblPrice.text = "₹ \(self.strPrice)"
                    ////                        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)", attributes: attributedStringColor)
                    ////                        attributeString.append(attributeString2)
                    //
                    //                    }
//                    self.btnFreeTrialClick.setTitle("Free 1 Month Trail", for: .normal)
                    self.IsFree = "1"
                    IsFreeFirstTime = "1"
//                    lblCoursePrise.isHidden = true
//                    lblCoursePrise.layer.cornerRadius = 0.0
//                    lblCoursePrise.layer.masksToBounds = true
//                    var FirstTimeCourseTypeID:Int = 0
//                    var FirstTimeBoardId:Int = 0
//                    var FirstTimeStandardId:Int = 0


                    self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(FirstTimeBoardId)", StandardID: "\(FirstTimeStandardId)", TypeID: "\(FirstTimeCourseTypeID)")


                   // self.lblCoursePrise.attributedText = attributeString



                }
                else
                {
                    self.apiMyPackages()

                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)

//                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
//                    //                    let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strListPrice)")//, attributes: attrs )
//                    //                    attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
//                    //                    attributeString.append(attributeString1)
//                    let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor(red: 27.0/255.0, green: 145.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor];
//
//                    //                    if self.strPrice == "0" {
//                    //                        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
//                    //                        attributeString.append(attributeString2)
//                    //
//                    //                    }else{
//                    //                        self.lblPrice.text = "₹ \(self.strPrice)"
//                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)/year", attributes: attributedStringColor)
//                    attributeString.append(attributeString2)

                    //                    }
//                self.btnFreeTrialClick.setTitle("Pay Now", for: .normal)
                    self.IsFree = "0"
                    IsFreeFirstTime = "0"
//                    lblCoursePrise.isHidden = false
//                    lblCoursePrise.attributedText = attributeString
//
//                    lblCoursePrise.layer.cornerRadius = 6.0
//                    lblCoursePrise.layer.masksToBounds = true

//                    lblCoursePrise.layer.borderWidth = 1.0
//                    lblCoursePrise.layer.borderColor = GetColor.borderColorPayment.cgColor

//                    btnCoursePrise.setAttributedTitle(attributeString2, for: .normal)

                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...\(error)", duration: 3.0, position: .bottom)
                print(error)
            }
        }
    }
    func Insert_StudentSubscription_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "4201", comment: "Subscription Pay Button", isFirstTime: "0")

        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)

        api = API.Insert_StudentSubscription_TempApi

        if FirstTimeCourseTypeID == 2{

//            self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "0", StandardID: "\(self.StandardId)", TypeID: "\(self.CourseTypeID)")

            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":StandardID,"BoardID":BoardID,"StandardID":"0","TypeID":TypeID,"IsFree":IsFree]


        }else{
            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":CourseID,"BoardID":BoardID,"StandardID":StandardID,"TypeID":TypeID,"IsFree":IsFree]


        }


        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
           // self.tblList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                //                self.btnPrice.isHidden = true
                //                self.lblPrice.isHidden = true
                //                self.btnPayNow.isHidden = true

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    self.Payment_Api(strCoin: self.strPrice)

                    //                    self.Get_ContentCount_API()
                    //                    let arrData = json["data"].array
                    //                    let alert = UIAlertController(title: "Package add sucessfully", message: "", preferredStyle: UIAlertController.Style.alert)
                    //                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                    //                        //Bhargav Hide
                    //                        ////print("User click Ok button")
                    ////                        self.popUpViewSubscription.isHidden = false
                    ////                        self.pushPackage(strTemp:"")
                    //                    }
                    //                    alert.addAction(action1)
                    //                    //                            alert.addAction(actionContinue)
                    //                    self.present(alert, animated: true, completion: {
                    //                        //Bhargav Hide
                    //                        ////print("completion block")
                    //                    })
                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
//                    self.Payment_Api(strCoin: self.strPrice)

                    let alert = UIAlertController(title: "\(json["Msg"].stringValue)", message: "", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                        //Bhargav Hide
                        //                        self.popUpViewSubscription.isHidden = false
                        //                        self.pushPackage(strTemp:"")
                    }
                    alert.addAction(action1)
                    //                            alert.addAction(actionContinue)
                    self.present(alert, animated: true, completion: {
                        //Bhargav Hide
                        ////print("completion block")
                    })
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
    func Payment_Api(strCoin: String)
    {
        //        showActivityIndicator()
        let UDID: String = UIDevice.current.identifierForVendor!.uuidString

        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)
        let currencyString = "\(strCoin)"
        var amount_new = currencyString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: "₹", with: "", options: NSString.CompareOptions.literal, range: nil)
        amount_new = amount_new.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
        //        var amount_new = currencyString.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: ", ₹  "))
        //Bhargav Hide
        ////print("_currencyString_______amount_____",currencyString, amount_new)
        var params = ["":""]
        //            if self.strCouponCodeID != ""
        //            {
        //                params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0"]
        //            }
        //            else
        //            {
        params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0"]
        //            }

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        //Bhargav Hide
        print("API, Params: \n",API.SubscriptionPaymentUrl,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.SubscriptionPaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    var amount = "0"
                    var temp_isFree = "0"
                    //                    var New_Student_ID = ""

                    for value in arrData! {
                        amount = "\(value["PaymentAmount"].stringValue)"//hide29_oct_2020
                        self.temp_Order_ID = "\(value["OrderID"].stringValue)"
                        self.temp_PaymentTransaction_ID = "\(value["PaymentTransactionID"].stringValue)"
                        temp_isFree = "\(value["IsFree"].stringValue)"
                        Order_ID = "\(value["OrderID"].stringValue)"
                        PaymentTransaction_ID = "\(value["PaymentTransactionID"].stringValue)"

//                        "IsFree" : "0",

                    }
                    if self.IsFree == "1"
                    {
                       // UserDefaults.standard.setValue(false, forKey: "isFirstTimeShow")
                        print("Freee.....")
                        //                        self.buyPackages()
                        self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)

//                                                self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)

                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
                    }
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
    func Update_Payment_Api(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String)
    {
        showActivityIndicator()

        //        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //        //Bhargav Hide
        ////print(result)
        //        let payment_status = (dic["response_code"]! as! String == "0") ? "success" : "failed"
        let params = ["PaymentOrderID":OrderID, "ExternalTransactionStatus":ExternalTransactionStatus, "ExternalTransactionID":ExternalTransactionID, "StudentID":StudentID]

        //        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.SubscriptionUpdatePaymentUrl,params)
                       if !Connectivity.isConnectedToInternet() {
                self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                           return
                       }

        Alamofire.request(API.SubscriptionUpdatePaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    self.apiMyPackages()
                    let arrData = json["data"].array
                    //                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
//                        if amount == "0"
//                        {
//                            var arrTestList = [TestListModal]()
//                            for value in arrData! {
//                                //                        var arrTestType = [PackageDetailsModal]()
//                                let testDetModel:TestListModal = TestListModal.init(testID: value["TestID"].stringValue, studentTestID: value["StudentTestID"].stringValue, testName: value["TestName"].stringValue, testFirstTime: value[""].stringValue, testSubTitle: value["TestPackageName"].stringValue, testDate: value[""].stringValue, testStatusName: value["StatusName"].stringValue, testMarks: value["TestMarks"].stringValue, testStartTime: value["TestStartTime"].stringValue, testDuration: value["TestDuration"].stringValue, testEndTime: value["TestEndTime"].stringValue, chapterName:value["SubjectName"].stringValue, teacherName:value["TutorName"].stringValue, remainTime: "\(value["RemainTime"].stringValue)", isCompetetive: "\(value["IsCompetetive"].stringValue)", courseName: "\(value["CourseName"].stringValue)",totalQue: "\(value["TotalQuestions"].stringValue)", introLink: "\(value["TestInstruction"].stringValue)", NumberOfHint: "\(value["NumberOfHint"].stringValue)", NumberOfHintUsed: "\(value["NumberOfHintUsed"].stringValue)")
//
//                                arrTestList.append(testDetModel)
//                            }
//                            if(arrTestList.count > 0)
//                            {    self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Start", isFirstTime: "0")
//
//                                let buttonRow = 0//sender.tag
//                                //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestIntroVC") as? TestIntroVC
//                                vc?.intProdSeconds = Float(arrTestList[buttonRow].RemainTime!) ?? 0
//                                //Bhargav Hide
//                                ////print(arrTestList[buttonRow])
//                                vc?.arrTestData = [arrTestList[buttonRow]]
//                                vc?.strTestID = "\(arrTestList[buttonRow].testID ?? "")"
//                                vc?.strTestTitle = "\(arrTestList[buttonRow].testName ?? "")"
//                                vc?.strStudentTestID = "\(arrTestList[buttonRow].studentTestID ?? "")"
//                                vc?.strTitle = "\(arrTestList[buttonRow].testName ?? "")"
//                                vc?.strLoadUrl = "\(arrTestList[buttonRow].IntroLink ?? "")"
//                                vc?.int_Total_Hint = Int(arrTestList[buttonRow].NumberOfHint!) ?? 0
//                                vc?.int_Used_Hint = Int(arrTestList[buttonRow].NumberOfHintUsed!) ?? 0
//
//                                self.navigationController?.pushViewController(vc!, animated: true)
//                            }
//                        }else{
//                        for controller in self.navigationController!.viewControllers as Array {
//                            //Bhargav Hide
//                            ////print(controller)
//                            if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                                controller.tabBarController!.selectedIndex = 0
//                                //                                controller.tabBarController?.tabBarItem
//                                self.navigationController!.popToViewController(controller, animated: false)
//                                break
//                            }
//                            else if controller.isKind(of: ExploreVC.self) {
//                                controller.tabBarController!.selectedIndex = 0
//                                self.navigationController!.popToViewController(controller, animated: false)
//                                break
//                            }
//                        }

//                        self.Purchased_Coin_Api(OrderID: OrderID, ExternalTransactionStatus: "success", ExternalTransactionID: "", StudentID: StudentID, amount: amount)
//                        }
                    //                    let alert = AlertController(title: "", message: "\(json["Msg"])", preferredStyle: .alert)
                    //                    // Add actions
                    //                    //                    let action = UIAlertAction(title: "No", style: .cancel, handler: nil)
                    //                    //        action.actionImage = UIImage(named: "No")
                    //                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                    //                        for controller in self.navigationController!.viewControllers as Array {
                    //                            //Bhargav Hide
                    //////print(controller)
                    //                            if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
                    //                                controller.tabBarController!.selectedIndex = 0
                    //                                //                                controller.tabBarController?.tabBarItem
                    //                                self.navigationController!.popToViewController(controller, animated: false)
                    //                                break
                    //                            }
                    //                            else if controller.isKind(of: ExploreVC.self) {
                    //                                controller.tabBarController!.selectedIndex = 0
                    //                                self.navigationController!.popToViewController(controller, animated: false)
                    //                                break
                    //                            }
                    //                        }
                    //
                    //                    }))
                    //                    alert.addAction(action)
                    //                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
}
