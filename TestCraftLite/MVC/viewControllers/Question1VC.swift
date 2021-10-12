//
//  Question1VC.swift
//  TestCraft
//
//  Created by ADMS on 14/05/19.
//  Copyright © 2019 ADMS. All rights reserved.
//
import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage
import WebKit;
//import Reachability

protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(myData: String)
}




class Question1VC: UIViewController, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()
    var delegate: MyDataSendingDelegateProtocol? = nil

    @IBOutlet var lblCountDown: UILabel!
    @IBOutlet var lblPage: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblMarks: UILabel!
    @IBOutlet var lblHintCount: UILabel!


    var allCellsText = [String]()
    var arrTestData = [arrTestList]()
//    var lastContentOffset: CGFloat = 0
    var arrSubmitSummary = [SubmitSummaryListModal]()

    @IBOutlet var quecollectionView:UICollectionView!
    @IBOutlet var queCollectionNewView:UICollectionView!
    @IBOutlet var queView:UIView!
    var redViewYPositionConstraint: NSLayoutConstraint?
    @IBOutlet var queWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var queCenterAlignUsername: NSLayoutConstraint!

    @IBOutlet var viewInfoPopup: UIView!
    @IBOutlet var viewInfoBackgroundPopup: UIView!
    @IBOutlet var btnInfoPopupClose: UIButton!
    
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
    
    
    @IBOutlet var imgInfoPopupDotCurrent:UIImageView!
    @IBOutlet var imgInfoPopupDotAnswerd:UIImageView!
    @IBOutlet var imgInfoPopupDotUnAnswered:UIImageView!
    @IBOutlet var imgInfoPopupDotReviewLater:UIImageView!
    @IBOutlet var imgInfoPopupDotNotVisited:UIImageView!


    @IBOutlet var imgQueMenuDotCurrent:UIImageView!
    @IBOutlet var imgQueMenuDotAnswerd:UIImageView!
    @IBOutlet var imgQueMenuDotUnAnswered:UIImageView!
    @IBOutlet var imgQueMenuDotReviewLater:UIImageView!
    @IBOutlet var imgQueMenuDotNotVisited:UIImageView!
    
    var arrQueAns = [Que_Ans_Model]()
    @IBOutlet var viewQuestionBackground: UIView!
    @IBOutlet var tblQuestion:UITableView!

    @IBOutlet var btnPrevious:UIButton!
    @IBOutlet var btnNext:UIButton!
    @IBOutlet var btnReport:UIButton!
    @IBOutlet var btnSubmit:UIButton!
    @IBOutlet var btnPause:UIButton!
    @IBOutlet var btnViewQue:UIButton!
    @IBOutlet var btnInfo:UIButton!
    
    @IBOutlet var imgReport:UIImageView!
    @IBOutlet var imgReadChanged:UIImageView!
    @IBOutlet var btnReadChanged:UIButton!
    @IBOutlet var imgHint:UIImageView!
    @IBOutlet var btnHint:UIButton!

    @IBOutlet var viewWebPopupExplain: UIView!
    @IBOutlet var subViewWebPopupExplain: UIView!
    @IBOutlet var webviewExplain: WKWebView!
    @IBOutlet var lblExplain: UILabel!

    @IBOutlet var viewSubmitPopup: UIView!
    @IBOutlet var subViewSubmitPopup: UIView!
    @IBOutlet var tblSubmit:UITableView!
    @IBOutlet var lblTitleSubmit: UILabel!
    @IBOutlet var btnFinalSubmit:UIButton!
    @IBOutlet var btnCloseFinalSubmit:UIButton!
    @IBOutlet var btnCloseBackFinalSubmit1:UIButton!

    var count_total_row = 0
    var int_Total_Hint = 0
    var int_Used_Hint = 0

    var rowHeights:[Int:CGFloat] = [:] //declaration of Dictionary
    var rowHeaderHeights:[Int:CGFloat] = [:] //declaration of Dictionary
    var strTestTitle = ""
    var strQueType = ""
    var strSelectedIndex = 0
    var strSectionSelectedIndex = 0
    var strTestID = ""
    var strStudentTestID = ""
    var intProdSeconds = Float()
    var SendContinueRequest = Float() // set in second
    var static_delay = Float()
    var timer = Timer()
    var isTimerRunning = false  // Make sure only one timer is running at a time
    
    var que_delay = 0.05
    var ans_delay = 0.10
    var refreshControl = UIRefreshControl()
    let reachability = NetworkReachabilityManager()//Reachability()
    var strSelectedNetwork = ""
    var strcellulerNetwork = ""

    @IBOutlet var left_Space: NSLayoutConstraint!
    @IBOutlet var Right_Space: NSLayoutConstraint!
    @IBOutlet var back_btn_width: NSLayoutConstraint!
    @IBOutlet var btnback:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        HideAll()
        subViewWebPopupExplain.addShadowWithRadius(7,16.0,0,color: UIColor.darkGray)
        subViewSubmitPopup.addShadowWithRadius(7,6.0,0,color: UIColor.darkGray)
        btnReadChanged.addTarget(self, action: #selector(ReadAgainClicked), for: .touchUpInside)
        btnHint.addTarget(self, action: #selector(HintClicked), for: .touchUpInside)
        queCollectionNewView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell")
        if UIDevice.current.userInterfaceIdiom == .pad {
            //Bhargav Hide
////print("iPad")
            que_delay = 0.05
            ans_delay = 0.10
            let temp_space = self.view.frame.width/5
            print("temp_space_______________________________________________________",temp_space)
            left_Space.constant = temp_space//50.0
            Right_Space.constant = temp_space//50.0
        }else{
            //Bhargav Hide 
////print("not iPad")
            que_delay = 0.10
            ans_delay = 0.10
            
        }
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_sender:)), for: UIControl.Event.valueChanged)
        tblQuestion.addSubview(refreshControl) // not required when using UITableViewController
        tblQuestion.delegate = self
//        tblQuestion.bounces = false
        // Do any additional setup after loading the view.  #selector(startEditing)
        apiGet_Que_ListApi()
        strSelectedNetwork = NetworkManager.shared.strStatus
        print("strStatus...........................................",NetworkManager.shared.strStatus)
        NetworkManager.shared.strMsgDisplay = "no"
        btnCloseBackFinalSubmit1.isUserInteractionEnabled = true

//        NotificationCenter.default
//            .addObserver(self,
//                         selector: #selector(statusManager),
//                         name: .reachabilityChanged,
//                         object: nil)
//        updateUserInterface()
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
//        do{
//            try reachability?.startListening()//startNotifier()
//            print("start listening.......................")
//        }catch{
//          print("could not start reachability notifier")
//        }
//
        //        lblCountDown.backgroundColor = UIColor(rgb: 0x0BAEC5)
        //        lblCountDown.addShadowWithRadius(0,10.0,1,color: UIColor.darkGray)
        //        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        static_delay = 10 // send data every 10 second
        lblTitle.text = strTestTitle
        tblQuestion.addShadowWithRadius(0,16.0,0,color: UIColor.darkGray)
        viewQuestionBackground.addShadowWithRadius(7,16.0,0,color: UIColor.darkGray)

        self.tabBarController?.tabBar.isHidden = true
        btnPrevious.isHidden = true
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0x10A8DD) //GetColor.blueHeaderText
        btnNext.addShadowWithRadius(2,btnNext.frame.width/6,0,color: GetColor.blueHeaderText)

        btnFinalSubmit.setTitleColor(UIColor.white, for: .normal)
        btnFinalSubmit.backgroundColor = UIColor(rgb: 0x10A8DD) //GetColor.blueHeaderText
        btnFinalSubmit.addShadowWithRadius(2,btnFinalSubmit.frame.width/6,0,color: GetColor.blueHeaderText)


        btnCloseFinalSubmit.setTitleColor(UIColor.white, for: .normal)
        btnCloseFinalSubmit.backgroundColor = UIColor(rgb: 0x10A8DD) //GetColor.blueHeaderText
        btnCloseFinalSubmit.addShadowWithRadius(2,btnFinalSubmit.frame.width/6,0,color: GetColor.blueHeaderText)

        //        int_Total_Hint = 5
        self.queView.isHidden = true
        //        self.hideRedViewAnimated(animated: false)
        //        btnReport.isHidden = true
        //        btnPause.isHidden = true
        //        btnNext.isHidden = true
        //        btnPrevious.isHidden = true
        //        btnSubmit.isHidden = true
        //        UIView.animate(withDuration: 0.3) {
        //            self.queView.frame.origin.x = 310
        //        }
        //        let transition = CATransition()
        //        transition.duration = 0.3
        //        transition.type = CATransitionType.push
        //        transition.subtype = CATransitionSubtype.fromLeft
        //        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //        self.queView.layer.add(transition, forKey: kCATransition)
        if arrTestData[0].StatusName == "Start Test"{
            SetInfoPopupdata(strTitle: strTestTitle, strChName: "\(arrTestData[0].SubjectName )", strTechName: "\(arrTestData[0].TutorName ?? "")", strTotalMarks:"\(arrTestData[0].TestMarks ?? "")", strCourseName: "\(arrTestData[0].CourseName ?? "")", strTotalQue: "\(arrTestData[0].TotalQuestions ?? "")")
        }
        else
        {
            SetInfoPopupdata(strTitle: strTestTitle, strChName:"", strTechName: "", strTotalMarks:"", strCourseName: "", strTotalQue: "")
        }
        viewInfoPopup.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        

    }
    @objc func refresh(_sender: AnyObject) {
        // Code to refresh table view
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
////            for i in (0..<self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count)
////                                {
////                                    self.rowHeights[i] = 0.0
////                                }
////
////            Next_PreviousQue(str: "")
////            rowHeights.removeAll()
//
//            self.reloadTableview()
//                self.reloadView()
////        self.queView.isHidden = true
////        self.Next_PreviousQue(str: "")
////        self.queCollectionNewView.reloadData()
////        self.tblQuestion.reloadData()
////        self.reloadView()
//            self.Que_wish_ans_Api()
//            strSectionSelectedIndex = indexPath.section
//            strSelectedIndex = indexPath.item
            //            self.count_total_row = 0
//            let indexPath = NSIndexPath(row: indexPath.item, section: indexPath.section)
//            queCollectionNewView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            //            queCollectionNewView.reloadData()
            //            rowHeights.removeAll()
            //            self.reloadView()
            //            self.reloadTableview()
            //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
            //            self.lblPage.text = "\(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
            self.queView.isHidden = true
            self.Next_PreviousQue(str: "")

        self.refreshControl.endRefreshing()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        if isDeeplink == ""
        {
            back_btn_width.constant = 50
            btnback.isHidden = false
        }else{
            back_btn_width.constant = 0
            btnback.isHidden = true

        }
    }
    deinit {
        NetworkManager.shared.strMsgDisplay = ""
        NotificationCenter.default.removeObserver(self)
//        reachability.stopNotifier()
//        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)

    }

    func SetInfoPopupdata(strTitle: String,strChName: String,strTechName: String,strTotalMarks: String,strCourseName: String,strTotalQue: String)
    {
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
        
        imgInfoPopupDotCurrent.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotAnswerd.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotUnAnswered.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotReviewLater.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotNotVisited.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)

        imgQueMenuDotCurrent.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
        imgQueMenuDotAnswerd.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)
        imgQueMenuDotUnAnswered.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
        imgQueMenuDotReviewLater.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
        imgQueMenuDotNotVisited.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)
        //
        //        static var dotColorCurrent:UIColor    = UIColor(rgb: 0x3EA7E0)
        //        static var :UIColor    = UIColor.rbg(r: 216, g: 184, b: 52)
        //        static var :UIColor    = UIColor.rbg(r: 255, g: 0, b: 0)
        //        static var :UIColor    = UIColor.rbg(r: 107, g: 174, b: 24)
        //        static var :UIColor    = UIColor(rgb: 0xA3A3A3)
    }
    
    func hideRedViewAnimated(animated: Bool) {
        //remove current constraint
        //        self.removeRedViewYPositionConstraint()
        //        let hideConstraint = NSLayoutConstraint(item: self.queView,
        //                                                attribute: .left,
        //                                                relatedBy: .equal,
        //                                                toItem: self.view,
        //                                                attribute: .left,
        //                                                multiplier: 1,
        //                                                constant: 0)
        //        self.redViewYPositionConstraint = hideConstraint
        //        self.view.addConstraint(hideConstraint)
        //        //animate changes
        WidthQueLayout = 0
        //        self.performConstraintLayout(animated: animated)
    }
    
    func showRedViewAnimated(animated: Bool) {
        //remove current constraint
        //        self.removeRedViewYPositionConstraint()
        //        let centerYConstraint = NSLayoutConstraint(item: self.queView,
        //                                                   attribute: .centerX,
        //                                                   relatedBy: .equal,
        //                                                   toItem: self.view,
        //                                                   attribute: .centerX,
        //                                                   multiplier: 1,
        //                                                   constant: 0)
        //        self.redViewYPositionConstraint = centerYConstraint
        //        self.view.addConstraint(centerYConstraint)
        //        //animate changes
        WidthQueLayout = self.view.frame.size.width
        self.performConstraintLayout(animated: animated)
    }
    
    var WidthQueLayout : CGFloat = 0
    func performConstraintLayout(animated: Bool) {
        if animated == true {
            //            UIView.animate(withDuration: 5.0,
            ////                           delay: 0,
            ////                           usingSpringWithDamping: 0.5,
            ////                           initialSpringVelocity: 0.6,
            ////                           options: .transitionCurlDown,
            //                           animations: { () -> Void in
            //                            self.queWidthConstraint.constant = self.WidthQueLayout
            //                            self.view.layoutIfNeeded()
            //            }, completion: nil)
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                //                self.queCenterAlignUsername.constant += self.view.bounds.width
                self.queWidthConstraint.constant = self.WidthQueLayout
                self.view.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            //            self.queCenterAlignUsername.constant += self.WidthQueLayout//self.view.bounds.width
            self.queWidthConstraint.constant = self.WidthQueLayout
            self.view.layoutIfNeeded()
        }
    }
    
    func removeRedViewYPositionConstraint() {
        if redViewYPositionConstraint != nil {
            self.view.removeConstraint(self.redViewYPositionConstraint!)
            self.redViewYPositionConstraint = nil
        }
    }
    
    func isRedViewVisible() -> Bool {
        return self.view.bounds.contains(self.queView.frame.origin)
    }
    
    
    func HideAll() {
        viewWebPopupExplain.isHidden = true
        viewSubmitPopup.isHidden = true
        btnReport.isHidden = true
        btnPause.isHidden = true
        btnNext.isHidden = true
        //        btnPrevious.isHidden = true
        lblMarks.isHidden = true
        btnSubmit.isHidden = true
        imgReport.isHidden = true
        lblCountDown.isHidden = true
        lblHintCount.isHidden = true

        lblPage.isHidden = true
        imgReadChanged.isHidden = true
        btnReadChanged.isHidden = true
        btnViewQue.isHidden = true
        btnInfo.isHidden = true
        btnHint.isHidden = true
    }
    func ShowAll() {
        btnPause.isHidden = false
        btnNext.isHidden = false
        //        btnPrevious.isHidden = false
        lblMarks.isHidden = false
        btnSubmit.isHidden = false
        imgReport.isHidden = false
        btnReport.isHidden = false
        lblCountDown.isHidden = false
        lblHintCount.isHidden = false
        lblPage.isHidden = false
        imgReadChanged.isHidden = false
        btnReadChanged.isHidden = false
        btnViewQue.isHidden = false
        btnInfo.isHidden = false
        btnHint.isHidden = false
    }
    
    func reloadView() {
        btnReadChanged.setImage(nil, for: .normal)
        var oldvalue = 0
        for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        {
            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
            {
                oldvalue = i
            }
            i += 1
        }
        if oldvalue == 0
        {
            btnNext.setTitle("Skip", for: .normal)
        }
        else
        {
            btnNext.setTitle("Next", for: .normal)
        }

        if strSelectedIndex == arrQueAns[self.strSectionSelectedIndex].arr_section_que.count - 1{
            if(strSectionSelectedIndex == arrQueAns.count - 1)
            {
                btnNext.setTitle("Submit Test", for: .normal)
            }
            else
            {
                btnNext.isHidden = false
            }
        }else{
            btnNext.isHidden = false
        }

        if int_Used_Hint == 0 && int_Total_Hint == 0
        {
            lblHintCount.isHidden = true
            btnHint.isHidden = true
            imgHint.isHidden = true

        }
        else
        {
            //            lblHintCount.isHidden = false
            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint == ""
            {
                btnHint.isHidden = true
                imgHint.isHidden = true
                lblHintCount.isHidden = true

            }
            else
            {
                btnHint.isHidden = false
                imgHint.isHidden = false
                lblHintCount.isHidden = false
            }
        }

        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_HintUsed == "1"
        {
            btnHint.setImage(UIImage(named: "bulb-yellow.png"), for: .normal)//isHidden = true
        }
        else
        {
            btnHint.setImage(UIImage(named: "bulb-fill.png"), for: .normal)//isHidden = true
        }

        lblMarks.text = "Marks: " + arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_marks
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review == "1"
        {
            let imageName = "rotate_eye_blue.png"
            imgReadChanged.image = UIImage(named: imageName)
        }
        else
        {
            let imageName = "rotate_eye_gray.png"
            imgReadChanged.image = UIImage(named: imageName)
        }
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue == "1"
        {
            let imageName = "risk_blue.png"
            self.imgReport.image = UIImage(named: imageName)
            self.btnReport.setTitleColor(GetColor.themeBlueColor, for: .normal)
        }
        else
        {
            let imageName = "risk_blue.png"
            self.imgReport.image = UIImage(named: imageName)
            self.btnReport.setTitleColor(GetColor.themeBlueColor, for: .normal)
        }
    }
    func runProdTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProdTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        let imageName = "watch-que-icon.png"//"pause.png"
        btnPause.setImage(UIImage(named: imageName), for: .normal)
        
    }
    var per_que_time = 0
    @objc func updateProdTimer() {
        if intProdSeconds < 1 {
            timer.invalidate()
            lblCountDown.text = "00:00"
            lblHintCount.text = "0"
            TimeOverPopup()
        }
        else {
            CheckNetworkConnection() // added in 27 Dec 2019
            intProdSeconds -= 1
            per_que_time += 1
            popup_time_counter += 1
            lblCountDown.text = prodTimeString(time: TimeInterval(intProdSeconds))
            lblHintCount.text = "\(int_Used_Hint)/\(int_Total_Hint)"
            //Bhargav Hide
            ////print("SendContinueRequest ====== \(SendContinueRequest) = \(intProdSeconds)")

            // Example:
//abc
            if SendContinueRequest == intProdSeconds
            {
                SendContinueRequest -= static_delay // for
                Continue_Send_Request_Que_wish_ans_Api()
            }
            //            if int_Used_Hint == 0 && int_Total_Hint == 0
            //            {
            //                lblHintCount.isHidden = true
            //            }
            //            else
            //            {
            //                lblHintCount.isHidden = false
            //            }
            //Bhargav Hide
            ////print("popup_time_counter ________________________ \(per_que_time) = \(popup_time_counter)")
            if popup_time_counter == 60 {
                //                alertWebview.dismiss(animated: true, completion: nil)
                viewWebPopupExplain.isHidden = true
                //                viewSubmitPopup.isHidden = true
                Report_alert.dismiss(animated: true, completion: nil)
                SubmitAlertMessage.dismiss(animated: true, completion: nil)
                counter_alert = UIAlertController(title: "Alert!!", message: "Do you require more time in this question?", preferredStyle: .alert)
                let actionYes = UIAlertAction(title: "Yes", style: .cancel, handler: {(alert: UIAlertAction!) in
                    self.popup_time_counter = 0
                })

                let action = UIAlertAction(title: "No", style: .default, handler: {(alert: UIAlertAction!) in
                    self.Que_wish_ans_Api()
                    if self.btnNext.titleLabel?.text == "Submit Test"
                    {
                        //                        self.viewSubmitPopup.isHidden = false
                        self.Pre_Submit_Test_Api()
                        //                        self.submitTest()
                    }else{
                        self.strSelectedIndex = self.strSelectedIndex + 1
                        if self.strSelectedIndex == self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count{
                            self.strSectionSelectedIndex = self.strSectionSelectedIndex + 1
                            self.strSelectedIndex = 0
                        }
                        self.Next_PreviousQue(str: "")
                    }
                    self.popup_time_counter = 0
                })
                //                let actionClose = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                counter_alert.addAction(actionYes)
                counter_alert.addAction(action)
                //                counter_alert.addAction(actionClose)
                self.present(counter_alert, animated: true, completion: nil)

            }
            else if popup_time_counter >= 120
            {
                if NSClassFromString("UIAlertController") != nil {
                    self.counter_alert.dismiss(animated: true, completion: nil)
                }

                let inMin = popup_time_counter / 60
                //                let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
                //                if counter_alert != nil
                //                {
                //                        counter_alert.dismiss(animated: false, completion: nil)
                //                }
                
                //                Do you requere more time to this que
                //                no next que
                //                yes to continue
                //                after 2 min no any movement than back to screen
                //                if inMin == 2
                //                {
                timer.invalidate()
                //                self.navigationController?.popViewController(animated: false)
                for controller in self.navigationController!.viewControllers as Array {
                    //Bhargav Hide
                    ////print(controller)
                    if controller.isKind(of: TestListVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }

                //                }
                //                }
                //                popup_time_counter += 60
            }
        }
    }
    var popup_time_counter = 0
    var counter_alert = UIAlertController()

    // Request send Continue
    //    func execute() {
    //        // do logic here
    //    }
    //
    func calculation_send_Data() -> [String: String] {
        
        var queid_with_ansid = ""
        //        for var i in (0..<arrQueAns.count)
        //        {
        let que_id = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_id)"
        var my_ans_id = ""
        var multi_ans_id = ""
        let true_ans = ""
        var str_true_false = ""
        let TestQuestionID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].test_que_id)"
        let QuestionTypeID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type)"
        let str_per_que_time = "\(per_que_time)"
        let strReview = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review)"

        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer == "" || self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer == "0"
        {
            per_que_time = 0
            //            popup_time_counter = 60
        } else {
            per_que_time = Int(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer) ?? 0
            //            popup_time_counter = per_que_time + 60
        } //Set Old Time
        
        self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer = "\(per_que_time)"
        for var j in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        {
            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].selected == "1"
            {
                my_ans_id = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].id)"
                multi_ans_id += "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].id),"
                if QuestionTypeID == "4"{str_true_false = "\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[j].name)"}
            }
            j += 1
        }
        var str_Send_Answer = ""
        if QuestionTypeID == "1"
        {
            str_Send_Answer = my_ans_id
        }
        else if QuestionTypeID == "2" || QuestionTypeID == "8"
        {
            str_Send_Answer = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans)"
        }
        else if QuestionTypeID == "4"
        {
            if str_true_false == ""
            {
                str_Send_Answer = ""
            }
            else if str_true_false == "True"
            {
                str_Send_Answer = "1"
            }
            else if str_true_false == "False"
            {
                str_Send_Answer = "0"
            }
        }
        else if QuestionTypeID == "7"
        {
            if multi_ans_id.count > 1{
                multi_ans_id.remove(at: multi_ans_id.index(before: multi_ans_id.endIndex))
                //                multi_ans_id.dropLast()
                // "Hello, Worl"
            }
            str_Send_Answer = multi_ans_id
        }
        //Bhargav Hide
////print("\(que_id) : \(my_ans_id) - \(true_ans)")
        
        queid_with_ansid = "\(queid_with_ansid)" + "\(que_id)|\(my_ans_id),"
        //            i += 1
        //        }
        //Bhargav Hide
////print("Test_ID: ",strTestID)
        //Bhargav Hide
////print("queid_with_ansid: ",queid_with_ansid)
        let params = ["StudentTestID":strStudentTestID,"TestQuestionID":TestQuestionID,"QuestionID":que_id,"QuestionTypeID":QuestionTypeID,"Answer":str_Send_Answer,"UseTime":str_per_que_time,"Review":strReview]
        return params
        
    }
    func Continue_Send_Request_Que_wish_ans_Api()
    {
        let params = calculation_send_Data()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
////print("Send continue API, Params: \n",API.Insert_Test_AnswerApi,params)
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

        //        Alamofire.request(API.Insert_Test_AnswerApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
        //            self.hideActivityIndicator()
        Alamofire.request(API.Insert_Test_AnswerApi, method: .post, parameters: params, headers: headers)
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in

                    switch response.result {
                    case .success(let value):

                        let json = JSON(value)
                        //Bhargav Hide
////print("Send continue ANS : ",json)

                        if(json["Status"] == "true" || json["Status"] == "1") {
                            //                            let arrData = json["data"].array
                            //                            var crct = ""
                            //                            var Incrct = ""
                            //                            var NotAnswer = ""
                            //                            var Total = ""
                            //
                            //                            for value in arrData! {
                            //
                            //                                crct = value["Correct"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                                Incrct = value["Wrong"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                                NotAnswer = value["UnAnswered"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                                Total = value["TotalMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                            }
                            //                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
                            //                            vc!.strCorrect = "\(crct)"
                            //                            vc!.strInCorrect = "\(Incrct)"
                            //                            vc!.strUnanswered = "\(NotAnswer)"
                            //                            vc!.strTotal = "\(Total)"
                            //                            vc!.strTestID = self.strTestID
                            //                            vc!.strStudentTestID = self.strStudentTestID
                            //                            vc!.strTitle = self.strTestTitle
                            //                            self.navigationController?.pushViewController(vc!, animated: true)
                        }
                        else
                        {
                            self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                        }
                    case .failure(let error):
                        self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                    }
            })
    }
    

    func prodTimeString(time: TimeInterval) -> String {
        let prodHours = Int(time) / 3600 % 60
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60
        //Bhargav Hide
////print("%02d : %02d : %02d", prodHours, prodMinutes, prodSeconds)
        //        if prodSeconds % 2 == 0 {
        //even Number
        return String(format: "%02d:%02d:%02d", prodHours, prodMinutes, prodSeconds)
        //        } else {
        //            // Odd number
        //            return String(format: "%02d   %02d", prodMinutes, prodSeconds)
        //        }
    }
    
    
    @objc func TimeOverPopup() {
        //        alertWebview.dismiss(animated: true, completion: nil)
        viewWebPopupExplain.isHidden = true
        // Time over popup
        timer.invalidate()

        SubmitAlertMessage.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Your test time is over", message: "", preferredStyle: .alert)
        alert.setValue(UIImage(named: "risk_blue"), forKey: "image")

//        alert.setTitleImage(UIImage(named: "risk_blue"))
        // Add actions
        //        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //        action.actionImage = UIImage(named: "close")
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: doSomething))
        //        alert.addAction(UIAlertAction(title: "Answer has an Error", style: .destructive, handler: {(alert: UIAlertAction!) in
        //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
        //            self.tblQuestion.reloadData()
        //        }))
        //        alert.addAction(UIAlertAction(title: "Other Reason", style: .destructive, handler: {(alert: UIAlertAction!) in
        //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
        //            self.tblQuestion.reloadData()
        //        }))
        //            AlertController.setValue(UIColor.orange, forKey: "titleTextColor")
        
        //            alert
        //                        alert.setValue(UIColor.orange, forKey: "titleTextColor")
        
        //        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

    @objc func loadExpViewPopup(strUrl:String, strTitle:String) {
        viewWebPopupExplain.isHidden = false
        lblExplain.text = strTitle
        let baseurl = URL.init(string: API.imageUrl2.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

        webviewExplain.loadHTMLString(strUrl, baseURL: baseurl)
//        webviewExplain.scalesPageToFit = true
        webviewExplain.scrollView.bounces = false
    }
    @IBAction func viewWebPopupExplainClicked(_ sender: AnyObject) {
        viewWebPopupExplain.isHidden = true
    }

    @IBAction func BackClicked(_ sender: AnyObject) {
        //        SJSwiftSideMenuController.toggleLeftSideMenu()
        //    arrPath.removeLast()
        //        navigationController?.popViewController(animated: true)

        //        if NSClassFromString("UIAlertController") != nil {
        //            self.counter_alert.dismiss(animated: true, completion: nil)
        //        }
// "Resume?", message: "Are you sure you want to resume a test?"
        //        timer.invalidate()

        let alert = UIAlertController(title: "Leave?", message: "Are you sure you wish to leave the test?", preferredStyle: .alert)
        //                alert.setTitleImage(UIImage(named: "risk_blue"))
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            //            self.runProdTimer()
            
            
        })
        //        action.actionImage = UIImage(named: "close")
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
            self.timer.invalidate()
          //  self.delegate?.sendDataToFirstViewController(myData:"Resume")

            //            self.navigationController?.popViewController(animated: false)
            for controller in self.navigationController!.viewControllers as Array {
                //Bhargav Hide
////print(controller)
                if controller.isKind(of: MyPackageListVCViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
//                else if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                    //                            self
//                    controller.tabBarController!.selectedIndex = 0
//                    //                                controller.tabBarController?.tabBarItem
//                    self.navigationController!.popToViewController(controller, animated: false)
//                    break
//                }
//                else if controller.isKind(of: SelectExamLangVC.self) {
//                    //                            self
//                    //                controller.tabBarController!.selectedIndex = 0
//                    //                //                                controller.tabBarController?.tabBarItem
//                    self.navigationController!.popToViewController(controller, animated: false)
//                    break
//                }

            }

        }))
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func InfoClicked(_ sender: AnyObject) {
        viewInfoPopup.isHidden = false
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2002", comment: "Test Information", isFirstTime: "0")
    }
    @IBAction func InfoCloseClicked(_ sender: AnyObject) {
        viewInfoPopup.isHidden = true
    }
    @IBAction func SubmitClicked(_ sender: AnyObject) {
//        submitTest()
//        viewSubmitPopup.isHidden = false
        Pre_Submit_Test_Api()
    }
    @IBAction func SubmitPopupCloseClicked(_ sender: AnyObject) {
        viewSubmitPopup.isHidden = true
    }
    @IBAction func FinalSubmitClicked(_ sender: AnyObject) {
//        submitTest()
        viewSubmitPopup.isHidden = true
        timer.invalidate()
        Que_Ans_Submit_Api()
    }

    @IBAction func hideQuePopupView(_ sender: AnyObject) {
        self.queView.isHidden = true
        //        self.hideRedViewAnimated(animated: false)
    }
    
    @IBAction func viewQueClicked(_ sender: AnyObject) {
        self.queView.isHidden = false
        //        self.showRedViewAnimated(animated: false)
        
        //        self.queView.isHidden = false
        //                UIView.animate(withDuration: 0.3) {
        //                    self.queView.frame.origin.x = 0
        //                }
        //        let transition = CATransition()
        //        transition.duration = 0.3
        //        transition.type = CATransitionType.push
        //        transition.subtype = CATransitionSubtype.fromRight
        //        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //        self.queView.layer.add(transition, forKey: kCATransition)
        
        //        UIView.animate(withDuration: 1.0,
        //                       delay: 0.0,
        //                       options: [],
        //                       animations: {
        //
        //                        self.queView.backgroundColor = .yellow
        //                        //self.blueView.alpha = 0.0
        //                        self.queView.frame.size.width -= 80
        //                        self.queView.frame.size.height -= 169
        //
        //                        //self.blueView.frame.origin.x += 120
        //                        self.queView.frame.origin.x -= 50
        //                        self.queView.frame.origin.y -= 150
        //        },
        //                       completion: { _ in
        //
        ////                        UIView.animate(withDuration: 1.0,
        ////                                       delay: 0.0,
        ////                                       options: [],
        ////                                       animations: {
        ////
        ////                                        self.queView.frame.origin.x += 170
        ////                        },
        ////                                       completion: { _ in
        ////
        ////                                        UIView.animate(withDuration: 1.0,
        ////                                                       delay: 0.0,
        ////                                                       options: [],
        ////                                                       animations: {
        ////
        ////                                                        self.queView.frame.origin.x -= 120
        ////                                                        self.queView.frame.origin.y += 150
        ////
        ////                                                        self.queView.frame.size.width += 80
        ////                                                        self.queView.frame.size.height += 169
        ////                                        },
        ////                                                       completion: nil)
        ////                        })
        //
        //        })
        
    }
    
    var SubmitAlertMessage = UIAlertController()
    func submitTest()
    {

        //        timer.invalidate()
        if NSClassFromString("UIAlertController") != nil {
            self.counter_alert.dismiss(animated: true, completion: nil)
        }
        Report_alert.dismiss(animated: true, completion: nil)
        SubmitAlertMessage.dismiss(animated: true, completion: nil)

        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        SubmitAlertMessage = UIAlertController(title: "Done?", message: "Are you sure you want to end this test?", preferredStyle: .alert)
        //"Hey \(result.value(forKey: "StudentFirstName") ?? "") are you sure you want to end this test?"
        let action = UIAlertAction(title: "OK", style: .default, handler: doSomething)
        let actionClose = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(alert: UIAlertAction!) in
            //            self.runProdTimer()
        })
        SubmitAlertMessage.addAction(action)
        SubmitAlertMessage.addAction(actionClose)
        
        self.present(SubmitAlertMessage, animated: true, completion: nil)
    }
    func doSomething(action: UIAlertAction) {
        //Use action.title
//        @IBOutlet var btnCloseFinalSubmit:UIButton!
//        @IBOutlet var btnCloseBackFinalSubmit1:UIButton!
        btnCloseFinalSubmit.isUserInteractionEnabled = false
        btnCloseBackFinalSubmit1.isUserInteractionEnabled = false
        btnCloseFinalSubmit.isHidden = true
//                    //            self.navigationController?.popViewController(animated: false)
//                    for controller in self.navigationController!.viewControllers as Array {
//                        //Bhargav Hide
//        ////print(controller)
//                        if controller.isKind(of: TestListVC.self) {
//                            self.navigationController!.popToViewController(controller, animated: true)
//                            break
//                        }
//                    }

//        timer.invalidate()
        Pre_Submit_Test_Api()

//        Que_Ans_Submit_Api()
        
        
    }
    
    //    let alert = UIAlertController(title: "Alert Title", message: "Alert Message", style = .Alert)
    //    for i in ["hearts", "spades", "diamonds", "hearts"] {
    //    alert.addAction(UIAlertAction(title: i, style: .Default, handler: doSomething)
    //    }
    //    self.presentViewController(alert, animated: true, completion: nil)
    //    var alertWebview = UIAlertController()
    func Insert_Hint_Api()
    {
        //            let params =
        let que_id = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_id)"
        //            var my_ans_id = ""
        //            var multi_ans_id = ""
        //            let true_ans = ""
        //            var str_true_false = ""
        //            let TestQuestionID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].test_que_id)"
        //            let QuestionTypeID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type)"
        //            let str_per_que_time = "\(per_que_time)"
        //            let strReview = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review)"

        let params = ["StudentTestID":strStudentTestID,"QuestionID":que_id]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
////print("Send continue API, Params: \n",API.Insert_Test_HintApi,params)
        let queue = DispatchQueue(label: "com.cnoon.response-queue", qos: .utility, attributes: [.concurrent])

        //        Alamofire.request(API.Insert_Test_AnswerApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
        //            self.hideActivityIndicator()
        Alamofire.request(API.Insert_Test_HintApi, method: .post, parameters: params, headers: headers)
            .response(
                queue: queue,
                responseSerializer: DataRequest.jsonResponseSerializer(),
                completionHandler: { response in

                    switch response.result {
                    case .success(let value):

                        let json = JSON(value)
                        //Bhargav Hide
////print("Send continue ANS : ",json)

                        if(json["Status"] == "true" || json["Status"] == "1") {
                            //                            let arrData = json["data"].array
                            //                            var crct = ""
                            //                            var Incrct = ""
                            //                            var NotAnswer = ""
                            //                            var Total = ""
                            //
                            //                            for value in arrData! {
                            //
                            //                                crct = value["Correct"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                                Incrct = value["Wrong"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                                NotAnswer = value["UnAnswered"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                                Total = value["TotalMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                            //                            }
                            //                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
                            //                            vc!.strCorrect = "\(crct)"
                            //                            vc!.strInCorrect = "\(Incrct)"
                            //                            vc!.strUnanswered = "\(NotAnswer)"
                            //                            vc!.strTotal = "\(Total)"
                            //                            vc!.strTestID = self.strTestID
                            //                            vc!.strStudentTestID = self.strStudentTestID
                            //                            vc!.strTitle = self.strTestTitle
                            //                            self.navigationController?.pushViewController(vc!, animated: true)
                        }
                        else
                        {
                            self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                        }
                    case .failure(let error):
                        self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                    }
            })
    }
    @objc func HintClicked(sender: UIButton) {
        //        var int_Total_Hint = 0
        //Bhargav Hide
////print("\(int_Total_Hint) == \(int_Used_Hint)")
        //        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint == ""
        //        {
        ////            btnHint.isHidden = true
        ////            imgHint.isHidden = true
        //        }
        //        else
        //        {
        //Bhargav Hide
////print(int_Total_Hint,int_Used_Hint)
//        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2004", comment: "Flag", isFirstTime: "0")
        if int_Total_Hint == int_Used_Hint
        {
            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_HintUsed == "1"
            {
                //                let htmlString = "<html><body style='background-color:clear;'><br><p style='color:#000000; font-family:Inter-Regular'><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</font></p></body></html>"
                let htmlString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background-color:clear;'><div style='color:#000000; font-family:Inter-Regular; FONT-SIZE :14PX; LINE-HIGHT : 12PX;vertical-align: middle'>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</div></body></html>"

                self.loadExpViewPopup(strUrl: htmlString, strTitle: "Hint")
            }
            else
            {
                self.view.makeToast("Sorry! Your hint limit is over", duration: 3.0, position: .bottom)
            }
            return
        }
        Insert_Hint_Api()
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_HintUsed == "1"
        {
        }
        else
        {
            int_Used_Hint += 1
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_HintUsed = "1"
        }
        //        let htmlString = "<html><body style='background-color:clear;'><br><p style='color:#000000; font-family:Inter-Regular'><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</font></p></body></html>"
        let htmlString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background-color:clear;'><div style='color:#000000; font-family:Inter-Regular; FONT-SIZE :14PX; LINE-HIGHT : 12PX; vertical-align: middle'>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</div></body></html>"
        self.loadExpViewPopup(strUrl: htmlString, strTitle: "Hint")
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_HintUsed == "1"
        {
            btnHint.setImage(UIImage(named: "bulb-yellow.png"), for: .normal)//isHidden = true
        }
        else
        {
            btnHint.setImage(UIImage(named: "bulb-fill.png"), for: .normal)//isHidden = true
        }

        //            }

        ////        var alert = UIAlertController()
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            //Bhargav Hide
////print("iPad")
        //            alertWebview = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        //
        //        }else{
        //            //Bhargav Hide
////print("not iPad")
        //            alertWebview = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        //
        //        }
        //
        //        let cancel = UIAlertAction(title: "Close", style: UIAlertAction.Style.destructive, handler: nil)
        //        let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 18.0)!]
        //        let titleAttrString = NSMutableAttributedString(string: "Hint", attributes: titleFont)
        //        alertWebview.setValue(titleAttrString, forKey: "attributedMessage")
        //
        //        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertWebview.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        //        //        let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height - 20)
        //        //        let x_axis:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.leftMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 10)
        //        ////        alert.view.addConstraint(x_axis);
        //        alertWebview.view.addConstraint(height);
        //        //        alert.view.addConstraint(width);
        //        alertWebview.view.frame.origin.y = 60
        //        //        alert.view.frame.size.height = self.view.frame.height * 0.90
        //        alertWebview.view.frame.size.height = self.view.frame.height * 0.90
        //        alertWebview.view.frame.size.width = self.view.frame.width - 20
        //        let web = UIWebView(frame: CGRect(x: 2, y: alertWebview.view.frame.origin.y + 10, width: alertWebview.view.frame.size.width, height: self.view.frame.size.height * 0.85 - 95)) // take note that right here, in the height:, I’ve changed 0.8 to 0.85 so it should look more consistent on the top and bottom
        //        let htmlString = "<html><body style='background-color:clear;'><br><p><font size=10>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</font></p></body></html>"//<br><p align=center><font size=30  align=center><b>" + "Explanation" + "</b></font></p><p><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
        //
        //        web.loadHTMLString(htmlString, baseURL: nil)
        //        //        web.backgroundColor = UIColor.lightGray
        //        //        web.scrollView.backgroundColor = UIColor.lightGray
        //        //        let requestURL = NSURL(string: "http://www.google.it");
        //        //        let request = NSURLRequest(url: requestURL! as URL);
        //        //        web.loadRequest(request as URLRequest);
        //        web.scalesPageToFit = true
        //        //        web.loadRequest(request as URLRequest)
        //        //        web.scrollView.bouncesZoom = false
        //        web.scrollView.bounces = false
        //        //        web.scrollView.
        //        //        let htmlString = "<p>Identify the arrow-marked structures in the images<img alt=\"\" src=\"https://dams-apps-production.s3.ap-south-1.amazonaws.com/course_file_meta/73857742.PNG\"></p>"
        //
        //        alertWebview.view.addSubview(web)
        //        alertWebview.addAction(cancel)
        //        self.present(alertWebview, animated: false, completion: nil)
    }
    
    @objc func ReadAgainClicked(sender: UIButton) {
        let buttonTag = sender.tag
        // Do any additional setup
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review == "1"
        {
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review = "0"
        }
        else
        {
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review = "1"
        }
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2004", comment: "Flag", isFirstTime: "0")

        Continue_Send_Request_Que_wish_ans_Api()
        //        self.quecollectionView.reloadData()
        self.queCollectionNewView.reloadData()
        self.reloadView()
        
        //        UIView.transition(with: self.tblQuestion,
        //                          duration: 0.35,
        //                          options: .curveEaseInOut,
        //                          animations: { self.tblQuestion.reloadData() })
        
        
    }
    @IBAction func PauseClicked(_ sender: AnyObject) {
        //        //        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue == "1"
        //        //        {
        //        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue = "0"
        //        //        }
        //        //        else
        //        //        {
        //        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue = "1"
        //        //
        //        // Create AlertController
        //        let imageName = "watch-que-icon.png"//"play.png"
        //        btnPause.setImage(UIImage(named: imageName), for: .normal)
        //        timer.invalidate()
        ////        let alert = AlertController(title: "Test Paused", message: "", preferredStyle: .actionSheet)
        //        var alert = AlertController()
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            //Bhargav Hide
////print("iPad")
        //            alert = AlertController(title: "Test Paused", message: "", preferredStyle: UIAlertController.Style.alert)
        //
        //        }else{
        //            //Bhargav Hide
////print("not iPad")
        //            alert = AlertController(title: "Test Paused", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        //
        //        }
        //        //        alert.setTitleImage(UIImage(named: ""))
        //        // Add actions
        //        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
        //            self.runProdTimer()
        //
        //        })
        //        action.actionImage = UIImage(named: "close")
        //        alert.addAction(UIAlertAction(title: "Resume", style: .default, handler: {(alert: UIAlertAction!) in
        //            self.runProdTimer()
        //
        //        }))
        //        //            alert.addAction(UIAlertAction(title: "Help", style: .destructive, handler: {(alert: UIAlertAction!) in
        //        //                self.runProdTimer()
        //        //            }))
        //        alert.addAction(UIAlertAction(title: "Abort", style: .default, handler: {(alert: UIAlertAction!) in
        //            //            self.navigationController?.popViewController(animated: false)
        //            let alert = AlertController(title: "Abort Test", message: "Do you really want to abort the test", preferredStyle: .alert)
        //            //                alert.setTitleImage(UIImage(named: "risk_blue"))
        //            // Add actions
        //            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
        //                self.runProdTimer()
        //
        //
        //            })
        //            //        action.actionImage = UIImage(named: "close")
        //            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
        //                //            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        //                //            SJSwiftSideMenuController.pushViewController(vc!, animated: false)
        //                self.navigationController?.popViewController(animated: false)
        //
        //
        //            }))
        //            alert.addAction(action)
        //            self.present(alert, animated: true, completion: nil)
        //
        //        }))
        //        //            AlertController.setValue(UIColor.orange, forKey: "titleTextColor")
        //        alert.addAction(action)
        //        present(alert, animated: true, completion: nil)
        //
        //        //        }
        //        //        self.quecollectionView.reloadData()
        //        //reloadTableview()
        //
    }
    var Report_alert = AlertController()
    @IBAction func reportClicked(_ sender: AnyObject) {
        //        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue == "1"
        //        {
        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue = "0"
        //        }
        //        else
        //        {
        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue = "1"

        // Create AlertController
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2005", comment: "Report an issue", isFirstTime: "0")
        Report_alert = AlertController(title: "", message: "Report an issue", preferredStyle: .alert)
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 17.0)!]
        let titleAttrString = NSMutableAttributedString(string: "Report an issue", attributes: titleFont)
        Report_alert.setValue(titleAttrString, forKey: "attributedMessage")

        Report_alert.setTitleImage(UIImage(named: "risk_blue"))
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2104", comment: "Cancel Button", isFirstTime: "0")
               })
        action.actionImage = UIImage(named: "close")
        Report_alert.addAction(UIAlertAction(title: "Question has a problem", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.Report_Isue_Api(strSelection: "1", strIssueDescription: "Question has a problem")
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2101", comment: "Question has a problem", isFirstTime: "0")

            //                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
            //                self.reloadView()
        }))
        Report_alert.addAction(UIAlertAction(title: "Answer has a problem", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.Report_Isue_Api(strSelection: "2", strIssueDescription: "Answer has a problem")
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2102", comment: "Answer has a problem", isFirstTime: "0")

            //                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
            //                self.reloadView()
        }))
        //        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint == ""
        //        {
        //        }else
        //        {
        Report_alert.addAction(UIAlertAction(title: "Hint has a problem", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.Report_Isue_Api(strSelection: "3", strIssueDescription: "Hint has a problem")
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2103", comment: "Hint has a problem", isFirstTime: "0")

            //                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
            //                self.reloadView()
        }))

        //        }
        //            AlertController.setValue(UIColor.orange, forKey: "titleTextColor")
        Report_alert.addAction(action)
        present(Report_alert, animated: true, completion: nil)

        //        }
        //        //        self.quecollectionView.reloadData()
        //        //reloadTableview()

    }
    @IBAction func nextQue(_ sender: AnyObject) {
        if sender.titleLabel?.text == "Submit Test"
        {
            Que_wish_ans_Api()
            //            Continue_Send_Request_Que_wish_ans_Api()
            //            submitTest()
            //            viewSubmitPopup.isHidden = false
            Pre_Submit_Test_Api()
        }else
        {
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2007", comment: "Next/Skip Button", isFirstTime: "0")

            self.btnNext.isUserInteractionEnabled = false//
            self.Que_wish_ans_Api()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.40) {
                self.btnNext.isUserInteractionEnabled = true

            }//
            self.strSelectedIndex = self.strSelectedIndex + 1
            if self.strSelectedIndex == self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count{
                self.strSectionSelectedIndex = self.strSectionSelectedIndex + 1
                self.strSelectedIndex = 0
            }
            print("IndexSelected: \(self.strSelectedIndex) _____ Section: \(self.strSectionSelectedIndex)")
            //        self.count_total_row = 0
            //        self.quecollectionView.reloadData()
            //        let indexPath = NSIndexPath(row: strSelectedIndex, section: 0)
            //        quecollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            //        rowHeights.removeAll()
            //        self.reloadView()
            //        self.reloadTableview()
            //        self.lblPage.text = "\(self.strSelectedIndex + 1) /\(self.arrQueAns.count)"
            self.Next_PreviousQue(str: "")

        }
    }
    @IBAction func previousQue(_ sender: AnyObject) {
        strSelectedIndex = strSelectedIndex - 1
        if strSelectedIndex == arrQueAns[self.strSectionSelectedIndex].arr_section_que.count{
            strSectionSelectedIndex = strSectionSelectedIndex - 1
            strSelectedIndex = 0
        }
        Next_PreviousQue(str: "")
    }
    func Next_PreviousQue(str: String)
    {
        self.count_total_row = 0
        //        self.quecollectionView.reloadData()
        //        var strSelected = "0"
        //        for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        //        {
        //            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
        //            {
        //                strSelected = "1" //self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
        //            }
        //            i += 1
        //        }
        //        if strSelected == "1"
        //        {
        //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
        //        }
        //        else
        //        {
        //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
        //        }
        //        if self.arrQueAns.count <= self.strSectionSelectedIndex && self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count <= self.strSelectedIndex
        //        {
//        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited == ""
//        {
            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
//        }
        //        }
        self.queCollectionNewView.reloadData()
//        rowHeights.removeAll()
        reloadTableview()
        self.reloadView()
        //        self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
        //"\(self.strSelectedIndex + 1) /\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
        //        self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
        
        
        view.endEditing(true)
        popup_time_counter = 0
        
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        //            self.tblQuestion.reloadData()
        //    }
    }
    func reloadTableview()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            self.tblQuestion.reloadData()
            self.tblQuestion.scroll(to: .top, animated: false)//.setContentOffset(bottomOffset, animated: true)
        }
        
        //        UIView.transition(with: self.tblQuestion,
        //                          duration: 0.35,
        //                          options: .curveEaseInOut,
        //                          animations: {
        //                            self.tblQuestion.reloadData()
        //                            }) // left out the unnecessary syntax in the completion block and the optional completion parameter
    }
    func Report_Isue_Api(strSelection : String,strIssueDescription: String)
    {
        showActivityIndicator()
        self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
        self.reloadView()
        
        let que_id = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_id)"
        //        let TestQuestionID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].test_que_id)"
        //        let QuestionTypeID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type)"
        //        var result:[String:String] = [:]
        //        if ((UserDefaults.standard.value(forKey: "logindata")) != nil)
        //        {
        //            result = UserDefaults.standard.value(forKey: "logindata") as! [String : String] //as! NSMutableDictionary
        //        }
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary

        let params = ["IssueReportTypeID":strSelection,
                      "IssueReportTypeName":strIssueDescription,
                      "SourceFrom":"iOS",
                      "StudentID":"\(result["StudentID"] ?? "")",
            "StudentName":"\(result["StudentFirstName"] ?? "") \(result["StudentLastName"] ?? "")",
            "QuestionID":que_id,
            "IssueDiscription":""]
        //        let params = ["StudentTestID":strStudentTestID,"TestQuestionID":TestQuestionID,"QuestionID":que_id,"QuestionTypeID":QuestionTypeID, "Issue_type_id":strSelection]

        //        var params = calculation_send_Data()// ["StudentTestID":strStudentTestID,
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.Report_IssueApi,params)
        
        Alamofire.request(API.Report_IssueApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
////print("Report Issue: ",json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 2.0, position: .bottom)

                    //                            let arrData = json["data"].array
                    //                            var crct = ""
                    //                            var Incrct = ""
                    //                            var NotAnswer = ""
                    //                            var Total = ""
                    //
                    //                            for value in arrData! {
                    //
                    //                                crct = value["Correct"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                                Incrct = value["Wrong"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                                NotAnswer = value["UnAnswered"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                                Total = value["TotalMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                            }
                    //                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
                    //                            vc!.strCorrect = "\(crct)"
                    //                            vc!.strInCorrect = "\(Incrct)"
                    //                            vc!.strUnanswered = "\(NotAnswer)"
                    //                            vc!.strTotal = "\(Total)"
                    //                            vc!.strTestID = self.strTestID
                    //                            vc!.strStudentTestID = self.strStudentTestID
                    //                            vc!.strTitle = self.strTestTitle
                    //                            self.navigationController?.pushViewController(vc!, animated: true)
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
    func Que_wish_ans_Api()
    {
        if UIDevice.current.userInterfaceIdiom == .pad {
            //Bhargav Hide
////print("iPad")
            que_delay = 0.05
            ans_delay = 0.10

        }else{
            //Bhargav Hide
////print("not iPad")
            que_delay = 0.10
            ans_delay = 0.10

        }

        showActivityIndicator()
        //        //        let UDID: String = UIDevice.current.identifierForVendor!.uuidString
        //        //        var crct = 0
        //        //        var Incrct = 0
        //        //        var NotAnswer = 0
        //        var queid_with_ansid = ""
        //        //        for var i in (0..<arrQueAns.count)
        //        //        {
        //        let que_id = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_id)"
        //        var my_ans_id = ""
        //        var multi_ans_id = ""
        //        let true_ans = ""
        //        var str_true_false = ""
        //        let TestQuestionID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].test_que_id)"
        //        let QuestionTypeID = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type)"
        //        let str_per_que_time = "\(per_que_time)"
        //        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer == "" || self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer == "0"
        //        {per_que_time = 0} else { per_que_time = Int(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer) ?? 0} //Set Old Time
        //
        //        self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].total_timer = "\(per_que_time)"
        //        for var j in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        //        {
        //            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].selected == "1"
        //            {
        //                my_ans_id = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].id)"
        //                //                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[strSelectedIndex].selected == "1" && arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].isCorrectAnswer == "true"
        //                //                {
        //                //                    //                        crct = crct + 1
        //                //                    true_ans = "true"
        //                //                }else{
        //                //                    //                        Incrct = Incrct + 1
        //                //                    //                        my_ans_id = ""
        //                //                }
        //                multi_ans_id += "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[j].id),"
        //                if QuestionTypeID == "4"{str_true_false = "\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[j].name)"}
        //            }
        //            j += 1
        //        }
        //        var str_Send_Answer = ""
        //        if QuestionTypeID == "1"
        //        {
        //            str_Send_Answer = my_ans_id
        //        }
        //        else if QuestionTypeID == "2"
        //        {
        //            str_Send_Answer = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans)"
        //        }
        //        else if QuestionTypeID == "4"
        //        {
        //            if str_true_false == ""
        //            {
        //                str_Send_Answer = ""
        //            }
        //            else if str_true_false == "True"
        //            {
        //                str_Send_Answer = "1"
        //            }
        //            else if str_true_false == "False"
        //            {
        //                str_Send_Answer = "0"
        //            }
        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans
        //            //            str_Send_Answer = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans)"
        //        }
        //        else if QuestionTypeID == "7"
        //        {
        //            if multi_ans_id.count > 1{
        //                multi_ans_id.remove(at: multi_ans_id.index(before: multi_ans_id.endIndex))
        //                //                multi_ans_id.dropLast()                          // "Hello, Worl"
        //            }
        //            str_Send_Answer = multi_ans_id
        //        }
        //        //        if my_ans_id == ""
        //        //        {
        //        //            my_ans_id = ""
        //        //        }
        //        //Bhargav Hide
////print("\(que_id) : \(my_ans_id) - \(true_ans)")
        //
        //        queid_with_ansid = "\(queid_with_ansid)" + "\(que_id)|\(my_ans_id),"
        //        //            i += 1
        //        //        }
        //        //Bhargav Hide
////print("Test_ID: ",strTestID)
        //        //Bhargav Hide
////print("queid_with_ansid: ",queid_with_ansid)
        //        let params = ["StudentTestID":strStudentTestID,"TestQuestionID":TestQuestionID,"QuestionID":que_id,"QuestionTypeID":QuestionTypeID,"Answer":str_Send_Answer,"UseTime":str_per_que_time]
        //
        //        //        NotAnswer = arrQueAns.count - (crct + Incrct)
        //
        //        //        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //        //        //        //Bhargav Hide
////print(result)
        //        //        queid_with_ansid.remove(at: queid_with_ansid.index(before: queid_with_ansid.endIndex))    // "d"
        //        //
        let params = calculation_send_Data()// ["StudentTestID":strStudentTestID,
        //                      "QuestionIDAnswerID": queid_with_ansid]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.Insert_Test_AnswerApi,params)
        
        Alamofire.request(API.Insert_Test_AnswerApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
////print("SUBMIT ANS : ",json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    //                            let arrData = json["data"].array
                    //                            var crct = ""
                    //                            var Incrct = ""
                    //                            var NotAnswer = ""
                    //                            var Total = ""
                    //
                    //                            for value in arrData! {
                    //
                    //                                crct = value["Correct"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                                Incrct = value["Wrong"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                                NotAnswer = value["UnAnswered"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                                Total = value["TotalMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    //                            }
                    //                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
                    //                            vc!.strCorrect = "\(crct)"
                    //                            vc!.strInCorrect = "\(Incrct)"
                    //                            vc!.strUnanswered = "\(NotAnswer)"
                    //                            vc!.strTotal = "\(Total)"
                    //                            vc!.strTestID = self.strTestID
                    //                            vc!.strStudentTestID = self.strStudentTestID
                    //                            vc!.strTitle = self.strTestTitle
                    //                            self.navigationController?.pushViewController(vc!, animated: true)
                }
                else
                {
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }

        func Pre_Submit_Test_Api()
        {
            view.endEditing(true)
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2003", comment: "Submit Icon", isFirstTime: "0")
            self.viewSubmitPopup.isHidden = false
            showActivityIndicator()
            let params = ["StudentTestID":strStudentTestID]

            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            //Bhargav Hide
            print("API, Params: \n",API.Pre_Submit_TestApi,params)

            Alamofire.request(API.Pre_Submit_TestApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
                self.hideActivityIndicator()
                self.arrSubmitSummary.removeAll()
                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    //Bhargav Hide
                    print(json)
                    if(json["Status"] == "true" || json["Status"] == "1") {
                        let arrData = json["data"].array
                        for value in arrData! {

                                    let summaryModel:SubmitSummaryListModal = SubmitSummaryListModal.init(id: "\(value[""].stringValue)", title: "\(value["SectionName"].stringValue)", Attempted: "\(value["Answered"].stringValue)", NotAttempted: "\(value["UnAnswered"].stringValue)", SubjectName: "\(value["SubjectName"].stringValue)", TotalQue: "\(value["TotalQue"].stringValue)", ObtainMark:"")
                            self.arrSubmitSummary.append(summaryModel)
                        }
                        self.tblSubmit.reloadData()
                    }
                    else
                    {
                        self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
//                        self.runProdTimer()
                    }
                case .failure(let error):
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
//                    self.runProdTimer()
                }
            }
        }

    
    func Que_Ans_Submit_Api()
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2010", comment: "Submit Test Button", isFirstTime: "0")
        showActivityIndicator()
        //        //        let UDID: String = UIDevice.current.identifierForVendor!.uuidString
        //        //        var crct = 0
        //        //        var Incrct = 0
        //        //        var NotAnswer = 0
        //        var queid_with_ansid = ""
        //        for var i in (0..<arrQueAns.count)
        //        {
        //            let que_id = "\(arrQueAns[i].que_id)"
        //            var my_ans_id = ""
        //            var true_ans = ""
        //            for var j in (0..<arrQueAns[i].que_ans.count)
        //            {
        //                if arrQueAns[i].que_ans[j].selected == "1"
        //                {
        //                    my_ans_id = "\(arrQueAns[i].que_ans[j].id)"
        //
        //                    if arrQueAns[i].que_ans[j].selected == "1" && arrQueAns[i].que_ans[j].isCorrectAnswer == "true"
        //                    {
        //                        //                        crct = crct + 1
        //                        true_ans = "true"
        //                    }else{
        //                        //                        Incrct = Incrct + 1
        //                        //                        my_ans_id = ""
        //                    }
        //                }
        //                j += 1
        //            }
        //            if my_ans_id == ""
        //            {
        //                my_ans_id = "0"
        //            }
        //            //Bhargav Hide
////print("\(que_id) : \(my_ans_id) - \(true_ans)")
        //
        //            queid_with_ansid = "\(queid_with_ansid)" + "\(que_id)|\(my_ans_id),"
        //            i += 1
        //        }
        //        //Bhargav Hide
////print("Test_ID: ",strTestID)
        //        //Bhargav Hide
////print("queid_with_ansid: ",queid_with_ansid)
        //
        //        //        NotAnswer = arrQueAns.count - (crct + Incrct)
        //
        //        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //        //        //Bhargav Hide
////print(result)
        //        queid_with_ansid.remove(at: queid_with_ansid.index(before: queid_with_ansid.endIndex))    // "d"
        //
        //        //        let params = ["StudentTestID":strStudentTestID,
        //        //                      "QuestionIDAnswerID": queid_with_ansid]
        let params = ["StudentTestID":strStudentTestID]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
print("API, Params: \n",API.Submit_TestApi,params)//Add_StudentTestAnswerApi old
        
        Alamofire.request(API.Submit_TestApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    var crct = ""
                    var Incrct = ""
                    var NotAnswer = ""
                    var Total = ""
                    var TotalGetMarks = ""
                    for value in arrData! {
                        
                        crct = value["Correct"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        Incrct = value["Wrong"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        NotAnswer = value["UnAnswered"].stringValue //arrData.value(forKey: "TransactionID") as! String
                        Total = value["TotalMarks"].stringValue //arrData.value(forKey: "TransactionID") as! StringTotalGetMarks
                        TotalGetMarks = value["TotalGetMarks"].stringValue //arrData.value(forKey: "TransactionID") as! String
                    }
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
                    vc!.strCorrect = "\(crct)"
                    vc!.strInCorrect = "\(Incrct)"
                    vc!.strUnanswered = "\(NotAnswer)"
                    vc!.strTotal = "\(Total)"
                    vc!.strTotalGetMarks = "\(TotalGetMarks)"
                    vc!.strTestID = self.strTestID
                    vc!.strStudentTestID = self.strStudentTestID
                    vc!.strTitle = self.strTestTitle
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                    self.runProdTimer()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                self.runProdTimer()
            }
        }
    }
    
    func apiGet_Que_ListApi()
    {
        showActivityIndicator()
        //        self.arrQueAns.removeAll()
        //        let params = ["TokenId":"t1506-o2506-u3506-r4506"]//strCategoryID]
        let params = ["TestID":strTestID, "StudentTestID":strStudentTestID]//strCategoryID]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //        //Bhargav Hide
//print("API, Params: \n https://content.testcraft.co.in/mobileservice.asmx/GetRandomQuestions",params)
        //Bhargav Hide
print("API, Params: \n",API.Get_Student_TestQuestionNewApi,params)//Get_Student_TestQuestionApi
        
        Alamofire.request(API.Get_Student_TestQuestionNewApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                self.hideActivityIndicator()
            }
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1" || json["status"] == "1") {
                    let arrData = json["data"].array
                    var countTitle = 1
                    //                    var strDeleteQuestionTypeID = 3
                    for values in arrData! {
                        let arrTestQuestion = values["TestQuestion"].array
                        var arrTempQue = [Que_Ans_Model]()
                        
                        for value in arrTestQuestion! {
                            
                            var arrAnsModal = [Que_Ans_Model]()
                            let arrMCQ = value["StudentTestQuestionMCQ"].array
                            
                            var isVisited = ""
                             let tempVisited = "\(value["Answered"].stringValue)"
                            print(value["Answered"].stringValue,isVisited)
                            if tempVisited == ""
                            {
                                isVisited = ""
                            }else if tempVisited == "1"
                            {
                                isVisited = "1"
                            }
                            let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "\(value["QuestionID"].stringValue)", display_no: "--", name: "\(value["title"].stringValue)", type: "Q", img_link: "\(value["QuestionImage"].stringValue)", isCorrectAnswer: "\(value["IsCorrectAnswer"].stringValue)", selected: "0")
                            //Que Image
                            //                        let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "\(values["MultipleChoiceQuestionAnswerID"].stringValue)", name: "\(values["title"].stringValue)", type: "A", img_link: "\(values["AnswerImage"].stringValue)", selected: "0")

                            let strHintUsed : String = "\(value["HintUsed"].stringValue)"
                            if strHintUsed == "1"
                            {
                                //                                self.int_Used_Hint += 1
                            }
                            arrAnsModal.append(ansModel)
                            let strQuestionTypeID = "\(value["QuestionTypeID"].stringValue)"
                            //                        if arrMCQ != nil{
                            if strQuestionTypeID == "1" || strQuestionTypeID == "3" || strQuestionTypeID == "7"
                            {
                                for values in arrMCQ! {
                                    //                            let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "\(values["id"].stringValue)", name: "\(values["title"].stringValue)", type: "A", img_link: "\(values["titleimg"].stringValue)", selected: "0")
                                    var strIsUserSelected = "0"//"\(values["IsCorrectAnswer"].stringValue)"
                                    if values["IsUserSelected"].stringValue == "true"{
                                        strIsUserSelected = "1"
//                                        isVisited = "1"
                                    }
                                    let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "\(values["MultipleChoiceQuestionAnswerID"].stringValue)", display_no: "\(values["optiontext"].stringValue)", name: "\(values["title"].stringValue)", type: "A", img_link: "\(values["AnswerImage"].stringValue)", isCorrectAnswer: "\(values["IsCorrectAnswer"].stringValue)", selected: strIsUserSelected)
                                    arrAnsModal.append(ansModel)
                                }
                            }
                            //                        else
                            //                        {
                            if strQuestionTypeID == "2" || strQuestionTypeID == "8"{
                                var strAnswer = "0"//"\(value["Answer"].stringValue)"
                                if value["Answer"].stringValue != ""
                                {
                                    strAnswer = "1";
//                                    isVisited = "1"
                                }
                                let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "-", name: "", type: "A", img_link: "", isCorrectAnswer: "", selected: strAnswer)
                                arrAnsModal.append(ansModel)
                                self.allCellsText.append("")
                            }
                            if strQuestionTypeID == "4"{
                                var strTrueAnswer = "0"//"\(value["Answer"].stringValue)"
                                var strFalseAnswer = "0"//"\(value["Answer"].stringValue)"
                                if value["Answer"].stringValue == "1"
                                {
                                    strTrueAnswer = "1";
//                                    isVisited = "1"
                                }
                                else if value["Answer"].stringValue == "0"
                                {
                                    strFalseAnswer = "1";
//                                    isVisited = "1"
                                }
                                
                                let ansTrueModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "", name: "True", type: "A", img_link: "", isCorrectAnswer: "", selected: strTrueAnswer)
                                arrAnsModal.append(ansTrueModel)
                                let ansFalseModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "", name: "False", type: "A", img_link: "", isCorrectAnswer: "", selected: strFalseAnswer)
                                arrAnsModal.append(ansFalseModel)
                            }
                            //                        }
                            
                            //                        let queModel:Que_Ans_Model = Que_Ans_Model.init(title: "0", que_no: "\(countTitle)", que_id: "0", que_type: "radio", total_timer: "", current_time: "", report_issue: "0", mark_as_review: "0", que_ans: arrAnsModal)
                            //radio = 1, Multiselection(checkbox) = 2,
                            let queModel:Que_Ans_Model = Que_Ans_Model.init(title: "\(value["title"].stringValue)", que_no: "\(countTitle)", que_id: "\(value["QuestionID"].stringValue)", que_type: "\(value["QuestionTypeID"].stringValue)", total_timer: "", current_time: "", report_issue: "0", mark_as_review: "\(value["Review"].stringValue ?? "0")", isVisited: isVisited, isAnsTrue: "0", que_ans: arrAnsModal, test_que_id: "\(value["TestQuestionID"].stringValue)", str_marks:"\(value["Marks"].stringValue)", str_answered:"\(value["Answered"].stringValue)", str_ans:"\(value["Answer"].stringValue)", str_Hint: "\(value["Hint"].stringValue)", str_HintUsed: "\(value["HintUsed"].stringValue)", str_Explanation: "\(value["Explanation"].stringValue)", str_system_answer:"\(value["SystemAnswer"].stringValue)", str_your_answer:"\(value["YourAnswer"].stringValue)") // original final
                            //                         let queModel:Que_Ans_Model = Que_Ans_Model.init(title: "\(value["title"].stringValue)", que_no: "\(countTitle)", que_id: "\(value["QuestionID"].stringValue)", que_type: "\(strDeleteQuestionTypeID)", total_timer: "", current_time: "", report_issue: "0", mark_as_review: "0", isVisited: "0", isAnsTrue: "0", que_ans: arrAnsModal) // Temp for Testing
                            //                        if strDeleteQuestionTypeID == 3
                            //                        {
                            //                            strDeleteQuestionTypeID = 2
                            //                        }
                            //                        else if strDeleteQuestionTypeID == 2
                            //                        {
                            //                            strDeleteQuestionTypeID = 1
                            //                        }
                            
                            arrTempQue.append(queModel)
                            countTitle += 1
                        }
                        let sectionModel:Que_Ans_Model = Que_Ans_Model.init(section_id: "\(values["SectionID"].stringValue)", section_name: "\(values["SectionName"].stringValue)", section_type: "0", section_description: "\(values["SectionInstruction"].stringValue)", section_selected: "0", arr_section_que: arrTempQue)
                        //(title: "\(value["title"].stringValue)", que_no: "\(countTitle)", que_id: "\(value["QuestionID"].stringValue)", que_type: "\(value["QuestionTypeID"].stringValue)", total_timer: "", current_time: "", report_issue: "0", mark_as_review: "0", isVisited: isVisited, isAnsTrue: "0", que_ans: arrAnsModal, test_que_id: "\(value["TestQuestionID"].stringValue)", str_marks:"\(value["Marks"].stringValue)", str_answered:"\(value["Answered"].stringValue)", str_ans:"\(value["Answer"].stringValue)", str_Hint: "\(value["Hint"].stringValue)", str_Explanation: "\(value["Explanation"].stringValue)") // original final
                        
                        self.arrQueAns.append(sectionModel)
                        
                    }
                    if arrData!.count > 0
                    {
                        self.SetFistQue()
                    }
                    self.queCollectionNewView.reloadData()
                    //                    self.quecollectionView.reloadData()
                    
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                //Bhargav Hide
                print("error: ",error)
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                let alert = UIAlertController(title: "Please Try Again", message: "", preferredStyle: .alert)
                alert.setValue(UIImage(named: "risk_blue"), forKey: "image")

               // alert.setTitleImage(UIImage(named: "risk_blue"))
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
        }
    }
    func SetFistQue()
    {
        self.strSelectedIndex = 0
        self.strSectionSelectedIndex = 0
        self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"

        let temp_que_type =  arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type
        if temp_que_type == "1" || temp_que_type == "4"
        {
            //                            var i = 0
//            var oldvalue = 0//arrQueAns[strSelectedIndex].que_ans[indexPath.row].selected
//            for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
//            {
//                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
//                {
//                    oldvalue = i
//                }
//                i += 1
//            }
//            if oldvalue == 0
//            {
//                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
//            }
//            else
//            {
//                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
//                //                arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "1"
//                //                let indexPath1 = IndexPath(item: indexPath.row, section: 0)
//                //                tblQuestion.reloadRows(at: [indexPath1], with: .none)
//            }
            
            //  self.tblQuestion.layer.removeAllAnimations()
            //  tblQuestion.reloadData()
            //                Que_wish_ans_Api()
            
        }
        else if temp_que_type == "7"//strQueType == "2"
        {
//            var strSelected = "0"
//            for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
//            {
//                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
//                {
//                    strSelected = "1"
//                }
//                i += 1
//            }
//            if strSelected == "0"
//            {
//                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
//            }
//            else
//            {
//                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
//            }
        }
        else if temp_que_type == "2" || temp_que_type == "8"//strQueType == "2"
        {
            //            return
        }
        self.ShowAll()
        self.reloadView()
        //                        self.intProdSeconds = 600
        //                        self.intProdSeconds = self.intProdSeconds //* 60
        CelulerDisplay()

        self.SendContinueRequest = self.intProdSeconds - self.static_delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
            self.reloadTableview()
            if self.isTimerRunning == false {
                self.runProdTimer()
            }
            
        }
        //                        self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"

    }
    // MARK: Keyboard Notifications
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            self.tblQuestion.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardHeight / 2) + 65, right: 0)
            let numberOfSections = self.tblQuestion.numberOfSections
            let numberOfRows = self.tblQuestion.numberOfRows(inSection: numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
//                            self.tblQuestion.reloadData()
                //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                            self.tblQuestion.scroll(to: .bottom, animated: true)//.setContentOffset(bottomOffset, animated: true)
                //self.tblQuestion.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            //            self.tblQuestion.scrollToRowAtIndexPath(editingIndexPath, atScrollPosition: .Top, animated: true)
            //            self.tblQuestion.scrollIndicatorInsets = self.tblQuestion.contentInset

        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            self.tblQuestion.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
    }
}


extension Question1VC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @objc func popupSectionHeading(_ gesture:UIGestureRecognizer)
    {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2009", comment: "Secttion Instruction", isFirstTime: "0")

        let Index:Int = (gesture.view?.tag)!
        //        let url = arrQueAns[Index].section_name//section_description
        //            let htmlString = "<html><body style='background-color:clear;'><br><p><font size=18>" + "\(arrQueAns[Index].section_description)" + "</font></p></body></html>"
        //        let htmlString = "<html><body style='background-color:clear;'><br><p style='color:#000000; font-family:Inter-Regular'><font size=18>" + "\(arrQueAns[Index].section_description)" + "</font></p></body></html>"
        let strDesc = "\(arrQueAns[Index].section_description)"
        if strDesc == ""
        {

        }else{
        let htmlString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background-color:clear;'><div style='color:#000000; font-family:Inter-Regular; FONT-SIZE :14PX; LINE-HIGHT : 12PX; vertical-align: middle'>" + "\(arrQueAns[Index].section_description)" + "</div></body></html>"

        self.loadExpViewPopup(strUrl: htmlString, strTitle: "\(arrQueAns[Index].section_name)")
        }
        //        var alert = UIAlertController()
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            //Bhargav Hide
////print("iPad")
        //            alertWebview = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        //
        //        }else{
        //            //Bhargav Hide
////print("not iPad")
        //            alertWebview = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        //
        //        }
        //
        //        let cancel = UIAlertAction(title: "Close", style: UIAlertAction.Style.destructive, handler: nil)
        //        let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 18.0)!]
        //        let titleAttrString = NSMutableAttributedString(string: "\(arrQueAns[Index].section_name)", attributes: titleFont)
        //        alertWebview.setValue(titleAttrString, forKey: "attributedMessage")
        //
        //        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertWebview.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        //        //        let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height - 20)
        //        //        let x_axis:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.leftMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 10)
        //        ////        alert.view.addConstraint(x_axis);
        //        alertWebview.view.addConstraint(height);
        //        //        alert.view.addConstraint(width);
        //        alertWebview.view.frame.origin.y = 60
        //        //        alert.view.frame.size.height = self.view.frame.height * 0.90
        //        alertWebview.view.frame.size.height = self.view.frame.height * 0.90
        //        alertWebview.view.frame.size.width = self.view.frame.width - 20
        //        let web = UIWebView(frame: CGRect(x: 2, y: alertWebview.view.frame.origin.y + 10, width: alertWebview.view.frame.size.width, height: self.view.frame.size.height * 0.85 - 95)) // take note that right here, in the height:, I’ve changed 0.8 to 0.85 so it should look more consistent on the top and bottom
        //        let htmlString = "<html><body style='background-color:clear;'><br><p><font size=10>" + "Test Section.." + "</font></p></body></html>"//<br><p align=center><font size=30  align=center><b>" + "Explanation" + "</b></font></p><p><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
        //
        //        web.loadHTMLString(htmlString, baseURL: nil)
        //        //        web.backgroundColor = UIColor.lightGray
        //        //        web.scrollView.backgroundColor = UIColor.lightGray
        //        //        let requestURL = NSURL(string: "http://www.google.it");
        //        //        let request = NSURLRequest(url: requestURL! as URL);
        //        //        web.loadRequest(request as URLRequest);
        //        web.scalesPageToFit = true
        //        //        web.loadRequest(request as URLRequest)
        //        //        web.scrollView.bouncesZoom = false
        //        web.scrollView.bounces = false
        //        //        web.scrollView.
        //        //        let htmlString = "<p>Identify the arrow-marked structures in the images<img alt=\"\" src=\"https://dams-apps-production.s3.ap-south-1.amazonaws.com/course_file_meta/73857742.PNG\"></p>"
        //
        //        alertWebview.view.addSubview(web)
        //        alertWebview.addAction(cancel)
        //        self.present(alertWebview, animated: false, completion: nil)

    }
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let homeHeaderReuseIdentifier = "HeaderCollectionViewCell"
        let homeFooterReuseIdentifier = "HeaderCollectionViewCell"
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            let userHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeHeaderReuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
            userHeader.lblTitle.text = arrQueAns[indexPath.section].section_name//arrHeader[indexPath.section]
            userHeader.lblTitle.textColor = GetColor.darkGray
            //            userHeader.lblTitle.textColor = GetColor.blueHeaderText
            userHeader.bgView.backgroundColor = GetColor.SectionColor
            userHeader.imgDerctionIcon.image = UIImage(named: "info-icon.png")
            //            userHeader.btnSeeAll.tag = indexPath.section
            //            userHeader.btnSeeAll.addTarget(self,action:#selector(seeAllClicked(sender:)), for: .touchUpInside)
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(popupSectionHeading(_:)))
            userHeader.contentView.tag = indexPath.section
            userHeader.contentView.addGestureRecognizer(tapGesture)

            return userHeader
            
        case UICollectionView.elementKindSectionFooter:
            let userFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeFooterReuseIdentifier, for: indexPath) as! HomeCollectionViewCell
            return userFooter
        default:
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == queCollectionNewView {
            return arrQueAns.count//5
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if collectionView == queCollectionNewView {
            return CGSize(width:collectionView.frame.size.width, height:50)
        }
        else
        {
            return CGSize(width:collectionView.frame.size.width, height:0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == queCollectionNewView {
            if UIDevice.current.userInterfaceIdiom == .pad {
                //Bhargav Hide
////print("iPad")
                return CGSize(width: queCollectionNewView.frame.size.width/7, height: queCollectionNewView.frame.size.width/7);
            }else{
                //Bhargav Hide
////print("not iPad")
                return CGSize(width: queCollectionNewView.frame.size.width/5, height: queCollectionNewView.frame.size.width/5);
            }
        } else {
            return CGSize(width: quecollectionView.frame.size.width/5, height: 40);//quecollectionView.frame.size.height);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == queCollectionNewView {
            if (arrQueAns.count == 0) {
                self.queCollectionNewView.setEmptyMessage("")
            } else {
                self.queCollectionNewView.restore()
            }
            return arrQueAns[section].arr_section_que.count
        }
        else{
            if (arrQueAns.count == 0) {
                self.quecollectionView.setEmptyMessage("")
            } else {
                self.quecollectionView.restore()
            }
            return arrQueAns[section].arr_section_que.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == queCollectionNewView {
            let cell:QueAnsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QueAnsCollectionViewCell", for: indexPath) as! QueAnsCollectionViewCell
            //  cell.bgView.backgroundColor = GetColor.seaGreen
            //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
            //  cell.bgView.addShadowWithRadius(0,0,0)
            cell.displayData("Main",arrQueAns[indexPath.section].arr_section_que[indexPath.row].que_no)
            cell.lblLine.backgroundColor = UIColor(rgb: 0x000000)
            
            if strSelectedIndex == indexPath.row && strSectionSelectedIndex == indexPath.section{
                cell.lblLine.isHidden = false
                cell.lblTitle.textColor = GetColor.dotColorWhite
                cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
            }
            else if arrQueAns[indexPath.section].arr_section_que[indexPath.row].mark_as_review == "1"
            {
                cell.lblTitle.textColor = GetColor.dotColorWhite
                cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
                
            }
            else
            {
                var isAnswer = 0
                
                for var j in (0..<arrQueAns[indexPath.section].arr_section_que[indexPath.row].que_ans.count)
                {
                    if arrQueAns[indexPath.section].arr_section_que[indexPath.row].que_ans[j].selected == "1"
                    {
                        isAnswer = 1
                    }
                    j += 1
                }

                if isAnswer == 1
                {
                    cell.lblTitle.textColor = GetColor.dotColorWhite
                    cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)


                }
                else if arrQueAns[indexPath.section].arr_section_que[indexPath.row].isVisited == "1"
                {

                    cell.lblTitle.textColor = GetColor.dotColorWhite
                    cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
                }


                //                    cell.lblTitle.textColor = GetColor.dotColorGray
                //                    cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)
//               }
                else
                {
                    cell.lblTitle.textColor = GetColor.dotColorGray
                    cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)
                }
                cell.lblLine.isHidden = true
                
            }
            
            
            //            imgInfoPopupDotCurrent.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
            //            imgInfoPopupDotAnswerd.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)
            //            imgInfoPopupDotUnAnswered.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
            //            imgInfoPopupDotReviewLater.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
            //            imgInfoPopupDotNotVisited.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)
            
            cell.lblAlertDot.layer.cornerRadius = 2.0
            cell.lblAlertDot.clipsToBounds = true
            
            if arrQueAns[indexPath.section].arr_section_que[indexPath.row].mark_as_review == "1"
            {
                cell.lblAlertDot.isHidden = true//false
                cell.lblAlertDot.backgroundColor  = UIColor(rgb: 0x1295BD)//UIColor(rgb: 0xFFFFFF)
            }
            else
            {
                cell.lblAlertDot.isHidden = true
            }
            
            //            cell.imgIcon.sd_setShowActivityIndicatorView(true)
            //            cell.imgIcon.sd_setIndicatorStyle(.gray)
            //
            //            let url = URL.init(string: "".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
            //            //        let url = URL.init(string: "https://content.testcraft.co.in/question/" + (arrHeaderSub3Title[indexPath.row].image ?? "").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
            //            cell.imgIcon.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
            //                if error != nil {
            //                    //Bhargav Hide
////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
            //                    //                self.image = placeholder
            //                    //                cell.imgIcon.setImageForName(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
            //                        cell.imgIcon.setImageForName("", backgroundColor: UIColor.lightGray, circular: true, textAttributes: nil, gradient: false)//(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
            //                    //fetchedImage
            //                    return
            //                }
            //            }
            
            return cell
        }
        else
        {
            let cell:QueAnsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QueAnsCollectionViewCell", for: indexPath) as! QueAnsCollectionViewCell
            //  cell.bgView.backgroundColor = GetColor.seaGreen
            //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
            //  cell.bgView.addShadowWithRadius(0,0,0)
            cell.lblLine.backgroundColor = UIColor(rgb: 0x000000)
            
            if strSelectedIndex == indexPath.row {
                cell.lblLine.isHidden = false
                cell.lblTitle.textColor = UIColor(rgb: 0x1295BD)//UIColor(rgb: 0xFFFFFF)
                
            }
            else
            {
                cell.lblLine.isHidden = true
                cell.lblTitle.textColor = UIColor(rgb: 0x808080)
            }
            cell.lblAlertDot.layer.cornerRadius = 2.0
            cell.lblAlertDot.clipsToBounds = true
            
            if arrQueAns[indexPath.section].arr_section_que[indexPath.row].mark_as_review == "1"
            {
                cell.lblAlertDot.isHidden = false
                cell.lblAlertDot.backgroundColor  = UIColor(rgb: 0x1295BD)//UIColor(rgb: 0xFFFFFF)
            }
            else
            {
                cell.lblAlertDot.isHidden = true
            }
            
            cell.displayData("Main",arrQueAns[indexPath.section].arr_section_que[indexPath.row].que_no)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == queCollectionNewView {
            Que_wish_ans_Api()
            strSectionSelectedIndex = indexPath.section
            strSelectedIndex = indexPath.item
            //            self.count_total_row = 0

            let indexPath = NSIndexPath(row: indexPath.item, section: indexPath.section)
            queCollectionNewView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            //            queCollectionNewView.reloadData()
            //            rowHeights.removeAll()
            //            self.reloadView()
            //            self.reloadTableview()
            //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
            //            self.lblPage.text = "\(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"

            self.queView.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.10) {
                self.Next_PreviousQue(str: "")
            }
            //            self.hideRedViewAnimated(animated: false)
            //            view.endEditing(true)
            //            popup_time_counter = 0
        }
        else
        {
            Que_wish_ans_Api()
            strSectionSelectedIndex = indexPath.section
            strSelectedIndex = indexPath.item
            self.count_total_row = 0
            let indexPath = NSIndexPath(row: indexPath.item, section: 0)
            quecollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            quecollectionView.reloadData()
            rowHeights.removeAll()
            reloadView()
            self.reloadTableview()
            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
            //            self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
            view.endEditing(true)
        }
    }
    
    //    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    //        if quecollectionView == scrollView
    //        {var visibleRect = CGRect()
    //
    //            visibleRect.origin = quecollectionView.contentOffset
    //            visibleRect.size = quecollectionView.bounds.size
    //
    //            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    //
    //            guard let indexPath = quecollectionView.indexPathForItem(at: visiblePoint) else { return }
    //
    ////            if indexPath[1] > 2 || indexPath[1] < arrQueAns.count - 2{
    //                //Bhargav Hide
////print(indexPath)
    //                strSelectedIndex = indexPath.item
    //                let indexPath1 = NSIndexPath(row: indexPath.item, section: 0)
    //                quecollectionView.scrollToItem(at: indexPath1 as IndexPath, at: .centeredHorizontally, animated: true)
    //                quecollectionView.reloadData()
    //    self.reloadTableview()
    //                    self.lblPage.text = "\(self.strSelectedIndex + 1) /\(self.arrQueAns.count)"
    //
    ////            }
    //        }
    //    }
    //
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //       if quecollectionView == scrollView
    //       {
    //        var visibleRect = CGRect()
    //
    //        visibleRect.origin = quecollectionView.contentOffset
    //        visibleRect.size = quecollectionView.bounds.size
    //
    //        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    //
    //        guard let indexPath = quecollectionView.indexPathForItem(at: visiblePoint) else { return }
    //
    ////        if indexPath[1] > 2 || indexPath[1] < arrQueAns.count - 2{
    //            //Bhargav Hide
////print(indexPath)
    //            strSelectedIndex = indexPath.item
    //            let indexPath1 = NSIndexPath(row: indexPath.item, section: 0)
    //            quecollectionView.scrollToItem(at: indexPath1 as IndexPath, at: .centeredHorizontally, animated: true)
    //            quecollectionView.reloadData()
    //              reloadTableview()
    //            self.lblPage.text = "\(self.strSelectedIndex + 1) /\(self.arrQueAns.count)"
    //
    ////        }
    //        }
    //    }
    //
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //        let animation = CABasicAnimation(keyPath: "cornerRadius")
        //        animation.fromValue = cell.frame.size.width
        //        cell.layer.cornerRadius = 0
        //        animation.toValue = 0
        //        animation.duration = 1
        //        cell.layer.add(animation, forKey: animation.keyPath)
    }
    
}

extension Question1VC:UITableViewDataSource,UITableViewDelegate, UITextViewDelegate,UIScrollViewDelegate
{
    
    
    
    // MARK: - Table view data source
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    //    {
    //        let headerView:HeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
    //
    //        headerView.btnRead.tag = section
    //
    //        headerView.btnRead.addTarget(self, action: #selector(ReadAgainClicked), for: .touchUpInside)
    //
    //        //        //        headerView.headerHeight.constant = section == 0 ? 50 : 0
    //        //        //        headerView.lblView.superview?.addShadowWithRadius(2.0, 0, 0)
    //        //
    //        //        //        if section == selectedIndex {
    //        //        //            headerView.lblView.textColor = GetColor.green
    //        //        //        }else{
    //        //        //            headerView.lblView.textColor = .red
    //        //        //        }
    //        //        //        headerView.imgQueAns.setImageWithFadeFromURL(url: URL.init(string: "https://content.testcraft.co.in/question/" + (arrQueAns[section].QueImgLink).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!, placeholderImage: Constants.studentPlaceholder, animationDuration: 0.5, finish: {
    //        //        //            let aspectRatio = (headerView.imgQueAns.image! as UIImage).size.height/(headerView.imgQueAns.image! as UIImage).size.width
    //        //        //            //            cell.articleImage.image = image
    //        //        //            let imageHeight = self.view.frame.width*aspectRatio
    //        //        //            tableView.beginUpdates()
    //        //        //            self.rowHeaderHeights[section] = imageHeight
    //        //        //            tableView.endUpdates()
    //        //        //
    //        //        //        })
    //        //        //        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(expandCollapseSection(_:)))
    //        //        //        headerView.lblView.tag = section
    //        //        //        headerView.lblView.addGestureRecognizer(tapGesture)
    //        //        //        headerView.displayHeaderData(arrViewLessonPlanData[section])
    //        //        //        headerView.btnWord.addTarget(self, action: #selector(btnWordClikedAction(_:)), for: .touchUpInside)
    //
    //        return headerView//arrQueAns.count > 0 ? headerView.contentView : nil
    //    }
    //
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        if arrQueAns.count > 0
    //        {
    //            return 1//arrQueAns.count
    //        }
    //        else
    //        {
    //            return 0
    //        }
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        //        tableView.estimatedSectionHeaderHeight = 110
    //        //        return 50//UITableView.automaticDimension
    //        //        if let height = self.rowHeaderHeights[section]{
    //        //            return height
    //        //        }else{
    //        return 40
    //        //        }
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblSubmit{
            return self.arrSubmitSummary.count

               }else{
        if arrQueAns.count > 0
        {
            let temp_que_type = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_type
            if temp_que_type == "2" || temp_que_type == "8" //Fill in the blanks
            {
                return 2//arrQueAns[strSelectedIndex].que_ans.count
            }
            else
            {
                return arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count
            }
        }
        else
        {
            return 0
        }
        }
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        if let height = self.rowHeights[indexPath.row]{
        //            return height
        //        }
        if tableView == tblSubmit{
            return UITableView.automaticDimension
        }else{
        if arrQueAns.count > 0
        {
            let temp_que_type = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_type

            if temp_que_type == "2" || temp_que_type == "8"//Fill in the blanks
            {
                if let height = self.rowHeights[indexPath.row]
                {
                    if indexPath.row == 0 || indexPath.row == 1
                    {
                        return height
                    }
                    else
                    {
                        return 30
                    }
                }
                else
                {
                    return 30
                }
            }
            else
            {
                if let height = self.rowHeights[indexPath.row]
                {
                    return height
                }
                else
                {
                    return 30
                }
            }
        }
        else{
            return 0
        }
        //        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        tableView.layer.removeAllAnimations()
        //        UITableView.setAnimationsEnabled(false)
        if tableView == tblSubmit{
            let identifier = "SubmitSummaryTableViewCell"
            var cell: SubmitSummaryTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SubmitSummaryTableViewCell
            if cell == nil {
                tableView.register(UINib(nibName: "SubmitSummaryTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SubmitSummaryTableViewCell
            }
            cell.lbl_Title.text = "\(self.arrSubmitSummary[indexPath.row].title ?? "")"
            cell.lbl_Attempted.text = "\(self.arrSubmitSummary[indexPath.row].Attempted ?? "")"
            cell.lbl_NotAttempted.text = "\(self.arrSubmitSummary[indexPath.row].NotAttempted ?? "")"

            return cell
        }
        else
        {
            self.btnNext.isUserInteractionEnabled = false//
            if self.strSelectedIndex == self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count - 1{
                if(self.strSectionSelectedIndex == self.arrQueAns.count - 1)
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                        self.btnNext.isUserInteractionEnabled = true
                    }//
                    //            btnNext.isHidden = true
                    self.btnNext.setTitle("Submit Test", for: .normal)
                }
                else
                {
                    //            strSectionSelectedIndex += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                        self.btnNext.isUserInteractionEnabled = true
                    }//
                    self.btnNext.isHidden = false
                    //
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                    self.btnNext.isUserInteractionEnabled = true
                }//
                self.btnNext.isHidden = false
            }

            if indexPath.row == 0 {
                //            let cell:QuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
                let identifier = "QuestionTableViewCell"
                var cell: QuestionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionTableViewCell
                if cell == nil {
                    //                tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    //                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionTableViewCell
                }
                self.lblPage.text = "\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_no)/\(self.lblInfoPopupTotalQueSubTitle.text ?? "0")"
                UIView.performWithoutAnimation {
//                    cell.imgQueAns.sd_setShowActivityIndicatorView(true)
//                    cell.imgQueAns.sd_setIndicatorStyle(.white)
                    cell.imgQueAns.image = nil

                    //            cell.loadingPlaceholderView.cover(cell.contentView)

                    //                if strSelectedIndex > 0 {btnPrevious.isHidden = false}else{btnPrevious.isHidden = true}
                    //                if strSelectedIndex == arrQueAns.count - 1{
                    //                   btnNext.isHidden = true
                    //                }else{
                    //                    btnNext.isHidden = false
                    //                }
                    DispatchQueue.main.asyncAfter(deadline: .now() + que_delay) {
                        //Bhargav Hide
                        print("Que_____: " + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].id)
                        //Bhargav Hide
                        print(API.QueImg + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link)
                        let url = URL.init(string: API.QueImg + (self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

                        //                    cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground){ (fetchedImage, error, cacheType, url) in
                        cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
                            //                cell.loadingPlaceholderView.uncover()
                            if self.count_total_row != self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count
                                //                 if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count > 0
                            {

                                if error != nil {
                                    //Bhargav Hide
                                    print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                                    //                self.image = placeholder
                                    tableView.beginUpdates()
                                    self.rowHeights[indexPath.row] = 50
                                    tableView.endUpdates()
                                    self.view.makeToast("Error: Pull to refresh...", duration: 3.0, position: .bottom)

                                    //                            tableView.reloadRows(at: [indexPath], with: .none)
                                    self.count_total_row = self.count_total_row + 1
                                    return
                                }

                                let aspectRatio = (cell.imgQueAns.image! as UIImage).size.height/(cell.imgQueAns.image! as UIImage).size.width
                                cell.imgQueAns.image = fetchedImage
//                                let imageHeight = self.view.frame.width*aspectRatio
                                let imageHeight = self.tblQuestion.frame.width*aspectRatio

                                UIView.performWithoutAnimation {
                                    tableView.beginUpdates()
                                    self.rowHeights[indexPath.row] = imageHeight + 14
                                    tableView.endUpdates()
                                    //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                                    //                    tableView.reloadRows(at: [indexPath1], with: .fade)
                                    //                    //Bhargav Hide
                                    ////print(self.rowHeights)
                                    self.count_total_row = self.count_total_row + 1
                                }
                            }
                        }
                    }
                }
                print("que",self.rowHeights[indexPath.row] ?? 0.0)

                return cell
            }
            else
            {
                //            let cell:AnswerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
                let temp_que_type = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_type
                if temp_que_type == "2" || temp_que_type == "8"//Fill in the blanks
                {
                    let identifier = "TextFieldAnswerTableViewCell"
                    var cell: TextFieldAnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TextFieldAnswerTableViewCell
                    if cell == nil {
                        tableView.register(UINib(nibName: "TextFieldAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TextFieldAnswerTableViewCell
                    }
                    //                cell.isUserInteractionEnabled = false
//                    cell.txtWriteAns.delegate = self // theField is your IBOutlet UITextfield in your custom cell
                    //                cell.txtWriteAns.superview.tag = indexPath.row
                    cell.txtWriteAns.tag = indexPath.row
                    cell.txtWriteAns.text = ""
                    cell.txtWriteAns.delegate = self

                    self.addDoneButtonOnKeyboard(txt: cell!.txtWriteAns)
                    cell.txtWriteAns.addShadowWithRadius(2,2,1.1,color: GetColor.lightGray)
                    var strAnswear = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans)"
                    if strAnswear == ""{
                        strAnswear = " Enter your answer here..."
                        cell.txtWriteAns.textColor = UIColor.lightGray
                    }
                    else
                    {
                        cell.txtWriteAns.textColor = UIColor.darkGray
                    }
                    cell.txtWriteAns.text = strAnswear
                    if temp_que_type == "8"
                    {
                        //                    if #available(iOS 10.0, *) {
                        //                        cell.txtWriteAns.keyboardType = .asciiCapableNumberPad
                        //                    } else {
                        //                        // Fallback on earlier versions
                        cell.txtWriteAns.keyboardType = .numbersAndPunctuation
                        //                    }
                    }
                    else
                    {
                        cell.txtWriteAns.keyboardType = .default
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + ans_delay) {
                        UIView.performWithoutAnimation {
                        tableView.beginUpdates()
                        if temp_que_type == "8"
                        {
                            self.rowHeights[indexPath.row] = 50
                        }
                        else
                        {
                            self.rowHeights[indexPath.row] = 150
                        }

                        tableView.endUpdates()
                        }}
                    print("ans",self.rowHeights[indexPath.row] ?? 0.0)
                    return cell
                }
                else if temp_que_type == "4"
                {
                    let identifier = "AnswerTableViewCell"
                    var cell: AnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                    if cell == nil {
                        //                    tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                        //                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                    }

                    cell.lblDisplayNo.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].display_no
                    cell.imgQueAns.image = nil
                    cell.imgSelected.image = nil
                    cell.imgSelected.backgroundColor = UIColor.clear
                    cell.imgSelected.addShadowWithRadius(0,0,1.1,color: UIColor.white)
                    cell.lblView.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].name
                    DispatchQueue.main.asyncAfter(deadline: .now() + ans_delay) {
                        UIView.performWithoutAnimation {
                            tableView.beginUpdates()
                            self.rowHeights[indexPath.row] = 50

                            if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].selected == "1"
                            {
                                let imageName = "checked.png"
                                cell.bgView.isHidden = true
                                cell.imgSelected.image = UIImage(named: imageName)
                            }
                            else
                            {
                                let imageName = "unchecked.png"
                                cell.bgView.isHidden = true
                                cell.imgSelected.image = UIImage(named: imageName)
                            }
                            tableView.endUpdates()
                        }
                    }
                    print("ans",self.rowHeights[indexPath.row] ?? 0.0)
                    return cell
                }
                else
                {
                    let identifier = "AnswerTableViewCell"
                    var cell: AnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                    if cell == nil {
                        tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                    }
                    UIView.performWithoutAnimation {
                        cell.lblDisplayNo.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].display_no

//                        cell.imgQueAns.sd_setShowActivityIndicatorView(true)
//                        cell.imgQueAns.sd_setIndicatorStyle(.white)
                        cell.lblView.text = ""
                        //            if ((self.rowHeights[indexPath.row]) != nil)
                        //            {
                        //
                        //            }else{
                        cell.imgQueAns.image = nil
                        cell.imgSelected.image = nil
                        cell.imgSelected.backgroundColor = UIColor.clear
                        cell.imgSelected.addShadowWithRadius(0,0,1.1,color: UIColor.white)
                        cell.lblDisplayNo.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].display_no
                        DispatchQueue.main.asyncAfter(deadline: .now() + ans_delay) {
                            //Bhargav Hide
                            print("Ans_____: " + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].id)
                            //Bhargav Hide
                            print(API.QueImg + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link)
                            let url = URL.init(string: API.QueImg + (self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                            cell.imgQueAns.image = nil
                            //                        cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground){ (fetchedImage, error, cacheType, url) in
                            cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
                                if error != nil {
                                    //Bhargav Hide
                                    ////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                                    //                self.image = placeholder
                                    //Bhargav Hide
                                    ////print("error_______________________________________________________________\n",error)
                                    tableView.beginUpdates()
                                    self.rowHeights[indexPath.row] = 50
                                    tableView.endUpdates()
                                    self.view.makeToast("Error: Pull to refresh...", duration: 3.0, position: .bottom)
                                    self.count_total_row = self.count_total_row + 1

                                    return
                                }
                                if self.count_total_row != self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count
                                {
                                    let aspectRatio = (cell.imgQueAns.image! as UIImage).size.height/(cell.imgQueAns.image! as UIImage).size.width
                                    cell.imgQueAns.image = fetchedImage
//                                    let imageHeight = self.view.frame.width*aspectRatio
                                    let imageHeight = self.tblQuestion.frame.width*aspectRatio
                                    UIView.performWithoutAnimation {
                                        tableView.beginUpdates()
                                        self.rowHeights[indexPath.row] = imageHeight + 14
                                        tableView.endUpdates()
                                        //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                                        //                    tableView.reloadRows(at: [indexPath1], with: .fade)
                                        self.count_total_row = self.count_total_row + 1

                                    }
                                }
                                //Bhargav Hide
                                ////print(self.rowHeights)
                            }
                            //            }
                            cell.imgQueAns.addShadowWithRadius(0,15.0,0,color: UIColor.clear)
                            cell.bgView.addShadowWithRadius(13,5.0,1,color: UIColor.black)
                            if temp_que_type == "1" //single selection
                            {
                                cell.imgSelected.tintColor = GetColor.whiteColor
                                //                                cell.imgSelected.image = nil//image//UIImageView(image: <#T##UIImage?#>)
                                cell.imgSelected.backgroundColor = GetColor.whiteColor
                                cell.imgSelected.addShadowWithRadius(0,0,1.1,color: GetColor.whiteColor)

                                if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].selected == "1"
                                {
                                    let imageName = "checked.png"
                                    cell.bgView.isHidden = true
                                    cell.imgSelected.image = UIImage(named: imageName)
                                }
                                else
                                {
                                    let imageName = "unchecked.png"
                                    cell.bgView.isHidden = true
                                    cell.imgSelected.image = UIImage(named: imageName)
                                }
                            }
                            else //Multipul selection
                            {
                                if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].selected == "1"
                                    //                            if tempSelected == "1"
                                {
                                    let image : UIImage = UIImage(named:"true-sign-icon-white_NEW")!
                                    cell.imgSelected.image = image
                                    cell.imgSelected.backgroundColor = GetColor.themeBlueColor
                                    cell.imgSelected.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
                                    cell.bgView.isHidden = true

                                }
                                else
                                {
                                    //                                let image : UIImage = UIImage(named:"true-sign-icon-black")!
                                    cell.imgSelected.tintColor = UIColor.lightGray
                                    cell.imgSelected.image = nil//image//UIImageView(image: <#T##UIImage?#>)
                                    cell.imgSelected.backgroundColor = UIColor.white
                                    cell.imgSelected.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
                                    cell.bgView.isHidden = true
                                }

                                //                            {
                                //                                let imageName = "checked.png"
                                //                                cell.bgView.isHidden = true
                                //                                cell.imgSelected.image = UIImage(named: imageName)
                                //                                //  cell.bgView.backgroundColor = GetColor.seaGreen
                                //                                //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
                                //                            }
                                //                            else
                                //                            {
                                //                                let imageName = "unchecked.png"
                                //                                cell.bgView.isHidden = true
                                //                                cell.imgSelected.image = UIImage(named: imageName)
                                //                            }

                            }
                            //  cell.bgView.backgroundColor = GetColor.seaGreen
                            //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
                        }
                    }
                    print("ans",self.rowHeights[indexPath.row] ?? 0.0)

                    return cell
                }
            }


            //        cell.displayData(arrViewLessonPlanData[indexPath.section])
            //        rbgA

            //        //Bhargav Hide
            ////print("bhargav_profil_url_name_______",API.hostName,arrQueAns[indexPath.section].AnsImgLink as Any)
            //        cell.imgQueAns.setImageWithFadeFromURL(url: URL.init(string: "https://content.testcraft.co.in/question/" + (arrQueAns[strSelectedIndex].AnsDetail[indexPath.row].AnsImgLink).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!, placeholderImage: Constants.studentPlaceholder, animationDuration: 0, finish: {
            //            let aspectRatio = (cell.imgQueAns.image! as UIImage).size.height/(cell.imgQueAns.image! as UIImage).size.width
            ////            cell.articleImage.image = image
            //            let imageHeight = self.view.frame.width*aspectRatio
            //            tableView.beginUpdates()
            //            self.rowHeights[indexPath.row] = imageHeight
            //            tableView.endUpdates()
            //
            //        })
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblSubmit{

               }else{
        if UIDevice.current.userInterfaceIdiom == .pad {
            //Bhargav Hide
////print("iPad")
            que_delay = 0.05
            ans_delay = 0.10

        }else{
            //Bhargav Hide
////print("not iPad")
            que_delay = 0.10
            ans_delay = 0.00

        }

        //        UIView.performWithoutAnimation {
        //            tblQuestion.beginUpdates()
        UIView.setAnimationsEnabled(false)
        self.tblQuestion.beginUpdates()
        if indexPath.row == 0 {
        }
        else
        {
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2006", comment: "Select Option", isFirstTime: "0")

            //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
            let temp_que_type =  arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type
            if temp_que_type == "1" || temp_que_type == "4"
            {
                //                            var i = 0
                var oldvalue = 0//arrQueAns[strSelectedIndex].que_ans[indexPath.row].selected
                for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
                {
                    if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
                    {
                        arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected = "0"
                        let indexPath1 = IndexPath(item: i, section: 0)
                        tblQuestion.reloadRows(at: [indexPath1], with: .none)
                        oldvalue = i
                    }
                    i += 1
                }
                //                            tblQuestion.reloadData()
                if oldvalue == indexPath.row//oldvalue == "1" && arrQueAns[strSelectedIndex].que_ans[indexPath.row].selected == "1" //arrQueAns[strSelectedIndex].que_ans[indexPath.row + 1].selected == "1"
                {
                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "0"
//                    self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
                    
                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
                }
                else
                {
                    self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "1"
                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
                }
                
                //  self.tblQuestion.layer.removeAllAnimations()
                //  tblQuestion.reloadData()
                //                Que_wish_ans_Api()
                
            }
            else if temp_que_type == "7"//strQueType == "2"
            {
                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected == "1"
                {
                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "0"
                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
                }
                else
                {
                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "1"
                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
                }
                //                Que_wish_ans_Api()
                var strSelected = "0"
                for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
                {
                    if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
                    {
                        strSelected = "1"
                    }
                    i += 1
                }
                if strSelected == "1"
                {
                    self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
                }
                else
                {
//                    self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
                }
            }
            else if temp_que_type == "8"//strQueType == "2"
            {
                return
            }
            
        }
        //  tblQuestion.endUpdates()
        //  }
//        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited == ""
//        {
//            btnNext.setTitle("Skip", for: .normal)
//
//        }
//        else
//        {
//            btnNext.setTitle("Next", for: .normal)
//        }
            self.reloadView() // 6 jan

            self.tblQuestion.endUpdates()
        }
    }
    
    //    func textField(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //        let aSet = NSCharacterSet(charactersIn:"0123456789-.").inverted
    //        let compSepByCharInSet = string.components(separatedBy: aSet)
    //        let numberFiltered = compSepByCharInSet.joined(separator: "")
    //        return string == numberFiltered
    //    }
    //    func textview

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789-.").inverted
        let compSepByCharInSet = text.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        //
        //
        //        return text == numberFiltered
        
        //        guard let oldText = textView.text, let r = Range(range, in: oldText) else {
        //            return true
        //        }
        //
        // Grab the last three characters
//        if str.suffix(3) == "Dev" {
//            print("I found \(str.suffix(3))") // I found Dev
//        }

        var newText = textView.text ?? ""//oldText.replacingCharacters(in: r, with: text)
        //        let isNumeric = newText.isEmpty || (Double(newText) != nil)
//        if newText == "."
//               {
//                newText = ""
//                   return text == ""
//               }
//
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        //
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            print("dotIndex___",dotIndex)
        } else {
            numberOfDecimalDigits = 0
            print("numberOfDecimalDigits___",numberOfDecimalDigits)

        }
//        let dotsCount = textView.text!.componentsSeparatedByString(".").count - 1
        if numberOfDots > 0 && (text == ".") {
            return false
        }

//        if string == "," {
//            textField.text! += "."
//            return false
//        }
        if newText.count == 9
        {
            return text == ""
        }else
        {
            if newText.count == 1 {
                if newText == "." {
                    return text == ""//text == numberFiltered
                }
            }
            if numberOfDots <= 1 && numberOfDecimalDigits < 9
            {
                return text == numberFiltered
            }
            else if numberOfDecimalDigits == 0
            {
                return text == numberFiltered
            }
            else
            {
                return text == ""//text == numberFiltered
            }
            //text == numberFiltered
        }

        return true



//        if newText.count == 9
//        {
//            return text == ""
//        }else
//        {
//
//            if numberOfDots <= 1 && numberOfDecimalDigits < 9
//            {
//                return text == numberFiltered
//            }
//            else if numberOfDecimalDigits == 0
//            {
//                return text == numberFiltered
//            }
//            else
//            {
//                return text == ""//text == numberFiltered
//            }
//            //text == numberFiltered
//        }
        //Bhargav Hide
////print()
        //
        //        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
        //

        
        //        let nonNumberSet = CharacterSet(charactersIn: "0123456789.").inverted
        //        var dotLocation = Int()
        //
        //        if Int(range.length) == 0 && text.count == 0 {
        //            return true
        //        }
        //
        //        if (text == ".") {
        //            if Int(range.location) == 0 {
        //                return false
        //            }
        //            if dotLocation == 0 {
        //                dotLocation = range.location
        //                return true
        //            } else {
        //                return false
        //            }
        //        }
        //
        //        if range.location == dotLocation && text.count == 0 {
        //            dotLocation = 0
        //        }
        //
        //        if dotLocation > 0 && range.location > dotLocation + 2 {
        //            return false
        //        }
        //
        //        if range.location >= 10 {
        //
        //            if dotLocation >= 10 || text.count == 0 {
        //                return true
        //            } else if range.location > dotLocation + 2 {
        //                return false
        //            }
        //
        //            var newValue = (textView.text as NSString?)?.replacingCharacters(in: range, with: text)
        //            newValue = newValue?.components(separatedBy: nonNumberSet).joined(separator: "")
        //            textView.text = newValue
        //
        //            return false
        //
        //        } else {
        //            return true
        //        }
        //
        ////    }

    }
    //    func character
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "."{
            textView.text = " Enter your answer here..."
            textView.textColor = UIColor.lightGray
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans = ""
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[1].selected = "0"
//            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
        }
        else
        {
            var str = "\(textView.text ?? "")"
            let lastChar = str.last!   // lastChar is "😍"
            if lastChar == "."{
//                print(str.removeLast()) //prints out "g"
                str.removeLast()
                textView.text = str
                arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans = textView.text
            }

        }
        //        else
        //        {
        //            allCellsText.append(textView.text ?? "")
        //            //Bhargav Hide
////print(allCellsText)
        //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans = textView.text
        //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[1].selected = "1"
        //            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
        //            Que_wish_ans_Api()
        //        }
        //        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited == "1"
        //        {
        //            btnNext.setTitle("Next", for: .normal)
        //        }
        //        else
        //        {
        //            btnNext.setTitle("Skip", for: .normal)
        //        }
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2006", comment: "Select Option", isFirstTime: "0")
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.darkGray
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        //Bhargav Hide
////print(textView.text ?? "")
        if textView.text.isEmpty {
            textView.text = ""
            //            textView.textColor = UIColor.lightGray
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans = ""
//            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = ""
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[1].selected = "0"
        }
        else
        {
            //            let aSet = NSCharacterSet(charactersIn:"0123456789-.").inverted
            //            let compSepByCharInSet = string.components(separatedBy: aSet)
            //            let numberFiltered = compSepByCharInSet.joined(separator: "")
            //            let string_temp = numberFiltered

            if allCellsText.count >= strSelectedIndex
            {
                allCellsText[strSelectedIndex] = "\(textView.text ?? "")"
                //            allCellsText.append(textView.text ?? "")
            }
            //Bhargav Hide
////print(allCellsText)
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans = textView.text
            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[1].selected = "1"
            self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited = "1"
            //            Que_wish_ans_Api()
        }
        self.reloadView() // 6 jan

//        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited == ""
//        {
//            btnNext.setTitle("Skip", for: .normal)
//
//        }
//        else
//        {
//            btnNext.setTitle("Next", for: .normal)
//        }
        //        tblQuestion.reloadData()
        //        if strSelectedIndex == arrQueAns[self.strSectionSelectedIndex].arr_section_que.count - 1{
        //            if(strSectionSelectedIndex == arrQueAns.count - 1)
        //            {
        //                btnNext.isUserInteractionEnabled = true//
        //                //            btnNext.isHidden = true
        //                btnNext.setTitle("Submit Test", for: .normal)
        //            }
        //            else
        //            {
        //                //            strSectionSelectedIndex += 1
        //                btnNext.isUserInteractionEnabled = true//
        //                btnNext.isHidden = false
        //                //
        //            }
        //
        //        }else{
        //            btnNext.isUserInteractionEnabled = true//
        //            btnNext.isHidden = false
        //        }

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tblQuestion{
                let currentY = scrollView.contentOffset.y
        //        let currentBottomY = scrollView.frame.size.height + currentY
                print("currentY",currentY)
        if currentY < 5 {
            //"scrolling down"
//            if currentY == 0.0
//            {
//                tblQuestion.bounces = false
//            }
//            else
//            {
                tblQuestion.bounces = true
//            }
        } else {
            //"scrolling up"
//             Check that we are not in bottom bounce
//            if currentBottomY < scrollView.contentSize.height + scrollView.contentInset.bottom {
                tblQuestion.bounces = false
//            }
        }
        }
//        lastContentOffset = scrollView.contentOffset.y
    }

    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        if textView.text.isEmpty {
    //            textView.text = " Enter your answer here..."
    //            textView.textColor = UIColor.lightGray
    //        }
    //    }
    
    //    @objc func keyboardWillShow(notification: NSNotification)
    //    {
    //        var userInfo = notification.userInfo!
    //        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    //        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    //
    //        var contentInset:UIEdgeInsets = self.scrlView.contentInset
    //        contentInset.bottom = keyboardFrame.size.height + 30
    //        scrlView.contentInset = contentInset
    //
    //    }
    //
    //    @objc func keyboardWillHide(notification: NSNotification)
    //    {
    //        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
    //        scrlView.contentInset = contentInset
    //
    //    }
    func addDoneButtonOnKeyboard(txt:UITextView){
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
//        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isVisited == ""
//        {
//            btnNext.setTitle("Skip", for: .normal)
//
//        }
//        else
//        {
//            btnNext.setTitle("Next", for: .normal)
//        }
        view.endEditing(true)

        self.reloadView() // 6 jan

        if strSelectedIndex == arrQueAns[self.strSectionSelectedIndex].arr_section_que.count - 1{
            if(strSectionSelectedIndex == arrQueAns.count - 1)
            {
                btnNext.setTitle("Submit Test", for: .normal)
            }
            else
            {
                btnNext.isHidden = false
            }
            
        }else{
            btnNext.isHidden = false
        }
        Que_wish_ans_Api()

        //        self.count_total_row = 0
        //        self.quecollectionView.reloadData()
        //        let indexPath = NSIndexPath(row: strSelectedIndex, section: 0)
        //        quecollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        //        rowHeights.removeAll()
        //        self.reloadView()
        //        self.reloadTableview()
        //        self.lblPage.text = "\(self.strSelectedIndex + 1) /\(self.arrQueAns.count)"
        //        Next_PreviousQue(str: "")

//        view.endEditing(true)
    }
    
    
    //    @objc func expandCollapseSection(_ gesture:UIGestureRecognizer)
    //    {
    //        let Index:Int = (gesture.view?.tag)!
    //        if(selectedIndex == Index) {
    //            selectedIndex = -1
    //        }
    //        else {
    //            selectedIndex = Index
    //        }
    //
    //        tblQuestion.reloadData()
    //        self.tblQuestion.scrollToRow(at: NSIndexPath.init(row: 0, section: Index) as IndexPath, at: .top, animaīed: true)
    //    }
}

import CoreTelephony

enum RadioAccessTechnology: String {
    case cdma = "CTRadioAccessTechnologyCDMA1x"
    case edge = "CTRadioAccessTechnologyEdge"
    case gprs = "CTRadioAccessTechnologyGPRS"
    case hrpd = "CTRadioAccessTechnologyeHRPD"
    case hsdpa = "CTRadioAccessTechnologyHSDPA"
    case hsupa = "CTRadioAccessTechnologyHSUPA"
    case lte = "CTRadioAccessTechnologyLTE"
    case rev0 = "CTRadioAccessTechnologyCDMAEVDORev0"
    case revA = "CTRadioAccessTechnologyCDMAEVDORevA"
    case revB = "CTRadioAccessTechnologyCDMAEVDORevB"
    case wcdma = "CTRadioAccessTechnologyWCDMA"

    var description: String {
        switch self {
        case .gprs, .edge, .cdma:
            return "2G"
        case .lte:
            return "4G"
        default:
            return "3G"
        }
    }
}
extension Question1VC
{
    func CheckNetworkConnection()
    {
        print("strStatus...........................................",NetworkManager.shared.strStatus)
//        if strSelectedNetwork == NetworkManager.shared.strStatus
//        {}
//        else
//        {
            CelulerDisplay()
//        }
        if strSelectedNetwork == "notReachable"
        {
            timer.invalidate()
            let alert = UIAlertController(title: "Alert", message: "The network is not reachable..", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                //                self.navigationController?.popViewController(animated: false)
                self.backVC()
            }))
            self.present(alert, animated: true, completion: nil)

        }else {}

    }
    func CelulerDisplay()
    {
        strSelectedNetwork = NetworkManager.shared.strStatus
        if strSelectedNetwork == "wwan"{
            let networkInfo = CTTelephonyNetworkInfo()
            let networkString = networkInfo.currentRadioAccessTechnology ?? ""
            let tecnology = RadioAccessTechnology(rawValue: networkString)
            print("strStatus...........................................",tecnology?.description ?? "")
            print(tecnology?.description ?? "")
            if tecnology?.description == strcellulerNetwork//strSelectedNetwork == NetworkManager.shared.strStatus
            {}
            else
            {
                if tecnology?.description == "2G"
                {
                    strcellulerNetwork = "2G"
                    //                    timer.invalidate()
                    //                    let alert = UIAlertController(title: "Alert", message: "the internet connection is very poor.. are you sure continue to test??", preferredStyle: .alert)
                    //                    alert.addAction(UIAlertAction(title: "Back", style: .default, handler: { action in
                    //                        self.backVC()
                    //                    }))
                    //                    alert.addAction(UIAlertAction(title: "continue", style: .default, handler: { action in
                    //                        self.runProdTimer()
                    //                    }))
                    //                    self.present(alert, animated: true, completion: nil)
                    self.view.makeToast("The internet connection is very poor..", duration: 3.0, position: .bottom)
                }
                else if tecnology?.description == "3G"
                {
                    strcellulerNetwork = "3G"
//                    timer.invalidate()
                    //                    let alert = UIAlertController(title: "Alert", message: "the internet connection is slow.. are you sure continue to test??", preferredStyle: .alert)
                    //                    alert.addAction(UIAlertAction(title: "Back", style: .default, handler: { action in
                    //                        self.backVC()
                    //                    }))
                    //                    alert.addAction(UIAlertAction(title: "continue", style: .default, handler: { action in
                    //                        self.runProdTimer()
                    //                    }))
                    //                    self.present(alert, animated: true, completion: nil)
                    self.view.makeToast("The internet connection is slow.. ", duration: 3.0, position: .bottom)
                }
                else if tecnology?.description == "4G"
                {
                    strcellulerNetwork = "4G"

                }else
                {
                    strcellulerNetwork = ""

                }
            }
        }
    }
    func backVC()
    {
        for controller in self.navigationController!.viewControllers as Array {
            //Bhargav Hide
            ////print(controller)
            if controller.isKind(of: TestListVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
//            else if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
//                //                            self
//                controller.tabBarController!.selectedIndex = 0
//                //                                controller.tabBarController?.tabBarItem
//                self.navigationController!.popToViewController(controller, animated: false)
//                break
//            }

//                if controller.isKind(of: TestListVC.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
        }

    }
}
//    @objc func statusManager(_ notification: Notification) {
//        updateUserInterface()
//        print(notification)
//    }
//    @objc func reachabilityChanged(note: Notification) {
//
//      let reachability = note.object as! Reachability
//
//      switch reachability.connection {
//      case .wifi:
//          print("Reachable via WiFi")
//      case .cellular:
//          print("Reachable via Cellular")
//        let networkInfo = CTTelephonyNetworkInfo()
//        let networkString = networkInfo.currentRadioAccessTechnology ?? ""
//        let tecnology = RadioAccessTechnology(rawValue: networkString)
//
//        print(tecnology?.description ?? "")
//
//
//      case .unavailable:
//        print("Network not reachable")
//      case .none:
//        print("No any Network avilable")
//        }
//
//    }
//
//
//func updateUserInterface(){
////    do{
////        static //let shared = NetworkManager()
////var
//
//        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
//        reachabilityManager?.listener = { status in
//            switch status {
//
//                case .notReachable:
//                    print("The network is not reachable")
//                case .unknown :
//                    print("It is unknown whether the network is reachable")
//
//                case .reachable(.ethernetOrWiFi):
//                    print("The network is reachable over the WiFi connection")
//
//                case .reachable(.wwan):
//                    print("The network is reachable over the WWAN connection")
//                let networkInfo = CTTelephonyNetworkInfo()
//                let networkString = networkInfo.currentRadioAccessTechnology ?? ""
//                let tecnology = RadioAccessTechnology(rawValue: networkString)
//
//                print(tecnology?.description ?? "")
//
//
//                }
//            }
//    reachabilityManager?.startListening()
//
//
////        let reachability:Reachability = try Reachability.NetworkReachable.Type//reachabilityForInternetConnection()
////        do{
////            try reachability.startNotifier()
////            let status = reachability.//currentReachabilityStatus
////            if(status == .NotReachable){
////                return ""
////            }else if (status == .ReachableViaWiFi){
////                return "Wifi"
////            }else if (status == .ReachableViaWWAN){
////                let networkInfo = CTTelephonyNetworkInfo()
////                let carrierType = networkInfo.currentRadioAccessTechnology
////                switch carrierType{
////                case CTRadioAccessTechnologyGPRS?,CTRadioAccessTechnologyEdge?,CTRadioAccessTechnologyCDMA1x?: return "2G"
////                case CTRadioAccessTechnologyWCDMA?,CTRadioAccessTechnologyHSDPA?,CTRadioAccessTechnologyHSUPA?,CTRadioAccessTechnologyCDMAEVDORev0?,CTRadioAccessTechnologyCDMAEVDORevA?,CTRadioAccessTechnologyCDMAEVDORevB?,CTRadioAccessTechnologyeHRPD?: return "3G"
////                case CTRadioAccessTechnologyLTE?: return "4G"
////                default: return ""
////                }
////
////
////            }else{
////                return ""
////            }
////        }catch{
////            return ""
////        }
////
////    }catch{
////        return ""
////    }
//
//
//}
//}
//class NetworkManager {
//
////shared instance
//static let shared = NetworkManager()
//
//let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
//    var window: UIWindow?
//
//func startNetworkReachabilityObserver() {
//
//    reachabilityManager?.listener = { status in
//        switch status {
//
//            case .notReachable:
//                print("The network is not reachable")
//            let alert = UIAlertController(title: "Alert", message: "The network is not reachable", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                  switch action.style{
//                  case .default:
//                        print("default")
//
//                  case .cancel:
//                        print("cancel")
//
//                  case .destructive:
//                        print("destructive")
//
////                  @unknown default:
////                                            print("destructive")
//                }}))
////                self.navigationController.present(alert, animated: true, completion: nil)
//                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//
//            case .unknown :
//                print("It is unknown whether the network is reachable")
//
//            case .reachable(.ethernetOrWiFi):
//                print("The network is reachable over the WiFi connection")
//
//            case .reachable(.wwan):
//                print("The network is reachable over the WWAN connection")
//
//            }
//        }
//
//        // start listening
//        reachabilityManager?.startListening()
//   }
//
//}
