//
//  TestCraftListVC.swift
//  TestCraftLite
//
//  Created by ADMS on 02/04/21.
//


//
//  DashboardVC.swift
//  TestCraftLite
//
//  Created by ADMS on 31/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import SDWebImage
import StoreKit

//class Header {
//    var headerTitle:String
//    var data:[Image]
//
//    init(header:String,arrImage:[Image]) {
//        self.headerTitle = header
//        self.data = arrImage
//    }
//}
//class Image{
//    var image:String
//    init(image:String) {
//        self.image = image
//    }
//}


class TestCraftListVC: UIViewController, UITableViewDelegate, UITableViewDataSource,ActivityIndicatorPresenter,popupDelegate {






    var globalSection:Int =  -1
    var globalIndexPath:Int =  -1

    var strSelectCoin = ""//:TweeAttributedTextField!
    var unlockTest_InAppPurchase_Selected_ProductId = ""
    var strMinPrice = ""

    var strTranstionId:String = ""


    var cellHeight:Int = -1

    // pop up connections

    @IBOutlet weak var lblBoard:UILabel!
    @IBOutlet weak var lblStandard:UILabel!
    @IBOutlet weak var popUpmain:UIView!
    @IBOutlet weak var popUpSubView:UIView!
    @IBOutlet weak var popimgStandard:UIImageView!
    @IBOutlet weak var lbltotalTest:UILabel!
    @IBOutlet weak var lblTotalQuestions:UILabel!
    @IBOutlet weak var popUpcollectionView:UICollectionView!

    @IBOutlet weak var vwMainSubViewHgtConstraint:NSLayoutConstraint!
    @IBOutlet weak var collectionHEightConstaint:NSLayoutConstraint!

    @IBOutlet weak var vwRound1:UIView!
    @IBOutlet weak var vwRound2:UIView!
    @IBOutlet weak var vwRound3:UIView!
    @IBOutlet weak var vwRound4:UIView!
    @IBOutlet weak var vwRound5:UIView!

    @IBOutlet weak var lblsubjectCount:UILabel!

    @IBOutlet weak var btnFreeTrialClick:UIButton!
    @IBOutlet weak var btnClose:UIButton!

    @IBOutlet weak var btnCoursePrise:UIButton!

    @IBOutlet weak var lblCoursePrise:UILabel!

    @IBOutlet weak var myTableView: UITableView!
    var arrPreferenceList = [subPreferenceList]()
    var arrSubList = [arrSubjectList]()
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()


    var strPrice = ""
    var strListPrice = ""
    var IsFree = ""
//    var IsFree = ""
    var temp_Order_ID = ""
    var temp_PaymentTransaction_ID = ""

    var strCouponCode = ""

    var CourseTypeID:Int = 0
    var BoardId:Int = 0
    var StandardId:Int = 0




    override func viewDidLoad() {
        super.viewDidLoad()


        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                if UserDefaults.standard.string(forKey:"isFirstTimeShow") == "testCraftPopUp"{
                    UserDefaults.standard.setValue("", forKey: "isFirstTimeShow")
                    showPopUpData()
                    unlockTest_InAppPurchase_Selected_ProductId = firstTimeunlockTest_InAppPurchase_Selected_ProductId
                    Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(BoardId)", StandardID: "\(StandardId)", TypeID: "\(CourseTypeID)")
                }
            }
        }




        self.myTableView.showsHorizontalScrollIndicator = false
        self.myTableView.showsVerticalScrollIndicator = false


//        btnCoursePrise.isUserInteractionEnabled = false
        lblCoursePrise.isUserInteractionEnabled = false
        lblCoursePrise.isHidden = true
        //  self.popUpmain.backgroundColor = UIColor(red: 17, green: 17, blue: 17, alpha: 0.8)

        self.popUpmain.backgroundColor = UIColor.black.withAlphaComponent(0.75)


       // btnCoursePrise.isHidden = true
        // self.popUpmain.isOpaque = false

//        btnCoursePrise.layer.cornerRadius = 6.0
//        btnCoursePrise.layer.masksToBounds = true
//
//
//
//        btnCoursePrise.layer.borderWidth = 1.0
//        btnCoursePrise.layer.borderColor = GetColor.borderColorPayment.cgColor

        btnFreeTrialClick.layer.cornerRadius = 6.0
        btnFreeTrialClick.layer.masksToBounds = true

        vwRound1.layer.cornerRadius = vwRound1.layer.frame.width / 2.0
        vwRound1.layer.masksToBounds = true

        vwRound2.layer.cornerRadius = vwRound1.layer.frame.width / 2.0
        vwRound2.layer.masksToBounds = true

        vwRound3.layer.cornerRadius = vwRound1.layer.frame.width / 2.0
        vwRound3.layer.masksToBounds = true

        vwRound4.layer.cornerRadius = vwRound1.layer.frame.width / 2.0
        vwRound4.layer.masksToBounds = true

        vwRound5.layer.cornerRadius = vwRound1.layer.frame.width / 2.0
        vwRound5.layer.masksToBounds = true

        popUpmain.isHidden = true

        popUpSubView.layer.cornerRadius = 6.0
        popUpSubView.layer.masksToBounds = true
        //        prefernceCollVw.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell")


        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 150

        myTableView.register(UINib(nibName: "TestCraftHeaderCell", bundle: nil), forCellReuseIdentifier: "TestCraftHeaderCell")


    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        api_Call_Get_Board_Course_List()
    }
}

extension TestCraftListVC{
    //MARK:Tableview Delegates and Datasource Methods

    func numberOfSections(in tableView: UITableView) ->  Int {
        return arrPreferenceList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->  CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCraftTblCell", for: indexPath) as! TestCraftTblCell
        cell.delegatePopUp = self
        // cell.arrImages?.removeAll()
        cell.fillCollectionView(with: arrPreferenceList, sectionSet: indexPath.section)
        cell.selectionStyle = .none
        //cell.myCollView.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "TestCraftHeaderCell") as! TestCraftHeaderCell
        //  headerView.backgroundColor = UIColor.red
        headerView.lblHeaderTitle.text = arrPreferenceList[section].Name
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section==0){
            return 40
        }else{
            return 40
        }
        // or whatever
    }

}
extension TestCraftListVC{
    func isUserLoggedIn(isUserLogin: Bool)
    {
        if isUserLogin == false{
            //   let appDelegate = UIApplication.shared.delegate as? AppDelegate

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

            self.navigationController?.pushViewController(rootVC, animated: true)
            //             let frontNavigationController = UINavigationController(rootViewController: rootVC)
            //            appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
            //            appDelegate?.window?.rootViewController = frontNavigationController
            //            appDelegate?.window?.makeKeyAndVisible()
        }

    }



    func showPopUpData(){


        globalSection = UserOpenglobalSection
        globalIndexPath = UserOpenglobalIndex

//        self.CourseTypeID = CourseTypeID
//        self.BoardId = BoardId
//        self.StandardId = StandardId


        print("CourseTypeID", FirstTimeCourseTypeID)
        print("BoardId", FirstTimeBoardId)
        print("StandardId", FirstTimeStandardId)





        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(FirstTimeBoardId)", StandardID: "\(FirstTimeStandardId)", TypeID: "\(FirstTimeCourseTypeID)")
            }
        }else{
            self.btnFreeTrialClick.setTitle("Free 1 Month Trail", for: .normal)
//            self.IsFree = "1"
//            IsFreeFirstTime = "1"
            lblCoursePrise.isHidden = true
            lblCoursePrise.layer.cornerRadius = 0.0
            lblCoursePrise.layer.masksToBounds = true

        }



        print("newdict", dictJson)
        print("UserOpenBoard", UserOpenBoard)
        print("UserOpenStanderd", UserOpenStanderd)
        arrSubList.removeAll()


        if let arrList = dictJson["data"]["SubjectList"].array{
            for value in arrList{
                let arr = arrSubjectList(SubjectName: value["SubjectName"].stringValue, Icon: value["Icon"].stringValue, SubjectID: value["SubjectID"].intValue)
                arrSubList.append(arr)
            }
        }

        self.lblBoard.text = UserOpenBoard

        let fullName = UserOpenStanderd
        let fullNameArr = fullName.split{$0 == " "}.map(String.init)
        let firstName: String = fullNameArr[0]


        if FirstTimeCourseTypeID == 2{
            self.lblStandard.text = "\(UserOpenStanderd)"
        }else{
            self.lblStandard.text = "\(firstName) Std"
        }


        // self.lblStandard.text = Standard

        self.lbltotalTest.text = "\(dictJson["data"]["TestCount"]) Tests"
        self.lblTotalQuestions.text = "\(dictJson["data"]["QuestionCount"]) Questions"
        self.lblsubjectCount.text = "You will get access to \(arrSubList.count) Subjects"
        popimgStandard.sd_setImage(with: URL(string: API.boardImageBannerUrl + "\(dictJson["data"]["Icon"])"))

        DispatchQueue.main.async { [self] in
            print("subjectcount",self.arrSubList.count)
            self.popUpmain.isHidden = false
            self.popUpcollectionView.reloadData()
        }

    }


    func passDataDict(dictResponce:JSON,Board:String,Standard:String,CourseTypeID:Int,BoardId:Int,StandardId:Int,sectionSelected:Int,indexPathSelected:Int,selectedProductId: String) {

        dictJson = dictResponce
        UserOpenglobalSection = sectionSelected
        UserOpenglobalIndex = indexPathSelected


        UserOpenStanderd = Standard
        UserOpenBoard =  Board


        globalSection = sectionSelected
        globalIndexPath = indexPathSelected

        self.CourseTypeID = CourseTypeID
        self.BoardId = BoardId
        self.StandardId = StandardId

        FirstTimeCourseTypeID = CourseTypeID
        FirstTimeBoardId = BoardId
        FirstTimeStandardId = StandardId


        print("CourseTypeID", CourseTypeID)
        print("BoardId", BoardId)
        print("StandardId", StandardId)
        print("in app purchase productID", selectedProductId)


        self.unlockTest_InAppPurchase_Selected_ProductId = selectedProductId

        firstTimeunlockTest_InAppPurchase_Selected_ProductId = selectedProductId

        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {


            }
        }else{
            //UserDefaults.standard.setValue(true, forKey: "isFirstTimeShow")
          //  self.btnFreeTrialClick.setTitle("Free 1 Month Trail", for: .normal)
            vwMainSubViewHgtConstraint.constant = 390
//            self.IsFree = "1"
//            IsFreeFirstTime = "1"
            self.popUpmain.isHidden = true
//            lblCoursePrise.isHidden = true
//            lblCoursePrise.layer.cornerRadius = 0.0
//            lblCoursePrise.layer.masksToBounds = true

        }

        Get_Subcription_Course_Price_API(CourseID: "0", BoardID: "\(BoardId)", StandardID: "\(StandardId)", TypeID: "\(CourseTypeID)")



        print("newdict", dictResponce)
        arrSubList.removeAll()


        if let arrList = dictResponce["data"]["SubjectList"].array{
            for value in arrList{
                let arr = arrSubjectList(SubjectName: value["SubjectName"].stringValue, Icon: value["Icon"].stringValue, SubjectID: value["SubjectID"].intValue)
                arrSubList.append(arr)
            }
        }

        self.lblBoard.text = Board

        let fullName = Standard
        let fullNameArr = fullName.split{$0 == " "}.map(String.init)
        let firstName: String = fullNameArr[0]


        if CourseTypeID == 2{
            self.lblStandard.text = "\(Standard)"
        }else{
            self.lblStandard.text = "\(firstName) Std"
        }


        // self.lblStandard.text = Standard

        self.lbltotalTest.text = "\(dictResponce["data"]["TestCount"]) Tests"
        self.lblTotalQuestions.text = "\(dictResponce["data"]["QuestionCount"]) Questions"
        self.lblsubjectCount.text = "You will get access to \(arrSubList.count) Subjects"
        popimgStandard.sd_setImage(with: URL(string: API.boardImageBannerUrl + "\(dictResponce["data"]["Icon"])"))

        DispatchQueue.main.async { [self] in
            print("subjectcount",self.arrSubList.count)
            self.popUpmain.isHidden = false
            self.popUpcollectionView.reloadData()
        }
    }
    @IBAction func btnClickPopUp(_ sender: UIButton){
        print("click")
        self.popUpmain.isHidden = true
        vwMainSubViewHgtConstraint.constant = 390
    }

    func validated() -> Bool {
        var valid: Bool = true
        if strSelectCoin == ""{
            self.view.makeToast("Please select coin.", duration: 3.0, position: .bottom)
            valid = false
        }
        return valid
    }

    @IBAction func btnPayNow(_ sender: UIButton){

        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
            if(result == "1")
            {
                self.popUpmain.isHidden = true
                vwMainSubViewHgtConstraint.constant = 390

                view.endEditing(true)
                if validated() == true
                {
                    self.unlockProduct(unlockTest_InAppPurchase_Selected_ProductId)
                }


//                self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.BoardId)", StandardID: "\(self.StandardId)", TypeID: "\(self.CourseTypeID)")

            }
        }else{
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
            UserDefaults.standard.setValue("testCraftPopUp", forKey: "isFirstTimeShow")

            self.navigationController?.pushViewController(rootVC, animated: true)
            
            self.popUpmain.isHidden = true
            vwMainSubViewHgtConstraint.constant = 390

//            self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.BoardId)", StandardID: "\(self.StandardId)", TypeID: "\(self.CourseTypeID)")
        }
    }
}
extension TestCraftListVC{
    func api_Call_Get_Board_Course_List()
    {
        showActivityIndicator()
        //        self.arrHeaderSubTitle.removeAll()
        // let params = [:]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        //        print("API, Params: \n",API.Get_Course_ListApi,params)
        if !Connectivity.isConnectedToInternet() {
                        self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.myTableView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request("https://webservice.testcraft.in/WebService.asmx/Get_Board_Course_List", method: .post, parameters: nil, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
                self.arrPreferenceList.removeAll()
                if(json["Status"] == "true" || json["Status"] == "1") {
                    if let arrData = json["data"].array{
                        var arrStandard = [StandardList]()
                        var ChildModel:subPreferenceList
//                        let ChildModelStandard:StandardList = StandardList.init(ID: "", Name:"Market Place", Icon: "Group 54.png", selected: "0")
//                        arrStandard.append(ChildModelStandard)
//
//                        ChildModel = subPreferenceList.init(courseTypeID: 0, id: "", Headertitle: "Market Place", icon: "", selected: "0", arrStandard: arrStandard)
//
//                        self.arrPreferenceList.insert(ChildModel, at: 0)
                        //

                        for (index,value) in arrData.enumerated() {

                            if let arrStandard1 = json["data"][index]["Standard"].array{
                                arrStandard.removeAll()

                                for (_,value) in arrStandard1.enumerated(){
                                    let ChildModelStandard:StandardList = StandardList.init(ID: value["ID"].stringValue, Name: value["Name"].stringValue, Icon: (value["Icon"].stringValue), selected: "0")
                                    arrStandard.append(ChildModelStandard)
                                }

                                ChildModel = subPreferenceList.init(courseTypeID: value["CourseTypeID"].intValue, id: value["ID"].stringValue, Headertitle: value["Name"].stringValue, icon: value["Icon"].stringValue, selected: "0", arrStandard: arrStandard)

                                self.arrPreferenceList.append(ChildModel)
                            }

                        }
                    }
                    self.myTableView.reloadData()
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
    func Get_Coin_API()
    {
        //        showActivityIndicator()
        //   let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params = ["StudentID":"14395"]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide

        //Get_MyCoin_Api
        //Get_CoinList_Api
        //Get_purchase_Api

        print("API, Params: \n",API.Get_MyCoin_Api,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            //self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

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
                    //                    DispatchQueue.main.async {
                    //                        self.lblMyCoin.text = strMyCoin
                    //                    }
                }
                else
                {
                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                }
            //                    return strMyCoin

            case .failure(let error):
                print("",error)
                //                    return strMyCoin
                self.view.makeToast("Somthing wrong....", duration: 3.0, position: .bottom)
            }
            //                return strMyCoin
        }
        //                return strMyCoin
    }
    func api_Call_Get_CourseDetail_Lite(CourseTypeID:String,CourseID:String,BoardID:String,StandardID:String)
    {
        showActivityIndicator()
        //        self.arrHeaderSubTitle.removeAll()
        let params = ["CourseTypeID":CourseTypeID,"CourseID":CourseID,"BoardID":BoardID,"StandardID":StandardID]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        //        print("API, Params: \n",API.Get_Course_ListApi,params)
        if !Connectivity.isConnectedToInternet() {
                        self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.myTableView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request("https://webservice.testcraft.in/WebService.asmx/Get_CourseDetail_Lite", method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
                self.arrPreferenceList.removeAll()
                if(json["Status"] == "true" || json["Status"] == "1") {
                    //                    if let arrData = json["data"].array{
                    //                        var arrStandard = [StandardList]()
                    //                        var ChildModel:subPreferenceList
                    //                        let ChildModelStandard:StandardList = StandardList.init(ID: "", Name: "", Icon: "Group 54.png", selected: "0")
                    //                        arrStandard.append(ChildModelStandard)
                    //
                    //                        ChildModel = subPreferenceList.init(courseTypeID: 0, id: "MarketPlace", Headertitle: "", icon: "", selected: "0", arrStandard: arrStandard)
                    //
                    //                    self.arrPreferenceList.insert(ChildModel, at: 0)
                    //                        //
                    //
                    //                        for (index,value) in arrData.enumerated() {
                    //
                    //                            if let arrStandard1 = json["data"][index]["Standard"].array{
                    //                                arrStandard.removeAll()
                    //
                    //                                for (_,value) in arrStandard1.enumerated(){
                    //                                    let ChildModelStandard:StandardList = StandardList.init(ID: value["ID"].stringValue, Name: value["Name"].stringValue, Icon: (value["Icon"].stringValue), selected: "0")
                    //                                    arrStandard.append(ChildModelStandard)
                    //                                }
                    //
                    //                                    ChildModel = subPreferenceList.init(courseTypeID: value["CourseTypeID"].intValue, id: value["ID"].stringValue, Headertitle: value["Name"].stringValue, icon: value["Icon"].stringValue, selected: "0", arrStandard: arrStandard)
                    //
                    //                                self.arrPreferenceList.append(ChildModel)
                    //                            }
                    //
                    //                        }
                    //                    }
                    //                    self.myTableView.reloadData()
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
    func Get_Subcription_Course_Price_API(CourseID:String, BoardID:String, StandardID:String, TypeID:String)
    {
        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""

       // let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)

        api = API.Get_Subcription_Course_PriceApi

        if UserDefaults.standard.object(forKey: "isLogin") != nil{
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "CourseID":CourseID, "BoardID":BoardID, "StandardID":StandardID, "TypeID":TypeID, "IsFree":IsFree]
        }else{
            params = ["StudentID":"", "CourseID":CourseID, "BoardID":BoardID, "StandardID":StandardID, "TypeID":TypeID, "IsFree":IsFree]
        }



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
                   // firstTimestrSelectCoin =  "\(json["data"]["Price"].stringValue)"
                    self.strSelectCoin = "\(json["data"]["Price"].stringValue)"
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



                    //for testcraft internation this api is not called
                    //self.Check_Subcription_FreeTrial_API()


                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    //                    let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strListPrice)")//, attributes: attrs )
                    //                    attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    //                    attributeString.append(attributeString1)
                    let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor(red: 27.0/255.0, green: 145.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor];

                    //                    if self.strPrice == "0" {
                    //                        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    //                        attributeString.append(attributeString2)
                    //
                    //                    }else{
                    //                        self.lblPrice.text = "₹ \(self.strPrice)"
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)/year", attributes: attributedStringColor)
                    attributeString.append(attributeString2)

                    //                    }
                    self.btnFreeTrialClick.setTitle("Pay Now", for: .normal)
                    self.IsFree = "0"
                    IsFreeFirstTime = "0"
                    self.lblCoursePrise.isHidden = false
                    self.lblCoursePrise.attributedText = attributeString

                    self.lblCoursePrise.layer.cornerRadius = 6.0
                    self.lblCoursePrise.layer.masksToBounds = true

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
                    self.btnFreeTrialClick.setTitle("Free 1 Month Trail", for: .normal)
                    self.IsFree = "1"
                    IsFreeFirstTime = "1"
                    lblCoursePrise.isHidden = true
                    lblCoursePrise.layer.cornerRadius = 0.0
                    lblCoursePrise.layer.masksToBounds = true


                  //  self.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self.BoardId)", StandardID: "\(self.StandardId)", TypeID: "\(self.CourseTypeID)")


                   // self.lblCoursePrise.attributedText = attributeString



                }
                else
                {
                    
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)

                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "For Only ")//"Free  ")
                    //                    let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "₹\(self.strListPrice)")//, attributes: attrs )
                    //                    attributeString1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString1.length))
                    //                    attributeString.append(attributeString1)
                    let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor(red: 27.0/255.0, green: 145.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor];

                    //                    if self.strPrice == "0" {
                    //                        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " Free", attributes: attributedStringColor)
                    //                        attributeString.append(attributeString2)
                    //
                    //                    }else{
                    //                        self.lblPrice.text = "₹ \(self.strPrice)"
                    let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: " ₹\(self.strPrice)/year", attributes: attributedStringColor)
                    attributeString.append(attributeString2)

                    //                    }
                self.btnFreeTrialClick.setTitle("Pay Now", for: .normal)
                    self.IsFree = "0"
                    IsFreeFirstTime = "0"
                    lblCoursePrise.isHidden = false
                    lblCoursePrise.attributedText = attributeString

                    lblCoursePrise.layer.cornerRadius = 6.0
                    lblCoursePrise.layer.masksToBounds = true

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
//    func AddTocart_Api(strCoin: String, TestPackageID: String)
//    {
//        showActivityIndicator()
//        let UDID: String = UIDevice.current.identifierForVendor!.uuidString
//
//        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//        //Bhargav Hide
//        ////print(result)
//        let currencyString = "\(strCoin)"
//        var amount_new = currencyString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
//        amount_new = amount_new.replacingOccurrences(of: "₹", with: "", options: NSString.CompareOptions.literal, range: nil)
//        amount_new = amount_new.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
//        //        var amount_new = currencyString.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: ", ₹  "))
//        //Bhargav Hide
//        ////print("_currencyString_______amount_____",currencyString, amount_new)
//
//        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","TestPackageID":TestPackageID]
//        let headers = [
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        //Bhargav Hide
//        print("API, Params: \n",API.Add_CartUrl,params)
//        if !Connectivity.isConnectedToInternet() {
//                    self.AlertPopupInternet()
//
//            // show Alert
//            self.hideActivityIndicator()
//            print("The network is not reachable")
//            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
//            return
//        }
//
//        Alamofire.request(API.Add_CartUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
//            self.hideActivityIndicator()
//
//            switch response.result {
//            case .success(let value):
//
//                let json = JSON(value)
//                //Bhargav Hide
//                print(json)
//
//                if(json["Status"] == "true" || json["Status"] == "1") {
//                    let arrData = json["data"].array
//                    //                        self.temp_New_Student_ID = "\(json["data"])"
//                    self.Payment_Api(strCoin: strCoin)
//
//                    //                    for value in arrData! {
//                    //                        Order_ID = value["OrderID"].stringValue
//                    //                        PaymentTransaction_ID = value["PaymentTransactionID"].stringValue
//                    //                    }
//                    //                    let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
//                    //                    tpvc.amount = strCoin
//                    //                    tpvc.arrPackageDetail = self.arrPackageDetail
//                    //                    self.navigationController?.pushViewController(tpvc, animated: true)
//                }
//                else
//                {
//                    //Bhargav Hide
//                    ////print("\(json["Msg"])")
//                    self.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
//                }
//
//            case .failure(let error):
//                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
//
//            }
//        }
//    }

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

        if self.CourseTypeID == 2{

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
                        print("Freee.....")
                        //                        self.buyPackages()
//                        self.Update_Payment_Api(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)


                        self.Update_Payment_Api_in_app_purchase(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: self.IsFree)

//                                                self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)

                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
                    }
                    else
                    {


                       // let transtionId = arc4random()

                        self.Update_Payment_Api_in_app_purchase(OrderID: self.temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "\(self.strTranstionId)", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount, IsFree: self.IsFree)


//                        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//                        if result.value(forKey: "StudentFirstName") as! String == ""{
//                            self.apiSignUp()
//                        }else{
//                            let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
//                            tpvc.amount = self.strPrice
//                            print("")
//                            tpvc.arrPackageDetail = self.arrPreferenceList[self.globalSection].arrStandard[self.globalIndexPath]
//                            self.navigationController?.pushViewController(tpvc, animated: true)
//                        }



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

                    UserDefaults.standard.set(jsonArray as [String : AnyObject], forKey: "logindata")


                    let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
                    tpvc.amount = self.strPrice
                    print("")
                    tpvc.arrPackageDetail = self.arrPreferenceList[self.globalSection].arrStandard[self.globalIndexPath]
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

//    func Payment_Api(strCoin: String)
//    {
//        //        showActivityIndicator()
//        let UDID: String = UIDevice.current.identifierForVendor!.uuidString
//
//        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//        //Bhargav Hide
//        ////print(result)
//        let currencyString = "\(strCoin)"
//        var amount_new = currencyString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
//        amount_new = amount_new.replacingOccurrences(of: "₹", with: "", options: NSString.CompareOptions.literal, range: nil)
//        amount_new = amount_new.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
//        //        var amount_new = currencyString.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: ", ₹  "))
//        //Bhargav Hide
//        ////print("_currencyString_______amount_____",currencyString, amount_new)
//        var params = ["":""]
////        if self.strCouponCodeID != ""
////        {
//            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0","CouponCode": strCouponCode]
////        }
////        else
////        {
////            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "PaymentAmount":amount_new,"PaymentTransactionID":"0","CouponCode": ""]
////        }
//
//        let headers = [
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//
//        //Bhargav Hide
//        print("API, Params: \n",API.PaymentUrl,params)
//        if !Connectivity.isConnectedToInternet() {
//                    self.AlertPopupInternet()
//
//            // show Alert
//            self.hideActivityIndicator()
//            print("The network is not reachable")
//            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
//            return
//        }
//
//        Alamofire.request(API.PaymentUrl, method: .post, parameters: params, headers: headers).validate().responseJSON { [self] response in
//            self.hideActivityIndicator()
//
//            switch response.result {
//            case .success(let value):
//
//                let json = JSON(value)
//                //Bhargav Hide
//                print(json)
//
//                if(json["Status"] == "true" || json["Status"] == "1") {
//                    let arrData = json["data"].array
//                    var amount = "0"
//                    var temp_Order_ID = ""
//                    var temp_PaymentTransaction_ID = ""
//                    //                    var New_Student_ID = ""
//
//                    for value in arrData! {
//                        amount = "\(value["PaymentAmount"].stringValue)"
//                        Order_ID = "\(value["OrderID"].stringValue)"
//                        PaymentTransaction_ID = "\(value["PaymentTransactionID"].stringValue)"
//                        temp_Order_ID = "\(value["OrderID"].stringValue)"
//                        temp_PaymentTransaction_ID = "\(value["PaymentTransactionID"].stringValue)"
//                        //                        New_Student_ID = "\(value["PaymentTransactionID"].stringValue)"
//                    }
//                    if strCoin == "free" || amount == "0"
//                    {
//                        //                        self.buyPackages()
//                        self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "0", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)
//                        //                        let params = ["PaymentOrderID":"\(Order_ID ?? "")", "ExternalTransactionStatus":"success", "ExternalTransactionID":"0", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
//
//                    }
//                    else{
//                        let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
//                        tpvc.amount = self.strPrice
//                        tpvc.arrPackageDetail = self.arrPreferenceList
//                        self.navigationController?.pushViewController(tpvc, animated: true)
//                    }
////                    else
////                    {
////                        let temp_strMyCoin = (strMyCoin as NSString).doubleValue
////                        let temp_amount = (amount as NSString).doubleValue
////
////                        if(temp_amount <= temp_strMyCoin){
////                            print("\(strMyCoin) <= \(amount)")
////                            self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: "2", StudentID: "\(result.value(forKey: "StudentID") ?? "")", amount: amount)
////
////                        }else
////                        {
////                            print("Not Enough Coin.")
////                            let alert = UIAlertController(title: "Not Enough Coins!", message: "Looks like you need more Coins to buy.", preferredStyle: UIAlertController.Style.alert)
////                            let action1 = UIAlertAction(title: "Cancel", style: .default) { (_) in
////                                //Bhargav Hide
////                                ////print("User click Ok button")
////                                //                        self.PrompPopup()
////                            }
////                            alert.addAction(action1)
////                            let actionBuy = UIAlertAction(title: "Buy", style: .default) { (_) in
////                                //Bhargav Hide
////                                ////print("User click Ok button")
////                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddCoinVC") as? AddCoinVC
////                                //        vc!.arrPackageDetail = [self.arrHeaderSub3Title[indexPath.row]]
////                                //        strCategoryID2 = arrHeaderSub1Title[indexPath.item].id ?? ""
////                                //        strCategoryTitle2 = arrHeaderSub1Title[indexPath.item].title ?? ""
////                                //        arrPath.append(arrHeaderSub1Title[indexPath.item].title ?? "")
////                                //                                let temp_strMyCoin = (strMyCoin as NSString).doubleValue
////                                //                                let temp_amount = (amount as NSString).doubleValue
////                                let temp_minCoin = temp_amount - temp_strMyCoin
////                                if(temp_amount <= temp_strMyCoin){
////                                }
////                                vc!.strMinPrice = "\(temp_minCoin)"//amount
////                                isContinuePurchsedFromDetailScreen = "1"
////                                self.navigationController?.pushViewController(vc!, animated: true)
////                            }
////                            alert.addAction(actionBuy)
////                            self.present(alert, animated: true, completion: {
////                                //Bhargav Hide
////                                ////print("completion block")
////                            })
////
////
////                        }
////                        //                        self.unlockProduct(unlockTestInAppPurchase1ProductId_0_99)
////                        //                        self.unlockProduct(unlockTestInAppPurchase2ProductId_1_99)
////
////                        //                        InAppPurchase.sharedInstance.unlockProduct(unlockTestInAppPurchase1ProductId)
////
////                        //Payment
////                        self.temp_Globle_Order_ID = temp_Order_ID
////                        self.temp_Globle_PaymentTransaction_ID = PaymentTransaction_ID
////                        //                        self.temp_Globle_CompanyDetails =
////                        //                            self.temp_Globle_narration =
////
////
////                        //   self.Update_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: PaymentTransaction_ID, StudentID: "\(result.value(forKey: "StudentID") ?? "")")
////
////                        //                        guard let url = URL(string: "\(API.WebBrowserPaymentApi)?StudentID=\(self.temp_New_Student_ID)&type=1") else { return }
////
////                        //                        self.Send_Mail_Payment_Api(OrderID: temp_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: temp_PaymentTransaction_ID, StudentID: "\(result.value(forKey: "StudentID") ?? "")", New_Student_ID: self.temp_New_Student_ID, type: "1", amount: amount, url: "\(API.WebBrowserPaymentApi)?StudentID=\(self.temp_New_Student_ID)&type=1") // Send Link Via API
////                        //                        InAppPurchase.sharedInstance.buyUnlockTestInAppPurchase1()
////                        //        unlockProduct(unlockTestInAppPurchase1ProductId)
////
////                        //                        if SKPaymentQueue.canMakePayments() {
////                        //                            let paymentRequest = SKMutablePayment()
////                        //                            paymentRequest.productIdentifier = self.product_id
////                        //                            SKPaymentQueue.default().add(paymentRequest)
////                        //                        } else {
////                        //                            print("User unable to make payments")
////                        //                        }
////
////                        //                        if (SKPaymentQueue.canMakePayments()) {
////                        //                            let productID:NSSet = NSSet(array: [self.product_id]);
////                        //                            let productsRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>);
////                        //                            productsRequest.delegate = self;
////                        //                            productsRequest.start();
////                        //                            print("Fetching Products");
////                        //                        } else {
////                        //                            print("can't make purchases");
////                        //                        }
////
////                        //                        //                        let tpvc:PaymentWebViewVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentWebViewVC") as! PaymentWebViewVC
////                        //                        //                        tpvc.amount = amount
////                        //                        //                        tpvc.arrPackageDetail = self.arrPackageDetail
////                        //                        //                        self.navigationController?.pushViewController(tpvc, animated: true)
////                        //                        //
////                        //                        print("\(API.WebBrowserPaymentApi)?StudentID=\(self.temp_New_Student_ID)&type=1")
////                        //                        guard let url = URL(string: "\(API.WebBrowserPaymentApi)?StudentID=\(self.temp_New_Student_ID)&type=1") else { return }
////                        //                        //                        guard let url = URL(string: "https://testcraft.in/ios.aspx") else { return }
////                        //
////                        //                        if #available(iOS 10.0, *) {
////                        //                            UIApplication.shared.open(url)
////                        //                        } else {
////                        //                            // Fallback on earlier versions
////                        //                            UIApplication.shared.openURL(url)
////                        //                        }
////                    }
//                }
//            case .failure(let error):
//                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
//
//            }
//        }
//    }



    func Update_Payment_Api_in_app_purchase(OrderID:String, ExternalTransactionStatus:String, ExternalTransactionID:String, StudentID:String, amount:String, IsFree:String)
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
                    if IsFree == "1"
                    {

                        self.logFBEvent(Event_Name: "Subscription_free", device_Name: "iOS", valueToSum: 1)

//                            self.Get_Coin_Globle_API()
                            let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                            let action1 = UIAlertAction(title: "Go To Dashboard", style: .default) { (_) in
                                //Bhargav Hide
                                ////print("User click Ok button")
//                                for controller in self.navigationController!.viewControllers as Array {
//                                    //Bhargav Hide
//                                    ////print(controller)
//                                    if controller.isKind(of: TestCraftListVC.self) {
//                                        controller.tabBarController!.selectedIndex = 0
//                                        //                                controller.tabBarController?.tabBarItem
//                                        self.navigationController!.popToViewController(controller, animated: false)
//                                        break
//                                    }
//                                }
                                self.tabBarController?.selectedIndex = 0

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


                        self.logFBEvent(Event_Name: "Subscription_paid", device_Name: "iOS", valueToSum: 1)

                        let alert = UIAlertController(title: "Sucess!!", message: "Subscribe successfully.", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "Go To Dashboard", style: .default) { (_) in


                            self.tabBarController?.selectedIndex = 0
                            //Bhargav Hide
                            ////print("User click Ok button")
//                            for controller in self.navigationController!.viewControllers as Array {
//                                //Bhargav Hide
//                                ////print(controller)
//                                if controller.isKind(of: TestCraftListVC.self) {
//                                    controller.tabBarController!.selectedIndex = 0
//                                    //                                controller.tabBarController?.tabBarItem
//                                    self.navigationController!.popToViewController(controller, animated: false)
//                                    break
//                                }
//                            }

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
extension TestCraftListVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


//        let text = "\(self.arrSubList[indexPath.row])"
//        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 30.0
//        print(cellWidth/3)
//        return CGSize(width: cellWidth/3, height: 50)



        let noOfCellsInRow = 3
//        let totalSpace = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - CGFloat(totalSpace)) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: 30)

        //        let screenWidth = UIScreen.main.bounds.width
        //        let scaleFactor = (screenWidth / 3) - 6
        //
        //        return CGSize(width: scaleFactor, height: 50)


        //        let yourWidth = popUpcollectionView.bounds.width-3/3.0
        ////        let yourHeight = yourWidth
        //        return CGSize(width: yourWidth, height: popUpcollectionView.bounds.height)

    }
    //    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    //            // `collectionView.contentSize` has a wrong width because in this nested example, the sizing pass occurs before the layout pass,
    //            // so we need to force a layout pass with the correct width.
    //            self.contentView.frame = self.bounds
    //            self.contentView.layoutIfNeeded()
    //            // Returns `collectionView.contentSize` in order to set the UITableVieweCell height a value greater than 0.
    //            return self.myCollView.contentSize
    //        }

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSubList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopUpCollectionCell", for: indexPath) as! PopUpCollectionCell
        cell.lblSubjectName.text = arrSubList[indexPath.row].SubjectName

        cell.backgroundColor = UIColor.red
        if arrSubList.count > 3{
            let height = popUpcollectionView.contentSize.height
            collectionHEightConstaint.constant = height
            vwMainSubViewHgtConstraint.constant = 390
            vwMainSubViewHgtConstraint.constant = 360 + collectionHEightConstaint.constant
            self.view.layoutIfNeeded()
        }else{
            vwMainSubViewHgtConstraint.constant = 390
            collectionHEightConstaint.constant = 30
            self.view.layoutIfNeeded()
        }
   //     cell.lblSubjectName.sizeToFit()
//        cell.lblcellconstantHeight.constant  = cell.bounds.height
//        cellHeight = Int(cell.lblcellconstantHeight.constant)

        return cell

    }
}



extension TestCraftListVC:SKProductsRequestDelegate, SKPaymentTransactionObserver
{
    func buyProduct(_ product: SKProduct) {
        print("Sending the Payment Request to Apple")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        SKPaymentQueue.default().add(self)
    }

    func restoreTransactions() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("didFailWithError: \(error)")
        self.hideActivityIndicator()

        NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppPurchasingErrorNotification), object: error.localizedDescription)
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Got the request from Apple")
        let count: Int = response.products.count
        if count > 0 {
            _ = response.products
            let validProduct: SKProduct = response.products[0]
            print("localizedTitle: ",validProduct.localizedTitle)
            print("localizedDescription: ",validProduct.localizedDescription)
            print("price: ",validProduct.price)
            buyProduct(validProduct);
            print("products")
        }
        else {
            print("No products")
            self.hideActivityIndicator()
        }

    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("Received Payment Transaction Response from Apple");

        for transaction: AnyObject in transactions {
            if let trans: SKPaymentTransaction = transaction as? SKPaymentTransaction {
                print("transaction state \(trans.transactionState)")

                switch trans.transactionState {
                case .purchased:
                    print("Product Purchased")
                    print("sucessProduct Purchased",trans.transactionIdentifier!)
                    strTranstionId = trans.transactionIdentifier!
                    savePurchasedProductIdentifier(trans.payment.productIdentifier)
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppProductPurchasedNotification), object: nil)

                    receiptValidation()

//                    let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
//                    self.Update_Payment_Api(OrderID: temp_Globle_Order_ID, ExternalTransactionStatus: "success", ExternalTransactionID: temp_Globle_PaymentTransaction_ID, StudentID: "\(result.value(forKey: "StudentID") ?? "")")


                    break

                case .failed:
                    print("Purchased Failed")
                    self.hideActivityIndicator()
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppPurchaseFailedNotification), object: nil)
                    print("transaction state \(transaction.transactionState)")

//                    let alert = UIAlertController(title: "Purchased Failed", message: "", preferredStyle: UIAlertController.Style.alert)
//                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
//                        //Bhargav Hide
//                        ////print("User click Ok button")
//                        //                        self.PrompPopup()
//                    }
//                    alert.addAction(action1)
//                    self.present(alert, animated: true, completion: {
//                        //Bhargav Hide
//                        ////print("completion block")
//                    })
//
                    break

                case .restored:
                    print("Product Restored")
                    self.hideActivityIndicator()
                    savePurchasedProductIdentifier(trans.payment.productIdentifier)
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppProductRestoredNotification), object: nil)
                    break

                default:
                    break
                }
            }
            else {

            }
        }
    }

    func savePurchasedProductIdentifier(_ productIdentifier: String!) {
        UserDefaults.standard.set(productIdentifier, forKey: productIdentifier)
        UserDefaults.standard.synchronize()
    }

    func receiptValidation() {

        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let jsonDict: [String: AnyObject] = ["receipt-data" : recieptString! as AnyObject, "password" : "dab3f8e770384d99ae7dda0096529a30" as AnyObject]

        do {
            let requestData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let storeURL = URL(string: API.verifyReceiptURLInappPurchase)!
            var storeRequest = URLRequest(url: storeURL)
            print("Send receipt Validation:",jsonDict,API.verifyReceiptURLInappPurchase)
            storeRequest.httpMethod = "POST"
            storeRequest.httpBody = requestData
            storeRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) in
                self!.hideActivityIndicator()

                do {
                    let jsonResponse:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(jsonResponse)


//                    if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
//                        print(receiptInfo)
//                    }



                    DispatchQueue.main.async {
                        if let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                            print(jsonData)

                            self!.Insert_StudentSubscription_API(CourseID: "0", BoardID: "\(self!.BoardId)", StandardID: "\(self!.StandardId)", TypeID: "\(self!.CourseTypeID)")
                        // your non-consumable and non-renewing subscription receipts are in `in_app` array
                        // your auto-renewable subscription receipts are in `latest_receipt_info` array
                      }
                    }

//                    if let date = self!.getExpirationDateFromResponse(jsonResponse as! NSDictionary) {
//                        print(date)
//                    }




                  //  self!.Add_Coin_Api()

                } catch let parseError {
                    print("fatch Error: ",parseError)
                }
            })
            task.resume()
        } catch let parseError {
            print("parse Error: ",parseError)
        }
    }

    func getExpirationDateFromResponse(_ jsonResponse: NSDictionary) -> Date? {

        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {

            let lastReceipt = receiptInfo.lastObject as! NSDictionary
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"

            if let expiresDate = lastReceipt["expires_date"] as? String {
                return formatter.date(from: expiresDate)
            }

            return nil
        }
        else {
            return nil
        }
    }

    func unlockProduct(_ productIdentifier: String!) {
        showActivityIndicator()

        if SKPaymentQueue.canMakePayments() {
            let productID: NSSet = NSSet(object: productIdentifier ?? "")
            let productsRequest: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
            productsRequest.delegate = self
            productsRequest.start()
            print("Fetching Products")
        }
        else {
            print("Сan't make purchases")
            self.hideActivityIndicator()
            NotificationCenter.default.post(name: Notification.Name(rawValue: kInAppPurchasingErrorNotification), object: NSLocalizedString("CANT_MAKE_PURCHASES", comment: "Can't make purchases"))

        }
    }
        func Add_Coin_Api()
        {
            showActivityIndicator()
    //        (string StudentID, string Credit, string Debit, string PackageID)
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary


            let params = ["Debit":"", "Credit":self.strSelectCoin, "TestPackageID":"", "StudentID":"\(result.value(forKey: "StudentID") ?? "")"]
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
                        //      let arrData = json["data"].array
                        //      self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                        if isContinuePurchsedFromDetailScreen == "1"
                        {
                            isContinuePurchsedFromDetailScreen = "2"
                        }
                        self.Get_Coin_Globle_API()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.40) {
                            let alert = UIAlertController(title: "Coin added sucessfully.", message: "", preferredStyle: UIAlertController.Style.alert)
//                            let alert = UIAlertController(title: "Coin added sucessfully.", message: "Purchase another coin?", preferredStyle: UIAlertController.Style.alert)
                            let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                                //Bhargav Hide
                                ////print("User click Ok button")
                                //                        self.PrompPopup()
                                self.tabBarController?.tabBar.isHidden = false
                                self.navigationController?.popViewController(animated: false)

                            }
//                            let actionContinue = UIAlertAction(title: "Yes", style: .default) { (_) in
//                                //Bhargav Hide
//                                ////print("User click Ok button")
//                                //                        self.PrompPopup()
////                                self.navigationController?.popViewController(animated: true)
//
//                            }
                            alert.addAction(action1)
//                            alert.addAction(actionContinue)
                            self.present(alert, animated: true, completion: {
                                //Bhargav Hide
                                ////print("completion block")
                            })

                        }
//                        if amount == "0"
//                        {
//                        }else{
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
//                        }
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





