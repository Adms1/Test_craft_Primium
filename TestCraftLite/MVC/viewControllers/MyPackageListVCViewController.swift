//
//  MyPackageListVCViewController.swift
//  TestCraftLite
//
//  Created by ADMS on 04/04/21.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
import SDWebImage

var isSubscription = ""


class MyPackageListVCViewController: UIViewController,ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet weak var tblMyList:UITableView!
    @IBOutlet var lblTitle:UILabel!
    var arrPackageDetail:StandardList?
    var strDisplayMsg = ""
    var arrMyPackageList = [arrTestList]()
    var arrMyTestList = [arrTestList]()
    //    var arrSubPackageList = [PackageDetailsModal]()
    var strPckgID = ""
    var strdisplayType = ""
    var strTitle = ""
    var strTestPackageID = ""
    var strtempBoardID = ""
    var strtempSubjectID = ""
    var strIsCompetitive = ""
    var strtempStandardID = ""
    var strtempStandardName = ""
    var istempSubscription = ""
    var istempPurchesedPackage = ""
    var IsFree = ""
    var isExpired = ""
    var temp_Order_ID = ""
    var temp_PaymentTransaction_ID = ""
    var strPrice = ""
    var strListPrice = ""
    var floatPercentage : CGFloat = 0
    var strProgress = ""

    var totalTest = ""
    var GivenTest = ""

    var CourseTypeID:Int =  -1

    var courseName:String = ""


    @IBOutlet var btnInfo:UIButton!

    var cellLabelHeight:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        isSubscription = ""

        print("strtempSubjectID",strtempSubjectID)
        print("strIsCompetitive",strIsCompetitive)
        print("strtempStandardID",strtempStandardID)
        print("strtempStandardName",strtempStandardName)
        print("istempSubscription",istempSubscription)


        self.tblMyList.showsHorizontalScrollIndicator = false
        self.tblMyList.showsVerticalScrollIndicator = false


        self.lblTitle.text = strTitle

//        tblMyList.rowHeight = UITableView.automaticDimension
//        tblMyList.estimatedRowHeight = 150.0

       // lblTitle.text = strTitle//arrSubPackageList[0].Subject//"My Package"
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1700", comment: "Test Completion Screen", isFirstTime: "0")

        tblMyList.register(UINib(nibName: "TestProgressCell", bundle: nil), forCellReuseIdentifier: "TestProgressCell")
        tblMyList.register(UINib(nibName: "CreateTestCell", bundle: nil), forCellReuseIdentifier: "CreateTestCell")
        tblMyList.register(UINib(nibName: "MyTestListCell", bundle: nil), forCellReuseIdentifier: "MyTestListCell")
        tblMyList.register(UINib(nibName: "MyPackageCell", bundle: nil), forCellReuseIdentifier: "MyPackageCell")
        tblMyList.register(UINib(nibName: "MyHeader", bundle: nil), forCellReuseIdentifier: "MyHeader")
        tblMyList.register(UINib(nibName: "ExpiredCell", bundle: nil), forCellReuseIdentifier: "ExpiredCell")

        btnInfo.setTitle("Expired", for: .normal)
        btnInfo.setImage(nil, for: .normal)
        btnInfo.addShadowWithRadius(0, 8, 0, color: GetColor.ColorGrayF5F5F5)
        btnInfo.backgroundColor = GetColor.ColorGrayF5F5F5
        btnInfo.setTitleColor(GetColor.red, for: .normal)

        if isExpired == "1"// && self.istempSubscription == "1"
        {
            btnInfo.isHidden = true
            IsFree = "0"
        }else{
            btnInfo.isHidden = true
        }


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


//        if UserDefaults.standard.object(forKey: "isLogin") != nil{
//
//        }else{
//            self.tabBarController?.selectedIndex = 0
//        }

        strDisplayMsg = ""
        if isGotoDashBoard == "1"
        {
            BackToDashbord(VC: self)
        }
        //        if UIDevice.current.orientation.isLandscape {
        //            print("landscape")
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        AppUtility.lockOrientation(.portrait)
        //
        //        } else {
        //            print("portrait")
        //        }
      //  var strTemp = "0"
//        if self.strIsCompetitive == "True" || self.strIsCompetitive == "true"
//        {
//            strTemp = "1"
            //            self.Insert_StudentSubscription_API(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(strTemp)")
//            self.Get_Subcription_Course_Price_API(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(strTemp)")

//            print("Competitive")

//        }else{
//            print("Board")

            //            self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(strTemp)")
//            self.Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(strTemp)")

//        }

        //        apiMyPackages()
        //        if istempSubscription == "1"{
        //            self.arrMyPackageList.removeAll()
        //            let TestTypeModel3:PackageDetailsModal = PackageDetailsModal.init(TestPackageID: "", TestPackageName: "My Test", TestPackageDescription: "", TestPackageSalePrice: "", TestPackageListPrice: "", NumberOfTest: "", image: "", selected: "First", packageStartDate: "", packageEndDate: "", Subject: "", TutorId: "", TutorName: "", InstituteName: "", arrTestType: [],isCompetitive: "",std: "",stdId: "", BoardID: "") // old
        //            self.arrMyPackageList.append(TestTypeModel3)
        //            //                    else if arrMyPackageList[indexPath.row].selected == "SubTitle"
        //            let TestTypeModel4:PackageDetailsModal = PackageDetailsModal.init(TestPackageID: "", TestPackageName: "Create Test", TestPackageDescription: "", TestPackageSalePrice: "", TestPackageListPrice: "", NumberOfTest: "", image: "", selected: "SubTitleLast", packageStartDate: "", packageEndDate: "", Subject: "", TutorId: "", TutorName: "", InstituteName: "", arrTestType: [],isCompetitive: "",std: "",stdId: "", BoardID: "") // old
        //            self.arrMyPackageList.append(TestTypeModel4)
        //            self.apiMyCreatedPackages()
        //        }else{
//        self.arrMyPackageList.removeAll()
//        self.arrMyTestList.removeAll()



        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                self.apiMyPackages()
                self.apiGet_StudentTest_Progress_Lite()
            }
        }else{

            self.navigationController?.popViewController(animated: false)
        }


        //        }

//        if isContinuePurchsedFromDetailScreen == "2"
//        {
//            self.Payment_Api(strCoin: self.strPrice)
//        }
        print("strtempBoardID_______",strtempBoardID)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBAction func BackClicked(_ sender: AnyObject) {
        //        SJSwiftSideMenuController.toggleLeftSideMenu()
        //        arrPath.removeLast()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func InfoClicked(_ sender: AnyObject) {
        if isExpired == "1"// && self.istempSubscription == "1"
        {
            SubscribePayPopup()
        }else{
        }
//        self.tabBarController?.tabBar.isHidden = true
//
//        viewInfoPopup.isHidden = false
    }
    func SubscribePayPopup() {
        let alert = UIAlertController(title: "Alert", message: "Your Subscription/ Trial has expried.Please Subscribe to continue your path to Academic Excellence.", preferredStyle: .alert)

        // Add actions
        let action = UIAlertAction(title: "Pay Later", style: .cancel, handler: nil)
        alert.addAction(UIAlertAction(title: "Pay Now", style: .default, handler: { [self](alert: UIAlertAction!) in


            self.arrPackageDetail = StandardList(ID: "\(strtempSubjectID)", Name: courseName, Icon: "", selected: "")




           // var strTemp = "0"
            if self.strIsCompetitive == "True" || self.strIsCompetitive == "true"
            {
               // strTemp = "1"
               // self.Insert_StudentSubscription_API(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(2)")
                Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "0", StandardID: "0", TypeID: "\(2)")
             //   self.Insert_StudentSubscription_API_Buy_Expired_package(CourseID: "\(strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(2)")

                print("Competitive")

            }else{
                print("Board")
                Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(strtempBoardID)", StandardID: "\(strtempStandardID)", TypeID: "\(1)")
               // self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(1)")
              //  self.Insert_StudentSubscription_API_Buy_Expired_package(CourseID: "\(strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(1)")
            }
        }))



        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
}
extension MyPackageListVCViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if isExpired == "1"{
            return 6
        }else{
            return 5
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isExpired == "1"{
            if section  == 0
            {
                return 1
            }else if section == 1
            {
                return 1

            }
            else if section == 2
            {
                return 1
            }else if section == 3
            {
                return arrMyTestList.count
            }else if section == 4{
                if arrMyPackageList.count > 0{
                    return 1
                }else{
                    return 0
                }
            }
            else
            {
                return arrMyPackageList.count
            }
        }else{
            if section  == 0
            {
                return 1
            }else if section == 1
            {
                return 1

            }
            else if section == 2
            {
                return arrMyTestList.count
            }else if section == 3
            {
                if arrMyPackageList.count > 0{
                    return 1
                }else{
                    return 0
                }
            }
            else{
                return arrMyPackageList.count
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if isExpired == "1"{


            if indexPath.section == 0
            {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "ExpiredCell", for: indexPath) as! ExpiredCell
                cell.selectionStyle = .none

//                cell.vwExpiredShadow.layer.masksToBounds = false
//                cell.vwExpiredShadow.layer.shadowOffset = CGSize(width: -1, height: 1)
//                cell.vwExpiredShadow.layer.shadowRadius = 1
//                cell.vwExpiredShadow.layer.shadowOpacity = 0.5
                cell.vwExpiredShadow.layer.cornerRadius = 6
                cell.vwExpiredShadow.layer.masksToBounds = false

                cell.vwExpiredShadow.layer.shadowColor = UIColor.lightGray.cgColor
                cell.vwExpiredShadow.layer.shadowOpacity = 0.5
//                cell.vwExpiredShadow.layer.shadowOffset = CGSize(width: -1, height: 1)
                cell.vwExpiredShadow.layer.shadowOffset = CGSize.zero

                cell.vwExpiredShadow.layer.shadowRadius = 1
//                cell.vwExpiredShadow.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
                cell.vwExpiredShadow.layer.shouldRasterize = true
                cell.vwExpiredShadow.layer.rasterizationScale = UIScreen.main.scale

                cell.btnExpiredBuyClick.addTarget(self,action:#selector(btnPayExpiredClick(sender:)), for: .touchUpInside)

                return cell
            }
            else if indexPath.section == 1
            {

                let cell  = tableView.dequeueReusableCell(withIdentifier: "TestProgressCell", for: indexPath) as! TestProgressCell
    //            cell.topbgView1.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
    //            cell.topbgView1.clipsToBounds = true
                let xPosition = cell.viewProgressTestReport.center.x
                let yPosition = cell.viewProgressTestReport.center.y
                let position = CGPoint(x: xPosition-20, y: yPosition-15)
                //Bhargav Hide
                ////print(position)
                if cell.progressRing == nil
                {
                    //                cell.progressRing.removeFromSuperlayer()
                    cell.progressRing = CircularProgressBar(radius: 50, position: position, innerTrackColor: GetColor.successPopupGreenColor, outerTrackColor: GetColor.lightGrayInnerStart, lineWidth: 10)
                    cell.viewProgressTestReport.layer.addSublayer(cell.progressRing)

                }
                //            cell.viewProgressTestReport.layer.
                //         timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
                //         timer.fire()
                //            cell.progressRing.progress = floatPercentage

                cell.lblAvilableTests.text = "\(totalTest) Test Available"
                cell.lblGivenTest.text = "\(GivenTest) Given Test"

                cell.progressRing.progress = self.floatPercentage //CGFloat(per)//self.count
                cell.progressRing.strProgress = self.strProgress
                cell.btnSummaryReport.tag = indexPath.row
                cell.btnKnowlageGapReport.tag = indexPath.row
                cell.btnKnowlageGapReport.addTarget(self,action:#selector(TestReportClicked(sender:)), for: .touchUpInside)
                cell.btnSummaryReport.addTarget(self,action:#selector(TestSummaryReportClicked(sender:)), for: .touchUpInside)

                cell.selectionStyle = .none
                return cell



            }
            else if indexPath.section == 2
            {

                let cell  = tableView.dequeueReusableCell(withIdentifier: "CreateTestCell", for: indexPath) as! CreateTestCell
                cell.selectionStyle = .none
                cell.vwCreate.layer.cornerRadius = 6.0
                cell.vwCreate.layer.masksToBounds = true
                cell.btnCreateTest.addTarget(self,action:#selector(CreateTestClicked(sender:)), for: .touchUpInside)
                return cell


            }
            else if indexPath.section == 3
            {

                let cell  = tableView.dequeueReusableCell(withIdentifier: "MyTestListCell", for: indexPath) as! MyTestListCell

                cell.selectionStyle = .none

                if arrMyTestList.count - 1 == indexPath.row{
                    cell.vwCreateLine.isHidden = true
                }else{
                    cell.vwCreateLine.isHidden = false
                }

                if arrMyTestList.count <= 1{
    //                cell.vwCreateList.roundCorners([.topLeft, .topRight], radius: 6)
    //                cell.vwCreateList.roundCorners([.bottomLeft, .bottomRight], radius: 6)

                                    cell.vwCreateList.layer.cornerRadius = 6.0
                                    cell.vwCreateList.layer.masksToBounds = true

                }else{
                    if indexPath.row == 0{
                        cell.vwCreateList.roundCorners([.topLeft, .topRight], radius: 6)
                    }else if indexPath.row == arrMyTestList.count - 1{
                        cell.vwCreateList.roundCorners([.bottomLeft, .bottomRight], radius: 6)
                    }
                }




                if arrMyTestList.count > 0{
                    if arrMyTestList[indexPath.row].StatusName == "Start Test"{
                        cell.imgCreateTestAnalysis.image = UIImage(named: "white_play.png")
                    }else if arrMyTestList[indexPath.row].StatusName == "Resume"{
                        cell.imgCreateTestAnalysis.image = UIImage(named: "Group 80.png")
                    }else if arrMyTestList[indexPath.row].StatusName == "Analyse"{
                        cell.imgCreateTestAnalysis.image = UIImage(named: "white_analysis.png.png")
                    }

                    cell.lblTestNAme.text = arrMyTestList[indexPath.row].TestPackageName
                    cell.lblTime.text = "Time :\(arrMyTestList[indexPath.row].TestDuration)"
                    cell.lblMarks.text = "Marks :\(arrMyTestList[indexPath.row].TotalQuestions)"


    //                cell.imgOfCreateTestSubject.sd_setImage(with: URL(string: API.imageUrl + arrMyTestList[indexPath.row].Icon))

                }


    //            else if arrMyTestList[indexPath.row].StatusName == "Resume"{
    //                cell.imgCreateTestAnalysis.image = UIImage(named: "Group 40.png")
    //            }




                if cellLabelHeight == true {
                    cellLabelHeight = false
    //                cell.vwCreateList.layer.cornerRadius = 6.0
    //                cell.vwCreateList.layer.masksToBounds = true

                }else{
                    cell.lblMyTestHeight.constant = 0
                    cell.vwTotalHeight.constant = 79

    //                cell.vwCreateList.layer.cornerRadius = 0.0
    //                cell.vwCreateList.layer.masksToBounds = true

                }

    //            if (indexPath.row  == 0)
    //            {
    //                self.roundCorners(view: cell, corners: [.topLeft, .bottomLeft], radius: 6.0)
    //            }
    //            else if (indexPath.row  == arrMyTestList.count - 1){
    //
    //                self.roundCorners(view: cell, corners: [.topRight, .bottomRight], radius: 6.0)
    //
    //            }


                cell.layer.cornerRadius = 6.0
                cell.layer.masksToBounds = true



              //  cell.lblTestNAme.text = arrMyTestList[indexPath.row].TestPackageName

                cell.imgOfCreateTestSubject.layer.cornerRadius = cell.imgOfCreateTestSubject.layer.frame.width / 2.0
                cell.imgOfCreateTestSubject.layer.masksToBounds = true

                cell.imgCreateTestAnalysis.layer.cornerRadius = cell.imgCreateTestAnalysis.layer.frame.width / 2.0
                cell.imgCreateTestAnalysis.layer.masksToBounds = true


                cell.imgOfCreateTestSubject.layer.borderWidth = 1.0
                cell.imgOfCreateTestSubject.layer.borderColor = UIColor.white.cgColor


                return cell




            }else if indexPath.section == 4{
                let cell  = tableView.dequeueReusableCell(withIdentifier: "MyHeader", for: indexPath) as! MyHeader
    //            cell.topbgView1.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
    //            cell.topbgView1.clipsToBounds = true
                cell.lblHeader.text = "Single Test"
                return cell
            }
            else{
                let cell  = tableView.dequeueReusableCell(withIdentifier: "MyPackageCell", for: indexPath) as! MyPackageCell
                cell.selectionStyle = .none


                if arrMyPackageList.count > 0
                {
                    if arrMyPackageList[indexPath.row].IsFree == "1"{
                        cell.btnBuyClick.isHidden = true
                        cell.imgAnalysis.isHidden = false
                        if arrMyPackageList[indexPath.row].StatusName == "Start Test"{
                            cell.imgAnalysis.image = UIImage(named: "StartIcon.png")
                        }else if arrMyPackageList[indexPath.row].StatusName == "Resume"{
                            cell.imgAnalysis.image = UIImage(named: "Group 79.png")
                        }else if arrMyPackageList[indexPath.row].StatusName == "Analyse"{
                            cell.imgAnalysis.image = UIImage(named: "CompleteTestIcon.png")
                        }
                        cell.lblAttemptTotalTest.isHidden = false
                        cell.lblPackagePrice.isHidden = true

                    }else{


                        // temporary hide
//                        cell.btnBuyClick.isHidden = true
//                        cell.lblPackagePrice.isHidden = true

                        cell.btnBuyClick.isHidden = false
                        cell.imgAnalysis.isHidden = true
                        cell.lblPackagePrice.isHidden = false
                        cell.lblPackagePrice.text = "Price :" + "₹"+"\(arrMyPackageList[indexPath.row].Price)"
    //                    cell.lblAttemptTotalTest.isHidden = true
    //                    cell.lblAttemptTotalTest.text = "Marks :\(arrMyPackageList[indexPath.row].TotalQuestions)"

                    }

                    cell.btnBuyClick.layer.cornerRadius = cell.btnBuyClick.layer.frame.height / 2
                    cell.btnBuyClick.layer.masksToBounds = true

                    cell.btnBuyClick.addTarget(self, action:#selector(btnBuyClickEvent(_:)), for: .touchUpInside)

                    cell.btnBuyClick.tag = indexPath.row
                    cell.lblTestName.text = arrMyPackageList[indexPath.row].TestName
                    cell.lblTestSubjectName.text = "Time :\(arrMyPackageList[indexPath.row].TestDuration)"
                    cell.lblAttemptTotalTest.text = "Marks :\(arrMyPackageList[indexPath.row].TestMarks)"

                    if arrMyPackageList[indexPath.row].TutorName == "Testcraft"
                    {
                        cell.lblTutorname.isHidden = true

                    }else{
                        cell.lblTutorname.isHidden = false
                        cell.lblTutorname.text = arrMyPackageList[indexPath.row].TutorName
                    }

    //                cell.imgOfSubject.layer.borderWidth = 1.0
    //                cell.imgOfSubject.layer.borderColor = UIColor.white.cgColor

                    cell.imgOfSubject.sd_setImage(with: URL(string: API.imageUrl + arrMyPackageList[indexPath.row].Icon))

                    cell.imgOfSubject.layer.cornerRadius = cell.imgOfSubject.layer.frame.width / 2.0
                    cell.imgOfSubject.layer.masksToBounds = true
                }

                return cell
            }

        }else{

            if indexPath.section == 0
            {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "TestProgressCell", for: indexPath) as! TestProgressCell
    //            cell.topbgView1.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
    //            cell.topbgView1.clipsToBounds = true
                let xPosition = cell.viewProgressTestReport.center.x
                let yPosition = cell.viewProgressTestReport.center.y
                let position = CGPoint(x: xPosition-20, y: yPosition-15)
                //Bhargav Hide
                ////print(position)
                if cell.progressRing == nil
                {
                    //                cell.progressRing.removeFromSuperlayer()
                    cell.progressRing = CircularProgressBar(radius: 50, position: position, innerTrackColor: GetColor.successPopupGreenColor, outerTrackColor: GetColor.lightGrayInnerStart, lineWidth: 10)
                    cell.viewProgressTestReport.layer.addSublayer(cell.progressRing)

                }
                //            cell.viewProgressTestReport.layer.
                //         timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
                //         timer.fire()
                //            cell.progressRing.progress = floatPercentage

                cell.lblAvilableTests.text = "\(totalTest) Test Available"
                cell.lblGivenTest.text = "\(GivenTest) Given Test"

                cell.progressRing.progress = self.floatPercentage //CGFloat(per)//self.count
                cell.progressRing.strProgress = self.strProgress
                cell.btnSummaryReport.tag = indexPath.row
                cell.btnKnowlageGapReport.tag = indexPath.row
                cell.btnKnowlageGapReport.addTarget(self,action:#selector(TestReportClicked(sender:)), for: .touchUpInside)
                cell.btnSummaryReport.addTarget(self,action:#selector(TestSummaryReportClicked(sender:)), for: .touchUpInside)

                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.section == 1
            {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "CreateTestCell", for: indexPath) as! CreateTestCell
                cell.selectionStyle = .none
                cell.vwCreate.layer.cornerRadius = 6.0
                cell.vwCreate.layer.masksToBounds = true
                cell.btnCreateTest.addTarget(self,action:#selector(CreateTestClicked(sender:)), for: .touchUpInside)
                return cell
            }
            else if indexPath.section == 2
            {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "MyTestListCell", for: indexPath) as! MyTestListCell

                cell.selectionStyle = .none

                if arrMyTestList.count - 1 == indexPath.row{
                    cell.vwCreateLine.isHidden = true
                }else{
                    cell.vwCreateLine.isHidden = false
                }

                if arrMyTestList.count <= 1{
    //                cell.vwCreateList.roundCorners([.topLeft, .topRight], radius: 6)
    //                cell.vwCreateList.roundCorners([.bottomLeft, .bottomRight], radius: 6)

                                    cell.vwCreateList.layer.cornerRadius = 6.0
                                    cell.vwCreateList.layer.masksToBounds = true

                }else{
                    if indexPath.row == 0{
                        cell.vwCreateList.roundCorners([.topLeft, .topRight], radius: 6)
                    }else if indexPath.row == arrMyTestList.count - 1{
                        cell.vwCreateList.roundCorners([.bottomLeft, .bottomRight], radius: 6)
                    }
                }




                if arrMyTestList.count > 0{
                    if arrMyTestList[indexPath.row].StatusName == "Start Test"{
                        cell.imgCreateTestAnalysis.image = UIImage(named: "white_play.png")
                    }else if arrMyTestList[indexPath.row].StatusName == "Resume"{
                        cell.imgCreateTestAnalysis.image = UIImage(named: "Group 80.png")
                    }else if arrMyTestList[indexPath.row].StatusName == "Analyse"{
                        cell.imgCreateTestAnalysis.image = UIImage(named: "white_analysis.png.png")
                    }

                    cell.lblTestNAme.text = arrMyTestList[indexPath.row].TestPackageName
                    cell.lblTime.text = "Time :\(arrMyTestList[indexPath.row].TestDuration)"
                    cell.lblMarks.text = "Marks :\(arrMyTestList[indexPath.row].TotalQuestions)"


    //                cell.imgOfCreateTestSubject.sd_setImage(with: URL(string: API.imageUrl + arrMyTestList[indexPath.row].Icon))

                }


    //            else if arrMyTestList[indexPath.row].StatusName == "Resume"{
    //                cell.imgCreateTestAnalysis.image = UIImage(named: "Group 40.png")
    //            }




                if cellLabelHeight == true {
                    cellLabelHeight = false
    //                cell.vwCreateList.layer.cornerRadius = 6.0
    //                cell.vwCreateList.layer.masksToBounds = true

                }else{
                    cell.lblMyTestHeight.constant = 0
                    cell.vwTotalHeight.constant = 79

    //                cell.vwCreateList.layer.cornerRadius = 0.0
    //                cell.vwCreateList.layer.masksToBounds = true

                }

    //            if (indexPath.row  == 0)
    //            {
    //                self.roundCorners(view: cell, corners: [.topLeft, .bottomLeft], radius: 6.0)
    //            }
    //            else if (indexPath.row  == arrMyTestList.count - 1){
    //
    //                self.roundCorners(view: cell, corners: [.topRight, .bottomRight], radius: 6.0)
    //
    //            }


                cell.layer.cornerRadius = 6.0
                cell.layer.masksToBounds = true



              //  cell.lblTestNAme.text = arrMyTestList[indexPath.row].TestPackageName

                cell.imgOfCreateTestSubject.layer.cornerRadius = cell.imgOfCreateTestSubject.layer.frame.width / 2.0
                cell.imgOfCreateTestSubject.layer.masksToBounds = true

                cell.imgCreateTestAnalysis.layer.cornerRadius = cell.imgCreateTestAnalysis.layer.frame.width / 2.0
                cell.imgCreateTestAnalysis.layer.masksToBounds = true


                cell.imgOfCreateTestSubject.layer.borderWidth = 1.0
                cell.imgOfCreateTestSubject.layer.borderColor = UIColor.white.cgColor


                return cell
            }
            else if indexPath.section == 3
            {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "MyHeader", for: indexPath) as! MyHeader
    //            cell.topbgView1.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
    //            cell.topbgView1.clipsToBounds = true
                cell.lblHeader.text = "Single Test"
                return cell
            }
            else{
                let cell  = tableView.dequeueReusableCell(withIdentifier: "MyPackageCell", for: indexPath) as! MyPackageCell
                cell.selectionStyle = .none


                if arrMyPackageList.count > 0
                {
                    if arrMyPackageList[indexPath.row].IsFree == "1"{
                        cell.btnBuyClick.isHidden = true
                        cell.imgAnalysis.isHidden = false
                        if arrMyPackageList[indexPath.row].StatusName == "Start Test"{
                            cell.imgAnalysis.image = UIImage(named: "StartIcon.png")
                        }else if arrMyPackageList[indexPath.row].StatusName == "Resume"{
                            cell.imgAnalysis.image = UIImage(named: "Group 79.png")
                        }else if arrMyPackageList[indexPath.row].StatusName == "Analyse"{
                            cell.imgAnalysis.image = UIImage(named: "CompleteTestIcon.png")
                        }
                        cell.lblAttemptTotalTest.isHidden = false
                        cell.lblPackagePrice.isHidden = true

                    }else{


                        // temporary hide
//                        cell.btnBuyClick.isHidden = true
//                        cell.lblPackagePrice.isHidden = true

                        cell.btnBuyClick.isHidden = false
                        cell.imgAnalysis.isHidden = true
                        cell.lblPackagePrice.isHidden = false
                        cell.lblPackagePrice.text = "Price :" + "₹"+"\(arrMyPackageList[indexPath.row].Price)"

                    }

                    cell.btnBuyClick.layer.cornerRadius = cell.btnBuyClick.layer.frame.height / 2
                    cell.btnBuyClick.layer.masksToBounds = true

                    cell.btnBuyClick.addTarget(self, action:#selector(btnBuyClickEvent(_:)), for: .touchUpInside)

                    cell.btnBuyClick.tag = indexPath.row
                    cell.lblTestName.text = arrMyPackageList[indexPath.row].TestName
                    cell.lblTestSubjectName.text = "Time :\(arrMyPackageList[indexPath.row].TestDuration)"
                    cell.lblAttemptTotalTest.text = "Marks :\(arrMyPackageList[indexPath.row].TestMarks)"

    //                cell.imgOfSubject.layer.borderWidth = 1.0
    //                cell.imgOfSubject.layer.borderColor = UIColor.white.cgColor

                    if arrMyPackageList[indexPath.row].TutorName == "Testcraft"
                    {
                        cell.lblTutorname.isHidden = true

                    }else{
                        cell.lblTutorname.isHidden = false
                        cell.lblTutorname.text = arrMyPackageList[indexPath.row].TutorName
                    }

                    cell.imgOfSubject.sd_setImage(with: URL(string: API.imageUrl + arrMyPackageList[indexPath.row].Icon))

                    cell.imgOfSubject.layer.cornerRadius = cell.imgOfSubject.layer.frame.width / 2.0
                    cell.imgOfSubject.layer.masksToBounds = true
                }

                return cell
            }

        }
    }

    @objc func btnBuyClickEvent(_ sender:UIButton)
    {
        if arrMyPackageList[sender.tag].Price != "" && arrMyPackageList[sender.tag].Price != "0"{
            strTestPackageID = "\(arrMyPackageList[sender.tag].TestPackageID)"
            AddTocart_Api(strCoin: arrMyPackageList[sender.tag].Price)
            IsFree = "\(arrMyPackageList[sender.tag].IsFree)"


            arrPackageDetail = StandardList(ID: "\(arrMyPackageList[sender.tag].TestID)", Name: arrMyPackageList[sender.tag].TestPackageName, Icon: "", selected: "")
        }

    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        <#code#>
//    }
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section  == 3
//        {
//            return 50
//        }
//        return 0
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
//
//        let label = UILabel()
//        label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//        label.text = "Tests"
//        label.font = .systemFont(ofSize: 16)
//        label.textColor = .black
//
//        headerView.addSubview(label)
//
//        return headerView
//
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if isExpired == "1"{

            if (indexPath.section  == 5){
    //            if isExpired == "1"// && self.istempSubscription == "1"
    //            {
    //                SubscribePayPopup()
    //            }else{

                if arrMyPackageList[indexPath.row].IsFree == "1"
                {

                    if arrMyPackageList[indexPath.row].StatusName == "Start Test"{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestListVC") as? TestListVC
                                vc!.arrTestList1 = [self.arrMyPackageList[indexPath.row]]
                        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
                        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
                        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
                        isSubscription = ""
                        vc!.strPackageID = "\(arrMyPackageList[indexPath.row].TestID)"
                        vc!.strSetTitle = "\(arrMyPackageList[indexPath.row].TestPackageName)"//TestPackageName
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }else if arrMyPackageList[indexPath.row].StatusName == "Analyse"{
                        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Analysis", isFirstTime: "0")
                       // let buttonRow = sender.tag
                        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                        print("___result",result)
                //        let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
                //        if strAccountTypeID != "5"
                //        {
                            //  btnRegisterViewSolution.isHidden = true
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportVC") as? ReportVC
                        vc!.strTestID = "\(arrMyPackageList[indexPath.row].TestID)"
                        vc!.strStudentTestID = "\(arrMyPackageList[indexPath.row].StudentTestID)"
                        vc!.strTitle = "\(arrMyPackageList[indexPath.row].TestName)"
                            self.tabBarController?.tabBar.isHidden = true
                            self.navigationController?.pushViewController(vc!, animated: true)

                    }
                    else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
                //        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
                //        vc?.arrTestData = [arrTestList1[buttonRow]]
                //        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
                //        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
                //        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
                //        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
                //        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0

                        vc?.intProdSeconds = Float(arrMyPackageList[indexPath.row].RemainTime) ?? 0.0
                        //Bhargav Hide
                        ////print(arrTestList1[buttonRow])
                      //  vc?.delegate = self
                        vc?.arrTestData = [arrMyPackageList[indexPath.row]]
                        vc?.strTestID = "\(arrMyPackageList[indexPath.row].TestID)"
                        vc?.strTestTitle = "\(arrMyPackageList[indexPath.row].TestPackageName ?? "")"
                        vc?.strStudentTestID = "\(arrMyPackageList[indexPath.row].StudentTestID ?? 0)"
                        vc?.int_Total_Hint = Int(arrMyPackageList[indexPath.row].NumberOfHint) ?? 0
                        vc?.int_Used_Hint = Int(arrMyPackageList[indexPath.row].NumberOfHintUsed) ?? 0
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }
                }
                // tempory hide test buy code
                else{
                    if arrMyPackageList[indexPath.row].Price != "" && arrMyPackageList[indexPath.row].Price != "0"{
                        strTestPackageID = "\(arrMyPackageList[indexPath.row].TestPackageID)"
                        AddTocart_Api(strCoin: arrMyPackageList[indexPath.row].Price)
                        IsFree = "\(arrMyPackageList[indexPath.row].IsFree)"


                        arrPackageDetail = StandardList(ID: "\(arrMyPackageList[indexPath.row].TestID)", Name: arrMyPackageList[indexPath.row].TestPackageName, Icon: "", selected: "")
                    }
                }
               // }
            }else if (indexPath.section  == 3){
                if isExpired == "1"// && self.istempSubscription == "1"
                {
                    SubscribePayPopup()
                }else{



                    if arrMyTestList[indexPath.row].StatusName == "Start Test"{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestListVC") as? TestListVC
                                vc!.arrTestList1 = [self.arrMyTestList[indexPath.row]]
                        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
                        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
                        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
                        isSubscription = ""
                        vc!.strPackageID = "\(arrMyTestList[indexPath.row].TestID)"
                        vc!.strSetTitle = "\(arrMyTestList[indexPath.row].TestPackageName)"//TestPackageName
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
                //        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
                //        vc?.arrTestData = [arrTestList1[buttonRow]]
                //        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
                //        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
                //        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
                //        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
                //        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0

                        vc?.intProdSeconds = Float(arrMyTestList[indexPath.row].RemainTime) ?? 0.0
                        //Bhargav Hide
                        ////print(arrTestList1[buttonRow])
                      //  vc?.delegate = self
                        vc?.arrTestData = [arrMyTestList[indexPath.row]]
                        vc?.strTestID = "\(arrMyTestList[indexPath.row].TestID)"
                        vc?.strTestTitle = "\(arrMyTestList[indexPath.row].TestPackageName ?? "")"
                        vc?.strStudentTestID = "\(arrMyTestList[indexPath.row].StudentTestID ?? 0)"
                        vc?.int_Total_Hint = Int(arrMyTestList[indexPath.row].NumberOfHint) ?? 0
                        vc?.int_Used_Hint = Int(arrMyTestList[indexPath.row].NumberOfHintUsed) ?? 0
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }


    //                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestListVC") as? TestListVC
    //                        vc!.arrTestList1 = [self.arrMyTestList[indexPath.row]]
    //                //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
    //                //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
    //                //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
    //                isSubscription = ""
    //                vc!.strPackageID = "\(arrMyTestList[indexPath.row].TestID)"
    //                vc!.strSetTitle = "\(arrMyTestList[indexPath.row].TestPackageName)"//TestPackageName
    //                self.navigationController?.pushViewController(vc!, animated: true)
                }
            }

        }else{
            if (indexPath.section  == 4){
    //            if isExpired == "1"// && self.istempSubscription == "1"
    //            {
    //                SubscribePayPopup()
    //            }else{

                if arrMyPackageList[indexPath.row].IsFree == "1"
                {

                    if arrMyPackageList[indexPath.row].StatusName == "Start Test"{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestListVC") as? TestListVC
                                vc!.arrTestList1 = [self.arrMyPackageList[indexPath.row]]
                        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
                        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
                        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
                        isSubscription = ""
                        vc!.strPackageID = "\(arrMyPackageList[indexPath.row].TestID)"
                        vc!.strSetTitle = "\(arrMyPackageList[indexPath.row].TestPackageName)"//TestPackageName
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }else if arrMyPackageList[indexPath.row].StatusName == "Analyse"{
                        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1901", comment: "Analysis", isFirstTime: "0")
                       // let buttonRow = sender.tag
                        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                        print("___result",result)
                //        let strAccountTypeID = "\(result.value(forKey: "AccountTypeID") ?? "")"
                //        if strAccountTypeID != "5"
                //        {
                            //  btnRegisterViewSolution.isHidden = true
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReportVC") as? ReportVC
                        vc!.strTestID = "\(arrMyPackageList[indexPath.row].TestID)"
                        vc!.strStudentTestID = "\(arrMyPackageList[indexPath.row].StudentTestID)"
                        vc!.strTitle = "\(arrMyPackageList[indexPath.row].TestName)"
                            self.tabBarController?.tabBar.isHidden = true
                            self.navigationController?.pushViewController(vc!, animated: true)

                    }
                    else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
                //        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
                //        vc?.arrTestData = [arrTestList1[buttonRow]]
                //        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
                //        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
                //        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
                //        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
                //        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0

                        vc?.intProdSeconds = Float(arrMyPackageList[indexPath.row].RemainTime) ?? 0.0
                        //Bhargav Hide
                        ////print(arrTestList1[buttonRow])
                      //  vc?.delegate = self
                        vc?.arrTestData = [arrMyPackageList[indexPath.row]]
                        vc?.strTestID = "\(arrMyPackageList[indexPath.row].TestID)"
                        vc?.strTestTitle = "\(arrMyPackageList[indexPath.row].TestPackageName ?? "")"
                        vc?.strStudentTestID = "\(arrMyPackageList[indexPath.row].StudentTestID ?? 0)"
                        vc?.int_Total_Hint = Int(arrMyPackageList[indexPath.row].NumberOfHint) ?? 0
                        vc?.int_Used_Hint = Int(arrMyPackageList[indexPath.row].NumberOfHintUsed) ?? 0
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }


                }
                // tempory hide test buy
                else{

                    if arrMyPackageList[indexPath.row].Price != "" && arrMyPackageList[indexPath.row].Price != "0"{
                        strTestPackageID = "\(arrMyPackageList[indexPath.row].TestPackageID)"
                        AddTocart_Api(strCoin: arrMyPackageList[indexPath.row].Price)
                        IsFree = "\(arrMyPackageList[indexPath.row].IsFree)"


                        arrPackageDetail = StandardList(ID: "\(arrMyPackageList[indexPath.row].TestID)", Name: arrMyPackageList[indexPath.row].TestPackageName, Icon: "", selected: "")
                    }

                }
               // }
            }else if (indexPath.section  == 2){
                if isExpired == "1"// && self.istempSubscription == "1"
                {
                    SubscribePayPopup()
                }else{



                    if arrMyTestList[indexPath.row].StatusName == "Start Test"{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestListVC") as? TestListVC
                                vc!.arrTestList1 = [self.arrMyTestList[indexPath.row]]
                        //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
                        //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
                        //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
                        isSubscription = ""
                        vc!.strPackageID = "\(arrMyTestList[indexPath.row].TestID)"
                        vc!.strSetTitle = "\(arrMyTestList[indexPath.row].TestPackageName)"//TestPackageName
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Question1VC") as? Question1VC
                //        vc?.intProdSeconds = Float(arrTestList1[buttonRow].RemainTime!) ?? 0
                //        vc?.arrTestData = [arrTestList1[buttonRow]]
                //        vc?.strTestID = "\(arrTestList1[buttonRow].testID ?? "")"
                //        vc?.strTestTitle = "\(arrTestList1[buttonRow].testName ?? "")"
                //        vc?.strStudentTestID = "\(arrTestList1[buttonRow].studentTestID ?? "")"
                //        vc?.int_Total_Hint = Int(arrTestList1[buttonRow].NumberOfHint!) ?? 0
                //        vc?.int_Used_Hint = Int(arrTestList1[buttonRow].NumberOfHintUsed!) ?? 0

                        vc?.intProdSeconds = Float(arrMyTestList[indexPath.row].RemainTime) ?? 0.0
                        //Bhargav Hide
                        ////print(arrTestList1[buttonRow])
                      //  vc?.delegate = self
                        vc?.arrTestData = [arrMyTestList[indexPath.row]]
                        vc?.strTestID = "\(arrMyTestList[indexPath.row].TestID)"
                        vc?.strTestTitle = "\(arrMyTestList[indexPath.row].TestPackageName ?? "")"
                        vc?.strStudentTestID = "\(arrMyTestList[indexPath.row].StudentTestID ?? 0)"
                        vc?.int_Total_Hint = Int(arrMyTestList[indexPath.row].NumberOfHint) ?? 0
                        vc?.int_Used_Hint = Int(arrMyTestList[indexPath.row].NumberOfHintUsed) ?? 0
                        self.navigationController?.pushViewController(vc!, animated: true)

                    }


    //                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TestListVC") as? TestListVC
    //                        vc!.arrTestList1 = [self.arrMyTestList[indexPath.row]]
    //                //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
    //                //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
    //                //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
    //                isSubscription = ""
    //                vc!.strPackageID = "\(arrMyTestList[indexPath.row].TestID)"
    //                vc!.strSetTitle = "\(arrMyTestList[indexPath.row].TestPackageName)"//TestPackageName
    //                self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        }
    }




//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row  == 0
//                {
//                    return 150
//                }else if indexPath.row == 1
//                {
//                    return 100
//
//                }
//                else if indexPath.row == 2
//                {
//                    return 82
//                }else{
//                    return 80
//                }
//    }
//        if indexPath.row  == 0
//        {
//            return 121
//        }else if indexPath.row == 1
//        {
//            return 73
//
//        }
//        else if indexPath.row == 2
//        {
//            return 86
//        }else{
//            return 80
//        }
//    }

//    func SubscribePayPopup() {
//        let alert = UIAlertController(title: "Alert", message: "Your Subscription Has Expired..", preferredStyle: .alert)
//
//        // Add actions
//        let action = UIAlertAction(title: "Pay Later", style: .cancel, handler: nil)
//        alert.addAction(UIAlertAction(title: "Pay Now", style: .default, handler: {(alert: UIAlertAction!) in
//
//            var strTemp = "0"
//            if self.strIsCompetitive == "True" || self.strIsCompetitive == "true"
//            {
//                strTemp = "1"
//                self.Insert_StudentSubscription_API(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(strTemp)")
//
//                print("Competitive")
//
//            }else{
//                print("Board")
//
//                self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(strTemp)")
//            }
//        }))
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
//
//    }


}
extension MyPackageListVCViewController{
    @objc func TestReportClicked(sender:UIButton) {


        if self.GivenTest == "0"{
            self.view.makeToast("Please complete any test to see the report", duration: 3.0, position: .bottom)

        }else{


            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1701", comment: "Knowledge Gap", isFirstTime: "0")

            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
            vc?.strTitle = "Knowledge Gap"
            if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
            {
                let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

                if strIsCompetitive == "True" || strIsCompetitive == "true"
                {
                    //                SubjectSummaryReport.aspx?IsCompetitive=1&CourseID=3&StudentID=36

                    vc?.strLoadUrl = "\(API.KnowledgeGepReport)?IsCompetitive=1&CourseID=\(self.strtempSubjectID)&StudentID=\(result["StudentID"] ?? "")"//TestPackageSummaryReport.aspx?STPID=\(self.strtempSubjectID)"
                }
                else
                {
                    vc?.strLoadUrl = "\(API.KnowledgeGepReport)?IsCompetitive=0&StandardID=\(self.strtempStandardID)&SubjectID=\(self.strtempSubjectID)&StudentID=\(result["StudentID"] ?? "")"


                }
            }//"\(API.hostName)TestSummaryReport.aspx?STID=\(self.strStudentTestID)"
            self.navigationController?.pushViewController(vc!, animated: true)

        }


        //Bhargav Hide
        ////print("Report")
        //        let buttonRow = sender.tag

        //        ["StudentID":"\(result["StudentID"] ?? "")",
        //        "SubjectID":strtempSubjectID, "isCompetitive":strTemp]

        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
        //        vc?.strTitle = "Test Summary Report"
        //        vc?.strLoadUrl = "\(API.hostName)TestSummaryReport.aspx?STID=\(self.strtempSubjectID)&chap=1"
        //        self.navigationController?.pushViewController(vc!, animated: true)
        //SubjectSummaryReport.aspx?IsCompetitive=0&StandardID=9&SubjectID=1&StudentID=36

    }
    @objc func btnPayExpiredClick(sender:UIButton) {
            SubscribePayPopup()
    }
    @objc func CreateTestClicked(sender:UIButton) {
        //Bhargav Hide
        ////print("Report")
        if isExpired == "1"{
            SubscribePayPopup()
            //                let alert = AlertController(title: "Alert", message: "Your Subscription Has Expired..", preferredStyle: .alert)
            //
            //                // Add actions
            //                let action = UIAlertAction(title: "Pay Later", style: .cancel, handler: nil)
            //                alert.addAction(UIAlertAction(title: "Pay Now", style: .default, handler: {(alert: UIAlertAction!) in
            ////                    if self.CategoryID == "1" //PopCategoryID == "1"
            ////                    {
            ////
            ////                        self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.PopCategoryID1)", StandardID: "\(self.PopCategoryID2)", TypeID: "\(self.PopCategoryID)")
            ////
            ////                    }
            ////
            ////                    else
            ////                    {
            ////                        self.Insert_StudentSubscription_API(CourseID: "\(self.PopCategoryID1)", BoardID: "0", StandardID: "0", TypeID: "\(self.PopCategoryID)")
            ////
            ////                    }
            //
            //                    var strTemp = "0"
            //                    if self.strIsCompetitive == "True" || self.strIsCompetitive == "true"
            //                    {
            //                        strTemp = "1"
            //                        self.Insert_StudentSubscription_API(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(strTemp)")
            //
            //                        print("Competitive")
            ////                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateTestCompetitveVC") as? CreateTestCompetitveVC
            ////                        vc?.strTitle            = self.strTitle
            ////                        vc?.strtempBoardID      = self.strtempBoardID
            ////                        vc?.strtempSubjectID    = self.strtempSubjectID
            ////                        vc?.strIsCompetitive    = strTemp
            ////                        vc?.strtempStandardID   = self.strtempStandardID
            ////                        vc?.strtempStandardName = self.strtempStandardName
            ////                        self.navigationController?.pushViewController(vc!, animated: true)
            //
            //                    }else{
            //                        print("Board")
            //
            //                        self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(strTemp)")
            //
            ////                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateTestVC") as? CreateTestVC
            ////                        vc?.strTitle            = self.strTitle
            ////                        vc?.strtempBoardID      = self.strtempBoardID
            ////                        vc?.strtempSubjectID    = self.strtempSubjectID
            ////                        vc?.strIsCompetitive    = strTemp
            ////                        vc?.strtempStandardID   = self.strtempStandardID
            ////                        vc?.strtempStandardName = self.strtempStandardName
            ////                        self.navigationController?.pushViewController(vc!, animated: true)
            //                    }
            //
            //
            //                }))
            //                alert.addAction(action)
            //                present(alert, animated: true, completion: nil)

        }
        else
        {

            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "4300", comment: "Create my test button", isFirstTime: "0")


            var strTemp = "0"
            if strIsCompetitive == "True" || strIsCompetitive == "true"
            {
                strTemp = "1"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateTestCompetitveVC") as? CreateTestCompetitveVC
                vc?.strTitle            = self.strTitle
                vc?.strtempBoardID      = self.strtempBoardID
                vc?.strtempSubjectID    = self.strtempSubjectID
                vc?.strIsCompetitive    = strTemp
                vc?.strtempStandardID   = self.strtempStandardID
                vc?.strtempStandardName = self.strtempStandardName
                self.navigationController?.pushViewController(vc!, animated: true)

            }else{

                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateTestVC") as? CreateTestVC
                vc?.strTitle            = self.strTitle
                vc?.strtempBoardID      = self.strtempBoardID
                vc?.strtempSubjectID    = self.strtempSubjectID
                vc?.strIsCompetitive    = strTemp
                vc?.strtempStandardID   = self.strtempStandardID
                vc?.strtempStandardName = self.strtempStandardName
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    @objc func TestSummaryReportClicked(sender:UIButton) {
        //Bhargav Hide
        ////print("Report")
        //        let buttonRow = sender.tag
        //            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "1701", comment: "Summary Report", isFirstTime: "0")



        if self.GivenTest != "0"{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InvoiceListVC") as? InvoiceListVC
            vc?.strTitle = "Summary Report"
            if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
            {
                let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

                if strIsCompetitive == "True" || strIsCompetitive == "true"
                {
                    //                SubjectSummaryReport.aspx?IsCompetitive=1&CourseID=3&StudentID=36

                    vc?.strLoadUrl = "\(API.TestSummaryReport)?StudentID=\(result["StudentID"] ?? "")&StandardID=0&SubjectID=0&CourseID=\(self.strtempSubjectID)&IsCompetitive=1"

                    //http://demowebservice.testcraft.in/AllTestSummaryReport.aspx?StudentID=100&StandardID=0&SubjectID=0&CourseID=4&IsCompetitive=1
                    //                    https://webservice.testcraft.in/AllTestSummaryReport.aspx?StudentID=1383&StandardID=0&SubjectID=0&CourseID=7&IsCompetitive=1

                    //                    vc?.strLoadUrl = "\(API.TestSummaryReport)IsCompetitive=1&CourseID=\(self.strtempSubjectID)&StudentID=\(result["StudentID"] ?? "")" //TestPackageSummaryReport.aspx?STPID=\(self.strtempSubjectID)"
                }
                else
                {
                    //                    vc?.strLoadUrl = "\(API.TestSummaryReport)?IsCompetitive=0&StandardID=\(self.strtempStandardID)&SubjectID=\(self.strtempSubjectID)&StudentID=\(result["StudentID"] ?? "")"
                    vc?.strLoadUrl = "\(API.TestSummaryReport)?StudentID=\(result["StudentID"] ?? "")&StandardID=\(self.strtempStandardID)&SubjectID=\(self.strtempSubjectID)&CourseID=0&IsCompetitive=0"


                }
            }//"\(API.hostName)TestSummaryReport.aspx?STID=\(self.strStudentTestID)"
            AppUtility.lockOrientation(.landscapeLeft)
            let value = UIInterfaceOrientation.landscapeLeft.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            AppUtility.lockOrientation(.landscapeLeft)
            //            shouldAutorotate
            self.navigationController?.pushViewController(vc!, animated: true)

        }else{
            self.view.makeToast("Please complete any test to see the report", duration: 3.0, position: .bottom)
        }


    }
}
extension MyPackageListVCViewController{

    func apiGet_StudentTest_Progress_Lite()
    {
       // showActivityIndicator()
        //        self.arrMyPackageList.removeAll()
        //        let params = ["BoardID":strCategoryID1,"StandardID":"9","CourseTypeID": strCategoryID,"SubjectID":"1"]
        var params = ["":""]
        //        var result:[String:String] = [:]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
            //        }
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

//            var strTemp = "0"
//            var strcourseId = "0"
//            var strSubID = "0"
//            if strIsCompetitive == "True" || strIsCompetitive == "true"
//            {
//                strTemp = "1"
//                strcourseId = strtempSubjectID
//                strSubID = strtempSubjectID
//            }
//            else
//            {
//                strSubID = strtempSubjectID
//            }


            if strIsCompetitive == "false"{
//                params = ["StudentID":"\(result["StudentID"] ?? "")",
//                          "CourseTypeID":"0", "CourseID":"0", "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]

                params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "CourseTypeID":"0", "CourseID":"0", "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]


            }else{
//                params = ["StudentID":"\(result["StudentID"] ?? "")",
//                          "CourseTypeID":"1", "CourseID":"\(strtempSubjectID)", "BoardID":"0", "StandardID":"0", "SubjectID":"0"]

                params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "CourseTypeID":"1", "CourseID":strtempSubjectID, "BoardID":"0", "StandardID":"0", "SubjectID":"0"]


                //StudentID=14691&SubjectID=0&StandardID=0&CourseTypeID=1&BoardID=0&CourseID=1




            }

            //            strtempSubjectID
        }
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_StudentTest_Progress_Lite,params)
        print("API, Params: \n",API.Get_StudentTest_Progress_Lite,params)

        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
           // self.hideActivityIndicator()
            print("The network is not reachable")
           // self.collectionView.reloadData()
            self.tblMyList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_StudentTest_Progress_Lite, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
           // self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
            //    self.strDisplayMsg = "test progress not available."
                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "2") {
                   // let arrData1 = json["data"].array!
                let Performance_final = Double("\(json["data"]["Perentage"].stringValue )")//100 - per
                self.floatPercentage = CGFloat(Performance_final ?? 0)

               // self.floatPercentage = CGFloat(json["data"]["Perentage"])
                self.strProgress = "\(json["data"]["Perentage"].stringValue)"
                    self.totalTest = "\(json["data"]["TotalTest"].stringValue)"
                    self.GivenTest = "\(json["data"]["Given"].stringValue)"

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                //Bhargav Hide
                print(error)
                self.tblMyList.reloadData()

            }
        }
    }

    func apiMyPackages()
    {
        showActivityIndicator()
        //        self.arrMyPackageList.removeAll()
        //        let params = ["BoardID":strCategoryID1,"StandardID":"9","CourseTypeID": strCategoryID,"SubjectID":"1"]
        var params = ["":""]
        //        var result:[String:String] = [:]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
            //        }
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

            //Bhargav Hide
            ////print(strIsCompetitive)
//            var strTemp = "0"
//            var strcourseId = "0"
//            var strSubID = "0"
//            if strIsCompetitive == "True" || strIsCompetitive == "true"
//            {
//                strTemp = "1"
//                strcourseId = strtempSubjectID
//                strSubID = strtempSubjectID
//            }
//            else
//            {
//                strSubID = strtempSubjectID
//            }
        //    Get_StudentTest_Lite(int StudentID, int CourseTypeID, string CourseID, string BoardID, string StandardID, string SubjectID)


            if strIsCompetitive == "false"
            {
                params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "CourseTypeID":"0", "CourseID":"0", "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]

            }else{
                params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "CourseTypeID":"1", "CourseID":"\(strtempSubjectID)", "BoardID":"0", "StandardID":"0", "SubjectID":"0"]

                //StudentID=14691&SubjectID=0&StandardID=0&CourseTypeID=1&BoardID=0&CourseID=1
            }




            //            strtempSubjectID
        }
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
//        print("API, Params: \n",API.Get_StudentTestPackage_By_Subject_DetailApi,params)
//        print("API, Params: \n",API.Get_StudentTest_Lite,params)
       // StudentID=14575&SubjectID=15&StandardID=9&CourseTypeID=0&BoardID=2&CourseID=0


        print("API, Params: \n",API.Get_StudentTest_Lite_New,params)

        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
           // self.collectionView.reloadData()
            self.tblMyList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_StudentTest_Lite_New, method: .post, parameters: params, headers: headers).validate().responseJSON { response in


            switch response.result {
            case .success(let value):
                self.strDisplayMsg = "single test not available."
                let json = JSON(value)
                //Bhargav Hide
                print("Get_StudentTest_Lite_New",json)

                if(json["Status"] == "true" || json["Status"] == "2") {
                    let arrData1 = json["data"].array!

//                    for value in arrData1 {
//                        self.strtempBoardID = "\(value["BoardID"].stringValue)"
//                        self.istempSubscription = "\(value["isSubscription"].stringValue)"
//                        let Performance_final = Double("\(value["Performance"].stringValue ?? "0")")//100 - per
//                        self.floatPercentage = CGFloat(Performance_final ?? 0)
//                        self.strProgress = "\(value["Performance"].stringValue)"
//
//                    }
                   // let arrData = json["data"][0]["PackageList"].array!
                    self.arrMyPackageList.removeAll()
                    for values in arrData1 {
                        // let TestTypeModel:PackageDetailsModal = PackageDetailsModal.init(id: "", TestTypeName: values["TestTypeName"].stringValue, TestQuantity: values["TestQuantity"].stringValue)


                       if values["IsFree"].stringValue == "1"
                       {
                        let TestTypeModel:arrTestList = arrTestList.init(SubjectName: values["SubjectName"].stringValue, TestName: values["TestName"].stringValue, NumberOfHintUsed: values["NumberOfHintUsed"].stringValue, TestEndTime: values["TestEndTime"].stringValue, TestDuration: values["TestDuration"].stringValue, CourseName: values["CourseName"].stringValue, STGuiD: values["STGuiD"].intValue, TestInstruction: values["TestInstruction"].stringValue, RemainTime: values["RemainTime"].stringValue, NumberOfHint: values["NumberOfHint"].stringValue, Icon: values["Icon"].stringValue, TutorName: values["TutorName"].stringValue, Name: values["Name"].stringValue, TotalQuestions: values["TotalQuestions"].stringValue, TestMarks: values["TestMarks"].stringValue, StatusName: values["StatusName"].stringValue, IsCompetetive: values["IsCompetetive"].stringValue, TestStartTime: values["TestStartTime"].stringValue, StudentTestID: values["StudentTestID"].intValue, TestID: values["TestID"].intValue, TestGuiD: values["TestGuiD"].intValue, TestPackageName: values["TestPackageName"].stringValue,IsFree: values["IsFree"].stringValue,Price: values["Price"].stringValue,TestPackageID: values["TestPackageID"].intValue) // old
                        self.arrMyPackageList.append(TestTypeModel)

                       }
                    }
                    if self.istempSubscription == "1"{
                        self.hideActivityIndicator()
                        self.apiMyCreatedPackages()
                    }

                    DispatchQueue.main.async{
                        self.tblMyList.reloadData()
                    }

                   // self.tblMyList.reloadData()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                //Bhargav Hide
                print(error)
                self.tblMyList.reloadData()

            }
        }
    }
    func apiMyCreatedPackages()
    {
        showActivityIndicator()
        //        self.arrMyPackageList.removeAll()
        //        let params = ["BoardID":strCategoryID1,"StandardID":"9","CourseTypeID": strCategoryID,"SubjectID":"1"]
        var params = ["":""]
        //        var result:[String:String] = [:]
        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        {
            //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
            //        }
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//            Get_StudentTest_SelfTest_Lite(int StudentID, int CourseTypeID, string CourseID, string BoardID, string StandardID, string SubjectID)


//            params = ["StudentID":"\(result["StudentID"] ?? "")",
//                      "CourseTypeID":strCategoryID, "CourseID":strcourseId, "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]

            //Bhargav Hide
            ////print(strIsCompetitive)
//            var strTemp = "0"
//            if strIsCompetitive == "True" || strIsCompetitive == "true"
//            {
//                strTemp = "1"
//            }
//            if strTemp == "1"
//            {
//                //            api = API.Create_SelfTest_Competitive_Api
////                params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":strtempSubjectID,"BoardID":"0","StandardID":"0",                            "SubjectID":"0", "TypeID":"2"]
//
//                params = ["StudentID":"\(result["StudentID"] ?? "")",
//                          "CourseTypeID":strCategoryID, "CourseID":strtempSubjectID, "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]
//
//            }
//            else
//            {
//                //            api = API.Create_SelfTest_Bord_Api
////                params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")",
////                          "CourseID":"0", "BoardID":"\(strtempBoardID)",
////                          "StandardID":"\(strtempStandardID)",
////                          "TypeID":"1",
////                          "SubjectID":"\(strtempSubjectID)"]
//
//                params = ["StudentID":"\(result["StudentID"] ?? "")",
//                          "CourseTypeID":"2", "CourseID":strtempSubjectID, "BoardID":"0", "StandardID":"0", "SubjectID":"0"]
//
////                BoardID=0&CourseTypeID=2&CourseID=1&StandardID=0&SubjectID=0&StudentID=14691
//
//
//
//
//            }

            //            params = ["StudentID":"\(result["StudentID"] ?? "")",
            //                "SubjectID":strtempSubjectID, "isCompetitive":strTemp, "StandardID":strtempStandardID]
            //            strtempSubjectID





            if strIsCompetitive == "false"{
                params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "CourseTypeID":"0", "CourseID":"0", "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]
//                params = ["StudentID":"\(result["StudentID"] ?? "")",
//                          "CourseTypeID":strCategoryID, "CourseID":strtempSubjectID, "BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]


            }else{
//                params = ["StudentID":"\(result["StudentID"] ?? "")",
//                          "CourseTypeID":"1", "CourseID":"\(strtempSubjectID)", "BoardID":"0", "StandardID":"0", "SubjectID":"0"]

                params = ["StudentID":"\(result["StudentID"] ?? "")",
                          "CourseTypeID":"2", "CourseID":strtempSubjectID, "BoardID":"0", "StandardID":"0", "SubjectID":"0"]


                //StudentID=14691&SubjectID=0&StandardID=0&CourseTypeID=1&BoardID=0&CourseID=1




            }



        }
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_SelfTestListApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
          //  self.collectionView.reloadData()
            self.tblMyList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Get_StudentTest_SelfTest_Lite, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            switch response.result {
            case .success(let value):
                self.strDisplayMsg = "Package not available."
                let json = JSON(value)
                //Bhargav Hide
                print("selftest",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array!
                    self.arrMyTestList.removeAll()
                    if arrData.count > 0 {
                     //   self.arrMyTestList.removeAll()
                        for values in arrData {
                            // let TestTypeModel:PackageDetailsModal = PackageDetailsModal.init(id: "", TestTypeName: values["TestTypeName"].stringValue, TestQuantity: values["TestQuantity"].stringValue)
                            let TestTypeModel:arrTestList = arrTestList.init(SubjectName: values["SubjectName"].stringValue, TestName: values["TestName"].stringValue, NumberOfHintUsed: values["NumberOfHintUsed"].stringValue, TestEndTime: values["TestEndTime"].stringValue, TestDuration: values["TestDuration"].stringValue, CourseName: values["CourseName"].stringValue, STGuiD: values["STGuiD"].intValue, TestInstruction: values["TestInstruction"].stringValue, RemainTime: values["RemainTime"].stringValue, NumberOfHint: values["NumberOfHint"].stringValue, Icon: values["Icon"].stringValue, TutorName: values["TutorName"].stringValue, Name: values["Name"].stringValue, TotalQuestions: values["TotalQuestions"].stringValue, TestMarks: values["TestMarks"].stringValue, StatusName: values["StatusName"].stringValue, IsCompetetive: values["IsCompetetive"].stringValue, TestStartTime: values["TestStartTime"].stringValue, StudentTestID: values["StudentTestID"].intValue, TestID: values["TestID"].intValue, TestGuiD: values["TestGuiD"].intValue, TestPackageName: values["TestPackageName"].stringValue, IsFree: values["IsFree"].stringValue,Price: values["Price"].stringValue,TestPackageID: values["TestPackageID"].intValue) // old
                            self.arrMyTestList.append(TestTypeModel)
                        }
                        DispatchQueue.main.async{
                            self.cellLabelHeight = true
                            self.tblMyList.reloadData()
                        }
                    }
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                //Bhargav Hide
                ////print(error)
                //                self.apiMyPackages()
                self.tblMyList.reloadData()
            }
        }
    }
    func Get_Subcription_Course_Price_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
    {
        //        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)

        api = API.Get_Subcription_Course_PriceApi
        params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "CourseID":CourseID, "BoardID":BoardID, "StandardID":StandardID, "TypeID":TypeID, "IsFree":"0"]

        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
            //                    self.AlertPopupInternet()

            // show Alert
            //            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            //            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "True") {
                    self.strPrice = "\(json["data"]["Price"].stringValue)"
                    self.strListPrice = "\(json["data"]["ListPrice"].stringValue)"


                    if self.strIsCompetitive == "True" || self.strIsCompetitive == "true"
                    {
                       // strTemp = "1"
                       // self.Insert_StudentSubscription_API(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(2)")
//                        Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "0", StandardID: "0", TypeID: "\(2)")
                        self.Insert_StudentSubscription_API_Buy_Expired_package(CourseID: "\(self.strtempSubjectID)", BoardID: "0", StandardID: "0", TypeID: "\(2)")

                        print("Competitive")

                    }else{
                        print("Board")
//                        Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(strtempBoardID)", StandardID: "\(strtempStandardID)", TypeID: "\(1)")
                       // self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(1)")
                        self.Insert_StudentSubscription_API_Buy_Expired_package(CourseID: "0", BoardID: "\(self.strtempBoardID)", StandardID: "\(self.strtempStandardID)", TypeID: "\(1)")
                    }

                    //                    self.strPrice = "0"
                    //                    self.Check_Subcription_FreeTrial_API()
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)

                    //                    let alert = UIAlertController(title: "\(json["Msg"].stringValue)", message: "", preferredStyle: UIAlertController.Style.alert)
                    //                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                    //                        //Bhargav Hide
                    //                        //                        self.popUpViewSubscription.isHidden = false
                    //                        //                        self.pushPackage(strTemp:"")
                    //                    }
                    //                    alert.addAction(action1)
                    //                    //                            alert.addAction(actionContinue)
                    //                    self.present(alert, animated: true, completion: {
                    //                        //Bhargav Hide
                    //                        ////print("completion block")
                    //                    })
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
        //Bhargav Hide
        ////print("_currencyString_______amount_____",currencyString, amount_new)
        var params = ["":""]


        params =  ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","PaymentAmount":amount_new,"PaymentTransactionID":"0","CouponCode":""]
//        params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0"]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        //Bhargav Hide
        print("API, Params: \n",API.PaymentUrl,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.PaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
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
                        self.strPrice = "\(value["PaymentAmount"].stringValue)"

                        //                        "IsFree" : "0",

                    }
                    //                    if self.IsFree == "1"
                    //                    {
                    //                        print("Freee.....")
                    //                        //                        self.buyPackages()
                    //                        self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: temp_isFree)
                    //                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
                    //
                    //                    }
                    //                    else
                    //                    {
                    print("Paidd.....")
                    let temp_strMyCoin = (strMyCoin as NSString).doubleValue
                    let temp_amount = (amount as NSString).doubleValue




                    if self.IsFree == "1"
                    {
                        print("Freee.....")
                        //                        self.buyPackages()
                        self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: self.IsFree)

//                                                self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)

                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
                    }
                    else
                    {



                        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                        if result.value(forKey: "StudentFirstName") as! String == ""{
                            self.apiSignUp()
                        }else{
                            let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                            tpvc.amount = self.strPrice
                            tpvc.setrootViewController="MyPackageListVCViewController"
                            tpvc.arrPackageDetail = self.arrPackageDetail
                            self.navigationController?.pushViewController(tpvc, animated: true)
                        }




//                        print("Paidd.....")
//                        let temp_strMyCoin = (strMyCoin as NSString).doubleValue
//                        let temp_amount = (amount as NSString).doubleValue
                        //                        let unlockTest_InAppPurchase_Selected_ProductId = "1001"
                        //                        self.unlockProduct(unlockTest_InAppPurchase_Selected_ProductId)

//                        if(temp_amount <= temp_strMyCoin){
//                            print("\(strMyCoin) <= \(amount)")
//                            // Bhargav 10 jun
//                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: self.IsFree)
//
//                        }else
//                        {
//                            print("Not Enough Coin.")
//                            //                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)
//                            //
//                            let alert = UIAlertController(title: "Not Enough Coins!", message: "Looks like you need more Coins to buy.", preferredStyle: UIAlertController.Style.alert)
//                            let action1 = UIAlertAction(title: "Cancel", style: .default) { (_) in
//                                //Bhargav Hide
//                                ////print("User click Ok button")
//                                //                        self.PrompPopup()
//                            }
//                            alert.addAction(action1)
//                            let actionBuy = UIAlertAction(title: "Buy", style: .default) { (_) in
//                                //Bhargav Hide
//                                ////print("User click Ok button")
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCoinVC") as? AddCoinVC
//                                let temp_minCoin = temp_amount - temp_strMyCoin
//                                if(temp_amount <= temp_strMyCoin){
//                                }
//                                vc!.strMinPrice = "\(temp_minCoin)"//amount
//                                isContinuePurchsedFromDetailScreen = "1"
//                                self.navigationController?.pushViewController(vc!, animated: false)
//                            }
//                            alert.addAction(actionBuy)
//                            self.present(alert, animated: true, completion: {
//                                //Bhargav Hide
//                                ////print("completion block")
//                            })
//                        }
                    }


                    //                        let unlockTest_InAppPurchase_Selected_ProductId = "1001"
                    //                        self.unlockProduct(unlockTest_InAppPurchase_Selected_ProductId)
                    //                    temp_strMyCoin == 10
//                    if(temp_amount <= temp_strMyCoin){
//                        print("\(strMyCoin) <= \(amount)")
//                        // Bhargav 10 jun
//                        self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: "0")
//
//                    }else
//                    {
//                        print("Not Enough Coin.")
//                        //                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)
//                        //
//                        let alert = UIAlertController(title: "Not Enough Coins!", message: "Looks like you need more Coins to buy.", preferredStyle: UIAlertController.Style.alert)
//                        let action1 = UIAlertAction(title: "Cancel", style: .default) { (_) in
//                            //Bhargav Hide
//                            ////print("User click Ok button")
//                            //                        self.PrompPopup()
//                        }
//                        alert.addAction(action1)
//                        let actionBuy = UIAlertAction(title: "Buy", style: .default) { (_) in
//                            //Bhargav Hide
//                            ////print("User click Ok button")
////                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCoinVC") as? AddCoinVC
////                            let temp_minCoin = temp_amount - temp_strMyCoin
////                            if(temp_amount <= temp_strMyCoin){
////                            }
////                            vc!.strMinPrice = "\(temp_minCoin)"//amount
////                            isContinuePurchsedFromDetailScreen = "1"
////                            self.navigationController?.pushViewController(vc!, animated: false)
//                        }
//                        alert.addAction(actionBuy)
//                        self.present(alert, animated: true, completion: {
//                            //Bhargav Hide
//                            ////print("completion block")
//                        })
//                    }
                    //                    }
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }
    func Update_Payment_Api(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String, IsFree:String)
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
        print("API, Params: \n",API.Update_Payment_RequestApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Update_Payment_RequestApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    //                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    if IsFree == "1"
                    {

                        //                            self.Get_Coin_Globle_API()
                        let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
                            self.isExpired = "0"

                            //                                for controller in self.navigationController!.viewControllers as Array {
                            //                                    //Bhargav Hide
                            //                                    ////print(controller)
                            //                                    if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
                            //                                        controller.tabBarController!.selectedIndex = 0
                            //                                        //                                controller.tabBarController?.tabBarItem
                            //                                        self.navigationController!.popToViewController(controller, animated: false)
                            //                                        break
                            //                                    }
                            //                                    else if controller.isKind(of: ExploreVC.self) {
                            //                                        controller.tabBarController!.selectedIndex = 0
                            //                                        self.navigationController!.popToViewController(controller, animated: false)
                            //                                        break
                            //                                    }
                            //                                    else if controller.isKind(of: ExploreVC.self) {
                            //                                        controller.tabBarController!.selectedIndex = 0
                            //                                        self.navigationController!.popToViewController(controller, animated: false)
                            //                                        break
                            //                                    }
                            //                                }

                            //                                let presentingVC = self.presentingViewController
                            //                                self.dismiss(animated: true, completion: {
                            //                                    //                                //Bhargav Hide
                            //                                    print("completion block")
                            //                                    presentingVC?.tabBarController?.tabBar.isHidden = false
                            //                                    presentingVC?.tabBarController!.selectedIndex = 0
                            //
                            //                                }
                            //                                )
                        }
                        alert.addAction(action1)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })
                        //                        }
                        //                        let alert = AlertController(title: "", message: "\(json["Msg"])", preferredStyle: .alert)
                        //                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                        //                            for controller in self.navigationController!.viewControllers as Array {
                        //                                //Bhargav Hide
                        //                                ////print(controller)
                        //                                if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
                        //                                    controller.tabBarController!.selectedIndex = 0
                        //                                    //                                controller.tabBarController?.tabBarItem
                        //                                    self.navigationController!.popToViewController(controller, animated: false)
                        //                                    break
                        //                                }
                        //                                else if controller.isKind(of: ExploreVC.self) {
                        //                                    controller.tabBarController!.selectedIndex = 0
                        //                                    self.navigationController!.popToViewController(controller, animated: false)
                        //                                    break
                        //                                }
                        //                            }
                        //
                        //                        }))
                        //                        alert.addAction(action)
                        //                        self.present(alert, animated: true, completion: nil)

                    }else{
                        self.Purchased_Coin_Api(OrderID: OrderID, ExternalTransactionStatus: "success", ExternalTransactionID: "", StudentID: StudentID, amount: amount, isFree: IsFree)
                    }
                }
                else
                {
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...\(error)", duration: 3.0, position: .bottom)
            }
        }
    }
    func Purchased_Coin_Api(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String, isFree:String)
    {
        showActivityIndicator()
        //        (string StudentID, string Credit, string Debit, string PackageID)
        var freeCoin = ""

        if isFree == "1"{
            freeCoin = "0"
        }else
        {
            freeCoin = amount
        }

        let params = ["Debit":amount, "Credit":"", "TestPackageID":"2", "StudentID":StudentID]
        //        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.purchase_Coin_Api,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.purchase_Coin_Api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    if isFree == "1"
                    {
                        self.Get_Coin_Globle_API()
                        let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
                            self.isExpired = "0"

                            //                            for controller in self.navigationController!.viewControllers as Array {
                            //                                //Bhargav Hide
                            //                                ////print(controller)
                            //                                if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
                            //                                    controller.tabBarController!.selectedIndex = 0
                            //                                    //                                controller.tabBarController?.tabBarItem
                            //                                    self.navigationController!.popToViewController(controller, animated: false)
                            //                                    break
                            //                                }
                            //                                else if controller.isKind(of: ExploreVC.self) {
                            //                                    controller.tabBarController!.selectedIndex = 0
                            //                                    self.navigationController!.popToViewController(controller, animated: false)
                            //                                    break
                            //                                }
                            //                            }

                            //                            let presentingVC = self.presentingViewController
                            //                            self.dismiss(animated: true, completion: {
                            //                                //                                //Bhargav Hide
                            //                                print("completion block")
                            //                                presentingVC?.tabBarController?.tabBar.isHidden = false
                            //                                presentingVC?.tabBarController!.selectedIndex = 0
                            //
                            //                            }
                            //                            )
                        }
                        alert.addAction(action1)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })
                    }else{
                        self.Get_Coin_Globle_API()
                        let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                            //Bhargav Hide
                            ////print("User click Ok button")
                            self.isExpired = "0"

                            //                        self.PrompPopup()
                            //                            self.navigationController?.popViewController(animated: false)
                            //                            for controller in self.navigationController!.viewControllers as Array {
                            //                                //Bhargav Hide
                            //                                ////print(controller)
                            //                                if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
                            //                                    controller.tabBarController!.selectedIndex = 0
                            //                                    //                                controller.tabBarController?.tabBarItem
                            //                                    self.navigationController!.popToViewController(controller, animated: false)
                            //                                    break
                            //                                }
                            //                                else if controller.isKind(of: ExploreVC.self) {
                            //                                    controller.tabBarController!.selectedIndex = 0
                            //                                    self.navigationController!.popToViewController(controller, animated: false)
                            //                                    break
                            //                                }
                            //                            }

                            //                            let presentingVC = self.presentingViewController
                            //                            self.dismiss(animated: true, completion: {
                            //                                //                                //Bhargav Hide
                            //                                print("completion block")
                            //                                presentingVC?.tabBarController?.tabBar.isHidden = false
                            //                                presentingVC?.tabBarController!.selectedIndex = 0
                            //
                            //                            }
                            //                            )
                        }
                        alert.addAction(action1)
                        self.present(alert, animated: true, completion: {
                            //Bhargav Hide
                            ////print("completion block")
                        })
                    }
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
    func Insert_StudentSubscription_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
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

        api = API.Insert_StudentSubscription_TempApi
        params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":CourseID,"BoardID":BoardID,"StandardID":StandardID,"TypeID":TypeID,"IsFree":"0"]

        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            //            self.tblList.reloadData()
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
                }
                else
                {

                    let alert = UIAlertController(title: "\(json["Msg"].stringValue)", message: "", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                        //Bhargav Hide
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
    func AddTocart_Api(strCoin: String)
    {
        showActivityIndicator()
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

        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","TestPackageID":strTestPackageID]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Add_CartUrl,params)
                       if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                           return
                       }

        Alamofire.request(API.Add_CartUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
//                    let arrData = json["data"].array
//                    self.temp_New_Student_ID = "\(json["data"])"
                    self.Payment_Api(strCoin: strCoin)

                    //                    for value in arrData! {
                    //                        Order_ID = value["OrderID"].stringValue
                    //                        PaymentTransaction_ID = value["PaymentTransactionID"].stringValue
                    //                    }
                    //                    let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                    //                    tpvc.amount = strCoin
                    //                    tpvc.arrPackageDetail = self.arrPackageDetail
                    //                    self.navigationController?.pushViewController(tpvc, animated: true)
                }
                else
                {
                    //Bhargav Hide
                    ////print("\(json["Msg"])")
                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }


    func Insert_StudentSubscription_API_Buy_Expired_package(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
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

        if self.CourseTypeID == 2{

//            self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "0", StandardID: "\(self.StandardId)", TypeID: "\(self.CourseTypeID)")

            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":CourseID,"BoardID":BoardID,"StandardID":"0","TypeID":TypeID,"IsFree":IsFree]


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
                    self.Payment_Api_Buy_Expired_package(strCoin: self.strPrice)

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


    func Payment_Api_Buy_Expired_package(strCoin: String)
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
                        print("Freee.....")
                        //                        self.buyPackages()
                        self.Update_Payment_Api_buy_Expired_package(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)

//                                                self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)

                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
                    }
                    else
                    {

                        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                        if result.value(forKey: "StudentFirstName") as! String == ""{
                            self.apiSignUpIsExpired()
                        }else{
                            let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                            tpvc.amount = self.strPrice
                            print("")
                            tpvc.setrootViewController="MyExpiredPackage"
                            tpvc.arrPackageDetail = self.arrPackageDetail
                            self.navigationController?.pushViewController(tpvc, animated: true)

                        }


//                        print("Paidd.....")
//                        let temp_strMyCoin = (strMyCoin as NSString).doubleValue
//                        let temp_amount = (amount as NSString).doubleValue
                        //                        let unlockTest_InAppPurchase_Selected_ProductId = "1001"
                        //                        self.unlockProduct(unlockTest_InAppPurchase_Selected_ProductId)

//                        if(temp_amount <= temp_strMyCoin){
//                            print("\(strMyCoin) <= \(amount)")
//                            // Bhargav 10 jun
//                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: self.IsFree)
//
//                        }else
//                        {
//                            print("Not Enough Coin.")
//                            //                            self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)
//                            //
//                            let alert = UIAlertController(title: "Not Enough Coins!", message: "Looks like you need more Coins to buy.", preferredStyle: UIAlertController.Style.alert)
//                            let action1 = UIAlertAction(title: "Cancel", style: .default) { (_) in
//                                //Bhargav Hide
//                                ////print("User click Ok button")
//                                //                        self.PrompPopup()
//                            }
//                            alert.addAction(action1)
//                            let actionBuy = UIAlertAction(title: "Buy", style: .default) { (_) in
//                                //Bhargav Hide
//                                ////print("User click Ok button")
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCoinVC") as? AddCoinVC
//                                let temp_minCoin = temp_amount - temp_strMyCoin
//                                if(temp_amount <= temp_strMyCoin){
//                                }
//                                vc!.strMinPrice = "\(temp_minCoin)"//amount
//                                isContinuePurchsedFromDetailScreen = "1"
//                                self.navigationController?.pushViewController(vc!, animated: false)
//                            }
//                            alert.addAction(actionBuy)
//                            self.present(alert, animated: true, completion: {
//                                //Bhargav Hide
//                                ////print("completion block")
//                            })
//                        }
                    }

                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)

            }
        }
    }

    func Update_Payment_Api_buy_Expired_package(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String)
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


    func apiSignUpIsExpired()
    {
        showActivityIndicator()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")",
                      "StudentFirstName":"Guest",
            "StudentLastName":"User",
            "StudentEmailAddress":"\(result.value(forKey: "StudentEmailAddress") ?? "")",
            "StudentPassword":"\(result.value(forKey: "StudentPassword") ?? "")",
            "StudentMobile":"\(result.value(forKey: "StudentMobile") ?? "")",
            "StatusID":"1",
            "AccountTypeID":"\(result.value(forKey: "AccountTypeID") ?? "")",
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
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
//                        self.TransctionPayment_webview_Reload()
//                    }
                    UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")


                    let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                    tpvc.amount = self.strPrice
                    print("")
                    tpvc.setrootViewController="MyExpiredPackage"
                    tpvc.arrPackageDetail = self.arrPackageDetail
                    self.navigationController?.pushViewController(tpvc, animated: true)
                   // self.navigationController?.popViewController(animated: true)
                   // self.tabBarController?.selectedIndex = 1 // does not animate


                   // self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

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


    func apiSignUp()
    {
        showActivityIndicator()
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")",
                      "StudentFirstName":"Guest",
            "StudentLastName":"User",
            "StudentEmailAddress":"\(result.value(forKey: "StudentEmailAddress") ?? "")",
            "StudentPassword":"\(result.value(forKey: "StudentPassword") ?? "")",
            "StudentMobile":"\(result.value(forKey: "StudentMobile") ?? "")",
            "StatusID":"1",
            "AccountTypeID":"\(result.value(forKey: "AccountTypeID") ?? "")",
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
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
//                        self.TransctionPayment_webview_Reload()
//                    }
                    UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")


                    let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                    tpvc.amount = self.strPrice
                    tpvc.setrootViewController="MyPackageListVCViewController"
                    tpvc.arrPackageDetail = self.arrPackageDetail
                    self.navigationController?.pushViewController(tpvc, animated: true)
                    
                   // self.navigationController?.popViewController(animated: true)
                   // self.tabBarController?.selectedIndex = 1 // does not animate


                   // self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

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

}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask

        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
