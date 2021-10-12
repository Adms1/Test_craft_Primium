//
//  TestListVC.swift
//  TestCraft
//
//  Created by ADMS on 19/06/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage




class TestListVC: UIViewController, ActivityIndicatorPresenter {


    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()



    @IBOutlet var tblTestList:UITableView!
    @IBOutlet var viewTest:UIView!
    @IBOutlet var btnTestInfo:UIButton!
    @IBOutlet var lblTitle:UILabel!
    var strPackageID = ""
   // var arrTestList1 = [TestListModal]()
    var strSetTitle = ""
    var strDescription = ""
    var arrTestList1 = [arrTestList]()
    @IBOutlet var viewInfoPopup: UIView!
    @IBOutlet var viewInfoBackgroundPopup: UIView!
    @IBOutlet var btnInfoPopupClose: UIButton!
    @IBOutlet var btnInfoPopupStart: UIButton!

    @IBOutlet var lblInfoPopupMainTitle: UILabel!
    @IBOutlet var lblInfoPopupTitle: UILabel!
    @IBOutlet var lblInfoPopupChapterTitle: UILabel!
    @IBOutlet var lblInfoPopupChapterSubtitle: UILabel!
    @IBOutlet var lblInfoPopupTeacherTitle: UILabel!
    @IBOutlet var lblInfoPopupTeacherSubtitle: UILabel!
    @IBOutlet var lblInfoPopupTotalMarksTitle: UILabel!
    @IBOutlet var lblInfoPopupTotalMarksSubtitle: UILabel!
    @IBOutlet var lblInfoPopupCourseNameTitle: UILabel!
    @IBOutlet var lblInfoPopupCourseNameSubTitle: UILabel!
    @IBOutlet var lblInfoPopupTotalQueTitle: UILabel!
    @IBOutlet var lblInfoPopupTotalQueSubTitle: UILabel!

    @IBOutlet var imgInfoPopupBackGround:UIImageView!
    @IBOutlet var imgInfoPopupDotCurrent:UIImageView!
    @IBOutlet var imgInfoPopupDotAnswerd:UIImageView!
    @IBOutlet var imgInfoPopupDotUnAnswered:UIImageView!
    @IBOutlet var imgInfoPopupDotReviewLater:UIImageView!
    @IBOutlet var imgInfoPopupDotNotVisited:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblTitle.text = strSetTitle
        viewTest.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
       // tblTestList.addShadowWithRadius(0,8,0,color: UIColor.darkGray)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1900", comment: "Test List", isFirstTime: "0")
        if isSubscription == "1"
        {
            btnTestInfo.isHidden = true
//            lblInfoPopupTeacherTitle.isHidden = true
        }
        viewInfoPopup.isHidden = true
        self.btnInfoPopupClose.setTitle("Dismiss", for: .normal)
        self.btnInfoPopupStart.setTitle("Start Test", for: .normal)
        self.btnInfoPopupClose.backgroundColor = UIColor.lightGray
        self.btnInfoPopupStart.backgroundColor = GetColor.themeBlueColor
//        imgInfoPopupBackGround.addBlur()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isGotoDashBoard == "1"
        {
            BackToDashbord(VC: self)
        }

        if (arrTestList1[0].TutorName == ""){
            lblInfoPopupTeacherTitle.isHidden = true
            lblInfoPopupTeacherSubtitle.isHidden = true
        }else{
            lblInfoPopupTeacherTitle.isHidden = false
            lblInfoPopupTeacherSubtitle.isHidden = false

        }



        if (arrTestList1[0].StatusName == "Start Test"){
            SetInfoPopupdata(strTitle: "\(arrTestList1[0].TestName ?? "")", strChName: "\(arrTestList1[0].SubjectName ?? "")", strTechName: "\(arrTestList1[0].TutorName ?? "")", strTotalMarks:"\(arrTestList1[0].TestMarks ?? "")", strCourseName: "\(arrTestList1[0].CourseName ?? "")", strTotalQue: "\(arrTestList1[0].TotalQuestions ?? "")")

        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
    //        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
    //        vc?.arrTestData = [arrTestList1[buttonRow]]
    //        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
    //        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
    //        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
    //        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
    //        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0

            vc?.intProdSeconds = Float(arrTestList1[0].RemainTime) ?? 0.0
            //Bhargav Hide
            ////print(arrTestList1[buttonRow])
          //  vc?.delegate = self
            vc?.arrTestData = [arrTestList1[0]]
            vc?.strTestID = "\(arrTestList1[0].TestID)"
            vc?.strTestTitle = "\(arrTestList1[0].TestPackageName ?? "")"
            vc?.strStudentTestID = "\(arrTestList1[0].StudentTestID ?? 0)"
            vc?.int_Total_Hint = Int(arrTestList1[0].NumberOfHint) ?? 0
            vc?.int_Used_Hint = Int(arrTestList1[0].NumberOfHintUsed) ?? 0


            self.navigationController?.pushViewController(vc!, animated: true)

        }

       // apiMyPackages()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func BackClicked(_ sender: AnyObject) {
        //        SJSwiftSideMenuController.toggleLeftSideMenu()
        //        arrPath.removeLast()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func InfoClicked(_ sender: AnyObject) {
        apiInfoDetail()
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1902", comment: "Package Description", isFirstTime: "0")
        
    }
    @IBAction func KnowledgeGapClicked(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        vc?.strTitle = "Knowledge Gap"
        vc?.strLoadUrl = "\(API.hostName1)TestPackageSummaryReport.aspx?STPID=\(strPackageID)" //"\(API.hostName)TestSummaryReport.aspx?STID=\(self.strStudentTestID)"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
            self.tabBarController?.tabBar.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
            UserDefaults.standard.set("0", forKey: "isLogin")
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
    
//    func apiMyPackages()
//    {
//        showActivityIndicator()
//        self.arrTestList11.removeAll()
//        //        let params = ["BoardID":strCategoryID1,"StandardID":"9","CourseTypeID": strCategoryID,"SubjectID":"1"]
//        var params = ["":""]
//        var result:[String:String] = [:]
//        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
//        {
//            //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
//            //        }
//            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//
//            params = ["StudentID":"\(result["StudentID"] ?? "")","StudentTestPackageID":strPackageID]
//        }
//        let headers = [
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        //Bhargav Hide
//        print("API, Params: \n",API.Get_StudentTestApi,params)
//        if !Connectivity.isConnectedToInternet() {
//                    self.AlertPopupInternet()
//
//            // show Alert
//            self.hideActivityIndicator()
//            print("The network is not reachable")
//            self.tblTestList.reloadData()
//            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
//            return
//        }
//
//        Alamofire.request(API.Get_StudentTestApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
//            self.hideActivityIndicator()
//
//            switch response.result {
//            case .success(let value):
//
//                let json = JSON(value)
//                //Bhargav Hide
//                print(json)
//
//                if(json["Status"] == "true" || json["Status"] == "2") {
//                    let arrData = json["data"].array
//
//                    for value in arrData! {
//                        //                        var arrTestType = [PackageDetailsModal]()
//                        let testDetModel:TestListModal = TestListModal.init(testID: value["TestID"].stringValue, studentTestID: value["StudentTestID"].stringValue, testName: value["TestName"].stringValue, testFirstTime: value[""].stringValue, testSubTitle: value["TestPackageName"].stringValue, testDate: value[""].stringValue, testStatusName: value["StatusName"].stringValue, testMarks: value["TestMarks"].stringValue, testStartTime: value["TestStartTime"].stringValue, testDuration: value["TestDuration"].stringValue, testEndTime: value["TestEndTime"].stringValue, chapterName:value["SubjectName"].stringValue, teacherName:value["TutorName"].stringValue, remainTime: "\(value["RemainTime"].stringValue)", isCompetetive: "\(value["IsCompetetive"].stringValue)", courseName: "\(value["CourseName"].stringValue)",totalQue: "\(value["TotalQuestions"].stringValue)", introLink: "\(value["TestInstruction"].stringValue)", NumberOfHint: "\(value["NumberOfHint"].stringValue)", NumberOfHintUsed: "\(value["NumberOfHintUsed"].stringValue)")
//
//                        self.arrTestList1.append(testDetModel)
//                    }
//
//                    if (self.arrTestList1.count > 0)
//                    {
//                        DispatchQueue.main.async {
//                            self.tblTestList.reloadData()
//                        }
//                    }
//
//                    //                        var arrTestType = [PackageDetailsModal]()
//                    //                        let arrSubValue:[JSON] = value["TestType"].array!
//
//                    //                        let pckgDetModel:MyPackageListModal = MyPackageListModal.init(packageid: value["StudentTestPackageID"].stringValue, packageName: value["TestPackageName"].stringValue, packageimage: value[""].stringValue, packageDescription: value[""].stringValue, packageStartDate: value["PurchaseDate"].stringValue, packageEndDate: value["ExpirationDate"].stringValue, packageNumberOfTest:value["NumberOfTest"].stringValue, packagePrice:value["TestPackageSalePrice"].stringValue)
//                    //
//                    //                        self.arrMyPackageList.append(pckgDetModel)
//                    //                    }
//
//                    //                    self.tblPackageDetail.reloadData()
//
//                }
//            case .failure(let error):
//                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
//                //Bhargav Hide
//                ////print(error)
//            }
//           // self.tblTestList.reloadData()
//        }
//    }
    func apiInfoDetail()
    {
        showActivityIndicator()
        var params = ["":""]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            params = ["StudentID":"\(result["StudentID"] ?? "")","StudentTestPackageID":strPackageID]
        }
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_TestPackage_InstructionApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API.Get_TestPackage_InstructionApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                
                if(json["Status"] == "true" || json["Status"] == "2") {
                    let arrData = json["data"]
                    
                    let alert = UIAlertController(title: "Description", message: "\(arrData)", preferredStyle: .alert)
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.alignment = .left
                    
                    let messageText = NSMutableAttributedString(
                        string: "\(arrData)",
                        attributes: [
                            NSAttributedString.Key.paragraphStyle: paragraphStyle,
                            //                                    NSAttributedString.Key.foregroundColor : UIColor.clear,
                            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)
                        ]
                    )
                    alert.setValue(messageText, forKey: "attributedMessage")
                    
                    //        alert.setTitleImage(UIImage(named: "risk_blue"))
                    // Add actions
                    //        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                    //        action.actionImage = UIImage(named: "close")
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                //Bhargav Hide
                print(error)
            }
        }
    }
}

extension TestListVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTestList1.count
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "MyPackageTableViewCell2"
        var cell: MyPackageTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "MyPackageTableViewCell2", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MyPackageTableViewCell
        }
        cell.lblPackageName.text = arrTestList1[indexPath.row].TestName ?? ""
        cell.lblMarks.text = arrTestList1[indexPath.row].TestMarks ?? ""
        //        cell.lblStartDate.text = arrMyPackageList[indexPath.row].packageStartDate ?? ""
        //        cell.lblEndDate.text = arrMyPackageList[indexPath.row].packageEndDate ?? ""
        //        cell.lblPrice.text = "₹" + "\(arrMyPackageList[indexPath.row].TestPackageSalePrice ?? "")"
        cell.lblGetMarks.isHidden = true
        cell.btnStart.isHidden = true
        cell.btnAnalyse.isHidden = true
        cell.btnReStart.isHidden = true
        //        cell.lblTestTime.textColor = GetColor.blackColor
        cell.lblTestTime.text = "Time: \(arrTestList1[indexPath.row].TestDuration ?? "")"
        
        if arrTestList1[indexPath.row].StatusName == "Start Test" // Start Test
        {
            cell.btnStart.isHidden = false
            cell.btnStart.tag = indexPath.row
            cell.btnStart.addTarget(self,action:#selector(StartTestClicked(sender:)), for: .touchUpInside)
            cell.btnStart.backgroundColor = GetColor.themeBlueColor//UIColor(rgb: 0xF8FCFF)
            cell.btnStart.setTitleColor(UIColor.white, for: .normal)
            cell.btnStart.addShadowWithRadius(0,15,0,color: UIColor.darkGray)
        }
        else if arrTestList1[indexPath.row].StatusName == "Analyse"
        {
            cell.btnAnalyse.isHidden = false
            cell.btnAnalyse.tag = indexPath.row
            cell.btnAnalyse.addTarget(self,action:#selector(AnalysisTestClicked(sender:)), for: .touchUpInside)
            cell.btnAnalyse.backgroundColor = GetColor.dotColorAnswered
            cell.btnAnalyse.setTitleColor(UIColor.white, for: .normal)
            cell.btnAnalyse.addShadowWithRadius(0,15,0,color: UIColor.darkGray)
        }
        else
        {
            cell.btnReStart.isHidden = false
            cell.btnReStart.tag = indexPath.row
            cell.btnReStart.addTarget(self,action:#selector(ReStartTestClicked(sender:)), for: .touchUpInside)
            cell.btnReStart.backgroundColor = UIColor(rgb: 0xF8FCFF)
            cell.btnReStart.addShadowWithRadius(0,15,1.1,color: UIColor.darkGray)
        }
        //        cell.contentView.addShadowWithRadius(0,5,0,color: UIColor.darkGray)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
        //        vc?.intProdSeconds = Int(arrTestList1[indexPath.row].testDuration!) ?? 0
        //        //        vc!.arrPackageDetail = [self.arrHeaderSub3Title[indexPath.row]]
        //        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
        //        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
        //        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
        //
        //        vc?.strTestID = "2"
        //        vc?.strTestTitle = "\(arrTestList1[indexPath.item].testName ?? "")"
        //        vc?.strStudentTestID = "\(arrTestList1[indexPath.item].studentTestID ?? "")"
        //        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @objc func StartTestClicked(sender:UIButton) {
//        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Start", isFirstTime: "0")
        
        let buttonRow = sender.tag
//        SetInfoPopupdata(strTitle: "\(arrTestList1[buttonRow].TestName ?? "")", strChName: "\(arrTestList1[buttonRow].TestPackageName ?? "")", strTechName: "\(arrTestList1[buttonRow].TutorName ?? "")", strTotalMarks:"\(arrTestList1[buttonRow].TestMarks ?? "")", strCourseName: "\(arrTestList1[buttonRow].CourseName ?? "")", strTotalQue: "\(arrTestList1[buttonRow].TotalQuestions ?? "")",sender:sender)

        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestIntroVC") as? TestIntroVC
//        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
//        //Bhargav Hide
//        ////print(arrTestList1[buttonRow])
//        vc?.arrTestData = [arrTestList1[buttonRow]]
//        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
//        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
//        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
//        vc?.strTitle = "\(arrTestList1[buttonRow].testName ?? "")"
//        vc?.strLoadUrl = "\(arrTestList1[buttonRow].IntroLink ?? "")"
//        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
//        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0
//
//        self.navigationController?.pushViewController(vc!, animated: true)
//
        
    }
    func SetInfoPopupdata(strTitle: String,strChName: String,strTechName: String,strTotalMarks: String,strCourseName: String,strTotalQue: String)
    {
        lblInfoPopupMainTitle.text = strTitle
        lblInfoPopupTitle.text = strTitle
        //        lblInfoPopupChapterTitle.text = ""
        if strChName == "" {
            lblInfoPopupChapterSubtitle.text = "-"
        }
        else
        {
            lblInfoPopupChapterSubtitle.text = strChName
        }
        if isSubscription == "1"
        {
            lblInfoPopupTeacherSubtitle.isHidden = true
            lblInfoPopupTeacherTitle.isHidden = true
        }
        //        lblInfoPopupTeacherTitle.text = ""
        lblInfoPopupTeacherSubtitle.text = strTechName
        //        lblInfoPopupTotalMarksTitle.text = ""
        lblInfoPopupTotalMarksSubtitle.text = strTotalMarks
        if strCourseName == "" {
            lblInfoPopupCourseNameSubTitle.text = "-"
        }
        else
        {
            lblInfoPopupCourseNameSubTitle.text = strCourseName
        }
        lblInfoPopupTotalQueSubTitle.text = strTotalQue
        viewInfoBackgroundPopup.addShadowWithRadius(1,9,0,color: UIColor.clear)
       // btnInfoPopupStart.tag = sender.tag
//        btnInfoPopupStart.addTarget(self,action:#selector(StartTestClicked(sender:)), for: .touchUpInside)

        imgInfoPopupDotCurrent.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotAnswerd.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotUnAnswered.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotReviewLater.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotNotVisited.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)
        self.tabBarController?.tabBar.isHidden = true
        viewInfoPopup.isHidden = false

//        imgQueMenuDotCurrent.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
//        imgQueMenuDotAnswerd.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)
//        imgQueMenuDotUnAnswered.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
//        imgQueMenuDotReviewLater.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
//        imgQueMenuDotNotVisited.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)
        //
        //        static var dotColorCurrent:UIColor    = UIColor(rgb: 0x3EA7E0)
        //        static var :UIColor    = UIColor.rbg(r: 216, g: 184, b: 52)
        //        static var :UIColor    = UIColor.rbg(r: 255, g: 0, b: 0)
        //        static var :UIColor    = UIColor.rbg(r: 107, g: 174, b: 24)
        //        static var :UIColor    = UIColor(rgb: 0xA3A3A3)
    }


    @IBAction func InfoStartTestPopupClicked(_ sender: AnyObject) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Start", isFirstTime: "0")
        let buttonRow = sender.tag
        self.tabBarController?.tabBar.isHidden = false
        viewInfoPopup.isHidden = true

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestIntroVC") as? TestIntroVC
        vc?.intProdSeconds = Float(arrTestList1[buttonRow!].RemainTime) ?? 0
        //Bhargav Hide
        ////print(arrTestList1[buttonRow])
    //    vc?.delegate = self
        vc?.arrTestData = [arrTestList1[buttonRow!]]
        vc?.strTestID = "\(arrTestList1[buttonRow!].TestID)"
        vc?.strTestTitle = "\(arrTestList1[buttonRow!].TestPackageName ?? "")"
        vc?.strStudentTestID = "\(arrTestList1[buttonRow!].StudentTestID)"
        vc?.int_Total_Hint = Int(arrTestList1[buttonRow!].NumberOfHint) ?? 0
        vc?.int_Used_Hint = Int(arrTestList1[buttonRow!].NumberOfHintUsed) ?? 0

        self.navigationController?.pushViewController(vc!, animated: true)

    }
    @IBAction func InfoCloseClicked(_ sender: AnyObject) {
        self.tabBarController?.tabBar.isHidden = false
        viewInfoPopup.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }

//    func sendDataToFirstViewController(myData: String) {
//        DispatchQueue.main.async {
//            if self.arrTestList1[0].StatusName == "Start Test"{
//                self.arrTestList1[0].StatusName = "Resume"
//            }
//            self.tblTestList.reloadData()
//        }
//    }


    @objc func ReStartTestClicked(sender:UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Resume", isFirstTime: "0")
        
        let buttonRow = sender.tag
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
//        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
//        vc?.arrTestData = [arrTestList1[buttonRow]]
//        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
//        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
//        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
//        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
//        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0

        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime) ?? 0.0
        //Bhargav Hide
        ////print(arrTestList1[buttonRow])
       // vc?.delegate = self
        vc?.arrTestData = [arrTestList1[buttonRow]]
        vc?.strTestID = "\(arrTestList1[buttonRow].TestID)"
        vc?.strTestTitle = "\(arrTestList1[buttonRow].TestPackageName ?? "")"
        vc?.strStudentTestID = "\(arrTestList1[buttonRow].StudentTestID ?? 0)"
        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint) ?? 0
        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed) ?? 0

        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @objc func AnalysisTestClicked(sender:UIButton) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Analysis", isFirstTime: "0")
        let buttonRow = sender.tag
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        print("___result",result)
//        let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
//        if strAccountTypeID != "5"
//        {
            //  btnRegisterViewSolution.isHidden = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportVC") as? ReportVC
//            vc!.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
//            vc!.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
//            vc!.strTitle = "\(arrTestList1[buttonRow].testName ?? "")"
       // vc?.statusDelegate = self
        vc?.strTestID = "\(arrTestList1[buttonRow].TestID)"
        vc?.strStudentTestID = "\(arrTestList1[buttonRow].StudentTestID ?? 0)"
        vc?.strStudentTestID = "\(arrTestList1[buttonRow].StudentTestID)"

            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc!, animated: true)
//        }else{
//            //  btnRegisterViewSolution.isHidden = false
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "IntroVC") as? IntroVC
//            vc?.isSelectExam = "1000"
//            self.navigationController?.pushViewController(vc!, animated: false)
//        }


        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportVC") as? ReportVC
        //        vc?.intProdSeconds = Int(arrTestList1[buttonRow].testDuration!) ?? 0
        //        //        vc!.arrPackageDetail = [self.arrHeaderSub3Title[indexPath.row]]
        //        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
        //        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
        //        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
        //        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
        //        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
        //        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
        //        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
