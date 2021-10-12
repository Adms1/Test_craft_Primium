//
//  SolutionsVC.swift
//  TestCraft
//
//  Created by ADMS on 26/06/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage
import WebKit;

class SolutionsVC: UIViewController, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var lblCountDown: UILabel!
    @IBOutlet var lblPage: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblMarks: UILabel!
    @IBOutlet var lblSystemAnswer: UILabel!
    @IBOutlet var lblYourAnswer: UILabel!
    @IBOutlet var imgYourAnsIcon:UIImageView!

    @IBOutlet var quecollectionView:UICollectionView!
    @IBOutlet var queCollectionNewView:UICollectionView!
    @IBOutlet var queView:UIView!

    var redViewYPositionConstraint: NSLayoutConstraint?
    @IBOutlet var queWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var queCenterAlignUsername: NSLayoutConstraint!

    var arrQueAns = [Que_Ans_Model]()
    @IBOutlet var viewQuestionBackground: UIView!
    @IBOutlet var tblQuestion:UITableView!

    @IBOutlet var btnPrevious:UIButton!
    @IBOutlet var btnNext:UIButton!
    @IBOutlet var btnReport:UIButton!
    @IBOutlet var btnSubmit:UIButton!
    //    @IBOutlet var btnPause:UIButton!
    @IBOutlet var btnViewQue:UIButton!

    @IBOutlet var imgReport:UIImageView!
    @IBOutlet var imgReadChanged:UIImageView!
    @IBOutlet var btnReadChanged:UIButton!
    @IBOutlet var imgHint:UIImageView!
    @IBOutlet var btnHint:UIButton!
    var count_total_row = 0

    @IBOutlet var viewWebPopupExplain: UIView!
    @IBOutlet var subViewWebPopupExplain: UIView!
    @IBOutlet var webviewExplain: WKWebView!
    @IBOutlet var lblExplain: UILabel!

    @IBOutlet var imgInfoPopupDotCurrent:UIImageView!
    @IBOutlet var imgInfoPopupDotAnswerd:UIImageView!
    @IBOutlet var imgInfoPopupDotUnAnswered:UIImageView!
    @IBOutlet var imgInfoPopupDotReviewLater:UIImageView!
    @IBOutlet var imgInfoPopupDotNotVisited:UIImageView!

    var rowHeights:[Int:CGFloat] = [:] //declaration of Dictionary
    var rowHeaderHeights:[Int:CGFloat] = [:] //declaration of Dictionary
    var strTestTitle = ""
    var strQueType = ""
    var strSelectedIndex = 0
    var strSectionSelectedIndex = 0
    var strTestID = ""
    var strStudentTestID = ""
    var strTotalQuetion = ""
    //    var intProdSeconds = Int()
    //    var timer = Timer()
    //    var isTimerRunning = false  // Make sure only one timer is running at a time
    var que_delay = 0.10
    var ans_delay = 0.10
    var refreshControl = UIRefreshControl()
    @IBOutlet var left_Space: NSLayoutConstraint!
    @IBOutlet var Right_Space: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()

        HideAll()
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2400", comment: "View Solutions Screen", isFirstTime: "0")
        subViewWebPopupExplain.addShadowWithRadius(7,16.0,0,color: UIColor.darkGray)
        btnReadChanged.addTarget(self, action: #selector(ReadAgainClicked), for: .touchUpInside)
        btnHint.addTarget(self, action: #selector(HintClicked), for: .touchUpInside)
        queCollectionNewView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell")
        lblTitle.text = strTestTitle
        if UIDevice.current.userInterfaceIdiom == .pad {
            //Bhargav Hide
            ////print("iPad")
            que_delay = 0.10
            ans_delay = 0.05

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
        //        tblQuestion.delegate = self

        // Do any additional setup after loading the view.  #selector(startEditing)
        apiGet_Que_ListApi()
        //        lblCountDown.backgroundColor = UIColor(rgb: 0x0BAEC5)
        //        lblCountDown.addShadowWithRadius(0,10.0,1,color: UIColor.darkGray)
        //        var timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        //        self.tabBarController?.tabBar.isHidden = true
        self.queView.isHidden = true
        //        self.hideRedViewAnimated1(animated: false)

        tblQuestion.addShadowWithRadius(0,16.0,0,color: UIColor.darkGray)
        viewQuestionBackground.addShadowWithRadius(7,16.0,0,color: UIColor.darkGray)
        btnNext.setTitleColor(UIColor.white, for: .normal)
        btnNext.backgroundColor = UIColor(rgb: 0x10A8DD) //GetColor.blueHeaderText
        btnNext.addShadowWithRadius(2,btnNext.frame.width/6,0,color: GetColor.blueHeaderText)

        imgInfoPopupDotCurrent.setImageForName("", backgroundColor: GetColor.dotColorCurrent, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotAnswerd.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotUnAnswered.setImageForName("", backgroundColor: GetColor.dotColorUnAnswered, circular: true, textAttributes: nil, gradient: false)
        //        imgInfoPopupDotReviewLater.setImageForName("", backgroundColor: GetColor.dotColorReviewLater, circular: true, textAttributes: nil, gradient: false)
        imgInfoPopupDotNotVisited.setImageForName("", backgroundColor: GetColor.dotColorNotVisited, circular: true, textAttributes: nil, gradient: false)



        //        btnReport.isHidden = true
        ////        btnPause.isHidden = true
        //        btnNext.isHidden = true
        //        btnPrevious.isHidden = true
        //        btnSubmit.isHidden = true


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        if isGotoDashBoard == "1"
        {
            BackToDashbord(VC: self)
        }
    }
    @objc func refresh(_sender: AnyObject) {
        // Code to refresh table view
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.WebviewReloadCount = 0
            self.count_total_row = 0
            //                            queCollectionNewView.reloadData()
            //            rowHeights.removeAll()
            //                for i in (0..<self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count)
            //                                    {
            //                                        self.rowHeights[i] = 0.0
            //                                    }
            self.reloadView()
            self.reloadTableview()

            //            self.tblQuestion.reloadData()
            //        self.reloadView()
            self.refreshControl.endRefreshing()
        }
    }

    func hideRedViewAnimated1(animated: Bool) {
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
        self.performConstraintLayout1(animated: animated)
    }

    func showRedViewAnimated1(animated: Bool) {
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
        self.performConstraintLayout1(animated: animated)
    }
    var WidthQueLayout : CGFloat = 0
    func performConstraintLayout1(animated: Bool) {
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
                //self.queCenterAlignUsername.constant += self.view.bounds.width
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
        //        btnPause.isHidden = true
        viewWebPopupExplain.isHidden = true
        btnNext.isHidden = true
        btnPrevious.isHidden = true
        btnSubmit.isHidden = true
        btnReport.isHidden = true
        imgReport.isHidden = true
        btnHint.isHidden = true
        imgHint.isHidden = true
        lblCountDown.isHidden = true
        lblPage.isHidden = true
        lblMarks.isHidden = true
        imgReadChanged.isHidden = true
        btnReadChanged.isHidden = true
        btnViewQue.isHidden = true
        lblSystemAnswer.isHidden = true
        lblYourAnswer.isHidden = true
    }
    func ShowAll() {
        //        btnPause.isHidden = false
        btnNext.isHidden = false
        btnPrevious.isHidden = true
        //        btnSubmit.isHidden = false
        btnReport.isHidden = false
        imgReport.isHidden = false
        lblCountDown.isHidden = false
        btnHint.isHidden = true
        imgHint.isHidden = true
        lblPage.isHidden = false
        lblMarks.isHidden = false
        //        imgReadChanged.isHidden = false
        //        btnReadChanged.isHidden = false
        btnViewQue.isHidden = false
        lblSystemAnswer.isHidden = false
        lblYourAnswer.isHidden = false
    }

    func reloadView() {
        btnReadChanged.setImage(nil, for: .normal)
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que.count == 0 {return}
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
        lblCountDown.text = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].total_timer

        lblMarks.text = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_marks
        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation == ""
        {
            btnHint.isHidden = true
            imgHint.isHidden = true
        }
        else
        {
            btnHint.isHidden = true//false
            imgHint.isHidden = true//false

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
        //        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProdTimer), userInfo: nil, repeats: true)
        //        isTimerRunning = true
        //        let imageName = "pause.png"
        //        btnPause.setImage(UIImage(named: imageName), for: .normal)

    }

    //    @objc func updateProdTimer() {
    //        if intProdSeconds < 1 {
    ////            timer.invalidate()
    ////            lblCountDown.text = "00:00"
    ////            TimeOverPopup()
    //        }
    //        else {
    //            intProdSeconds -= 1
    //            lblCountDown.text = prodTimeString(time: TimeInterval(intProdSeconds))
    //        }
    //    }

    func prodTimeString(time: TimeInterval) -> String {
        let prodMinutes = Int(time) / 60 % 60
        let prodSeconds = Int(time) % 60
        //        if prodSeconds % 2 == 0 {
        //even Number
        return String(format: "%02d : %02d", prodMinutes, prodSeconds)
        //        } else {
        //            // Odd number
        //            return String(format: "%02d   %02d", prodMinutes, prodSeconds)
        //        }
    }


    @objc func TimeOverPopup() {
        SubmitAlertMessage.dismiss(animated: true, completion: nil)
        let alert = UIAlertController(title: "Your test time is over", message: "", preferredStyle: .alert)
        alert.setValue(UIImage(named: "risk_blue"), forKey: "image")

        //alert.setTitleImage(UIImage(named: "risk_blue"))
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
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SubmitClicked(_ sender: AnyObject) {
        submitTest()
    }
    @IBAction func hideQuePopupView(_ sender: AnyObject) {
        self.queView.isHidden = true
        //        self.hideRedViewAnimated1(animated: false)
    }
    @IBAction func viewQueClicked(_ sender: AnyObject) {
        self.queView.isHidden = false
        //        self.showRedViewAnimated1(animated: false)
    }
    var SubmitAlertMessage = UIAlertController()
    func submitTest()
    {
        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        SubmitAlertMessage = UIAlertController(title: "Submit Test?", message: "Hey \(result.value(forKey: "StudentFirstName") ?? "") are you sure you want to end this test?", preferredStyle: .actionSheet)

        let action = UIAlertAction(title: "Submit", style: .default, handler: doSomething)
        let actionClose = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        SubmitAlertMessage.addAction(action)
        SubmitAlertMessage.addAction(actionClose)

        self.present(SubmitAlertMessage, animated: true, completion: nil)
    }
    func doSomething(action: UIAlertAction) {
        //Use action.title
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HighlightsVC") as? HighlightsVC
        var crct = 0
        var NotAnswer = 0
        for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)
        {

            for var j in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[i].que_ans.count)
            {
                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[i].que_ans[j].selected == "1"
                {
                    crct = crct + 1
                    //                arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected = "0"
                    //                let indexPath1 = IndexPath(item: i, section: 0)
                    //                tblQuestion.reloadRows(at: [indexPath1], with: .none)
                    //                oldvalue = i
                }
                j += 1
            }
            i += 1
        }
        NotAnswer = arrQueAns[self.strSectionSelectedIndex].arr_section_que.count - crct
        vc!.strCorrect = "\(crct)"
        vc!.strInCorrect = "09"
        vc!.strUnanswered = "\(NotAnswer)"
        vc!.strTotal = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"

        //        SJSwiftSideMenuController.pushViewController(vc!, animated: false)
        self.navigationController?.pushViewController(vc!, animated: true)

        //        navigationController?.popViewController(animated: false)
    }

    //    let alert = UIAlertController(title: "Alert Title", message: "Alert Message", style = .Alert)
    //    for i in ["hearts", "spades", "diamonds", "hearts"] {
    //    alert.addAction(UIAlertAction(title: i, style: .Default, handler: doSomething)
    //    }
    //    self.presentViewController(alert, animated: true, completion: nil)
    @objc func HintClicked(sender: UIButton) {
        //                let htmlString = "<html><body style='background-color:clear;'><br><p style='color:#000000; font-family:Inter-Regular'><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
        //        let DisplaySize = ""
        let htmlString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background-color:clear;'><div style='color:#000000; font-family:Inter-Regular; FONT-SIZE :14PX; LINE-HIGHT : 12PX; vertical-align: middle'>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</div></body></html>"

        self.loadExpViewPopup(strUrl: htmlString, strTitle: "Explaination")
        //        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        //        var alert = UIAlertController()
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            //Bhargav Hide
        ////print("iPad")
        ////            alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.alert)
        //
        //        }else{
        //            //Bhargav Hide
        ////print("not iPad")
        //            alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        //
        //        }
        //        let cancel = UIAlertAction(title: "Close", style: UIAlertAction.Style.destructive, handler: nil)
        //        let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 22.0)!]
        //        let titleAttrString = NSMutableAttributedString(string: "Explanation", attributes: titleFont)
        //        alert.setValue(titleAttrString, forKey: "attributedMessage")
        //
        //        let height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        //        //        let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height - 20)
        //        //        let x_axis:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.leftMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 10)
        //        ////        alert.view.addConstraint(x_axis);
        //        alert.view.addConstraint(height);
        //        //        alert.view.addConstraint(width);
        //        alert.view.frame.origin.y = 60
        //        //        alert.view.frame.size.height = self.view.frame.height * 0.90
        //        alert.view.frame.size.height = self.view.frame.height * 0.90
        //        alert.view.frame.size.width = self.view.frame.width - 20
        //        let web = UIWebView(frame: CGRect(x: 2, y: alert.view.frame.origin.y + 10, width: alert.view.frame.size.width, height: self.view.frame.size.height * 0.85 - 95)) // take note that right here, in the height:, I’ve changed 0.8 to 0.85 so it should look more consistent on the top and bottom
        ////        let htmlString = "<html><body style='background-color:clear;'><br><p align=center><font size=30><b>" + "Hint" + "</b></font></p><hr><p><font size=10>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</font></p><br><p align=center><font size=30  align=center><b>" + "Explanation" + "</b></font></p><hr><p><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
        //        let htmlString = "<html><body style='background-color:clear;'><br><p><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
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
        //        alert.view.addSubview(web)
        //        alert.addAction(cancel)
        //        self.present(alert, animated: false, completion: nil)
        //
        //
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


        //        self.quecollectionView.reloadData()
        self.queCollectionNewView.reloadData()
        self.reloadView()

        //        UIView.transition(with: self.tblQuestion,
        //                          duration: 0.35,
        //                          options: .curveEaseInOut,
        //                          animations: { self.tblQuestion.reloadData() })


    }
    //    @IBAction func PauseClicked(_ sender: AnyObject) {
    //        // Create AlertController
    //        let imageName = "play.png"
    //        btnPause.setImage(UIImage(named: imageName), for: .normal)
    ////        timer.invalidate()
    //        let alert = AlertController(title: "Test Paused", message: "", preferredStyle: .actionSheet)
    //        //        alert.setTitleImage(UIImage(named: ""))
    //        // Add actions
    //        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
    ////            self.runProdTimer()
    //
    //        })
    //        action.actionImage = UIImage(named: "close")
    //        alert.addAction(UIAlertAction(title: "Resume", style: .default, handler: {(alert: UIAlertAction!) in
    ////            self.runProdTimer()
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
    ////                self.runProdTimer()
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
    //    }
    var Report_alert = AlertController()

    @IBAction func reportClicked(_ sender: AnyObject) {
        //        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue == "1"
        //        {
        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue = "0"
        //        }
        //        else
        //        {
        //            //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].report_issue = "1"
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2401", comment: "Report an issue", isFirstTime: "0")

        // Create AlertController
        Report_alert = AlertController(title: "", message: "Report an issue", preferredStyle: .alert)
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 17.0)!]
        let titleAttrString = NSMutableAttributedString(string: "Report an issue", attributes: titleFont)
        Report_alert.setValue(titleAttrString, forKey: "attributedMessage")

        Report_alert.setTitleImage(UIImage(named: "risk_blue"))
        // Add actions
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2504", comment: "Cancel Button", isFirstTime: "0")
        })
        action.actionImage = UIImage(named: "close")
        Report_alert.addAction(UIAlertAction(title: "Question has a problem", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.Report_Isue_Api(strSelection: "1", strIssueDescription: "Question has a problem")
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2501", comment: "Viewsolution Question has a problem", isFirstTime: "0")

            //                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
            //                self.reloadView()
        }))
        Report_alert.addAction(UIAlertAction(title: "Answer has a problem", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.Report_Isue_Api(strSelection: "2", strIssueDescription: "Answer has a problem")
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2502", comment: "Viewsolution Answer has a problem", isFirstTime: "0")
            //                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
            //                self.reloadView()
        }))
        //                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation == ""
        //        {
        //        }else
        //        {
        Report_alert.addAction(UIAlertAction(title: "Explanation has a problem", style: .destructive, handler: {(alert: UIAlertAction!) in
            self.Report_Isue_Api(strSelection: "4", strIssueDescription: "Explanation has a problem")
            self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2503", comment: "Viewsolution Explanation has a problem", isFirstTime: "0")
            //                self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].report_issue = "1"
            //                self.reloadView()
        }))
        //    }
        //            AlertController.setValue(UIColor.orange, forKey: "titleTextColor")
        Report_alert.addAction(action)
        present(Report_alert, animated: true, completion: nil)

        //        }
        //        //        self.quecollectionView.reloadData()
        //        //reloadTableview()

    }
    @IBAction func nextQue(_ sender: AnyObject) {
        if sender.titleLabel?.text == "Finish"
        {

        }else
        {
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2402", comment: "Viewsolution Next Button", isFirstTime: "0")

            strSelectedIndex = strSelectedIndex + 1
            if strSelectedIndex == arrQueAns[self.strSectionSelectedIndex].arr_section_que.count{
                strSectionSelectedIndex = strSectionSelectedIndex + 1
                strSelectedIndex = 0
            }

            //        self.count_total_row = 0
            //        self.quecollectionView.reloadData()
            //        let indexPath = NSIndexPath(row: strSelectedIndex, section: 0)
            //        quecollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            //        rowHeights.removeAll()
            //        self.reloadView()
            //        self.reloadTableview()
            //        self.lblPage.text = "\(self.strSelectedIndex + 1) /\(self.arrQueAns.count)"
            Next_PreviousQue(str: "")
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
        self.queCollectionNewView.reloadData()
        //        let indexPath = NSIndexPath(row: strSelectedIndex, section: 0)
        //        quecollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        for var i in (0..<self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        {
            //            self.rowHeights[self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count - 1] = nil
            self.rowHeights[i] = 50 // 0.0
        }
        //        rowHeights.removeAll()
        self.reloadView()
        reloadTableview()

        //        self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
    }
    var WebviewReloadCount = 0
    func reloadTableview()
    {
        WebviewReloadCount = 0
        //        self.tblQuestion.scroll(to: .top, animated: false)//.setContentOffset(bottomOffset, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            //            let bottomOffset = CGPoint(x: 0, y: 0)
            self.tblQuestion.reloadData()
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            self.tblQuestion.scroll(to: .top, animated: false)//.setContentOffset(bottomOffset, animated: true)
            //                self.tblQuestion.reloadData()
            //            }
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
                               if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

        //                           // show Alert
        //                           self.hideActivityIndicator()
        //                           print("The network is not reachable")
        //                           // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                                   return
                               }

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
    func apiGet_Que_ListApi()
    {
        showActivityIndicator()
        //        self.arrQueAns.removeAll()
        //        let params = ["TokenId":"t1506-o2506-u3506-r4506"]//strCategoryID]
        let params = ["TestID":strTestID,"StudentTestID":strStudentTestID]//strCategoryID]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //  //Bhargav Hide
        print("API, Params: \n https://content.testcraft.co.in/mobileservice.asmx/GetRandomQuestions",params)
        //Bhargav Hide
        print("API, Params: \n",API.Get_Student_StudentTestAnswerNewApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            //  // show Alert
            self.hideActivityIndicator()
            //  print("The network is not reachable")
            //  // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API.Get_Student_StudentTestAnswerNewApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1" || json["status"] == "1") {
                    let arrData = json["data"].array
                    var countTitle = 1
                    for values in arrData! {
                        let arrTestQuestion = values["TestQuestion"].array
                        var arrTempQue = [Que_Ans_Model]()
                        for value in arrTestQuestion! {

                            var arrAnsModal = [Que_Ans_Model]()
                            let arrMCQ = value["StudentTestQuestionMCQ"].array//value["StudentTestAnswerMCQ"].array
                            var strSystemAnswer = ""
                            var strYourAnswer = ""

                            var isVisited = "0"
                            let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "\(value["QuestionID"].stringValue)", display_no: "-", name: "\(value["title"].stringValue)", type: "Q", img_link: "\(value["QuestionImage"].stringValue)", isCorrectAnswer: "\(value["IsCorrectAnswer"].stringValue)", selected: "0")

                            arrAnsModal.append(ansModel)
                            //                        var strCurrectAns = "false"
                            let strQuestionTypeID = "\(value["QuestionTypeID"].stringValue)"
                            //                        if arrMCQ != nil{
                            if strQuestionTypeID == "1" || strQuestionTypeID == "3" || strQuestionTypeID == "7"{
                                for values in arrMCQ! {
                                    let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "\(values["MultipleChoiceQuestionAnswerID"].stringValue)", display_no: "\(values["optiontext"].stringValue)", name: "\(values["title"].stringValue)", type: "A", img_link: "\(values["AnswerImage"].stringValue)", isCorrectAnswer: "\(values["IsCorrectAnswer"].stringValue)", selected: "\(values["IsUserSelected"].stringValue)")//StudentAnswer
                                    arrAnsModal.append(ansModel)
                                    //                            if values["IsCorrectAnswer"].stringValue == "true" && values["IsUserSelected"].stringValue == "true"
                                    //                            {
                                    //                                strCurrectAns = "true"
                                    //                            }
                                }
                                //                                strSystemAnswer = "\(value["SystemAnswer"].stringValue)"
                                //                                strYourAnswer = "\(value["YourAnswer"].stringValue)"
                            }
                            //radio = 1, Multiselection(checkbox) = 2,//old
                            else
                            {
                                if strQuestionTypeID == "2" || strQuestionTypeID == "8"// Fill in the blanks
                                {
                                    var strAnswer = "\(value["Answer"].stringValue)"
                                    //  if value["Answered"].stringValue != ""
                                    //  { strAnswer = "1";isVisited = "1"}
                                    //  var strisCurrect = "0"
                                    //  if value["CorrectAnswer"].stringValue == "True" || value["CorrectAnswer"].stringValue == "true" // original ans
                                    //  { strisCurrect = "1"}
                                    //  else
                                    //  { strisCurrect = "0"}
                                    var strTrueAnswer = ""
                                    var strFalseAnswer = "1"
                                    if value["IsCorrect"].stringValue == "True" || value["IsCorrect"].stringValue == "true" // original ans
                                    {strTrueAnswer = "1"}
                                    else if value["IsCorrect"].stringValue == "False" || value["IsCorrect"].stringValue == "false"
                                    {strFalseAnswer = "1"}

                                    let ansModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "-", name: strAnswer, type: "A", img_link: "", isCorrectAnswer: strTrueAnswer, selected: strFalseAnswer)
                                    arrAnsModal.append(ansModel)

                                    //  let strCorrectAnswer = value["CorrectAnswer"].stringValue
                                    //  let isCorrectAnswerModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "-", name: strCorrectAnswer, type: "A", img_link: "", isCorrectAnswer: "1", selected: "1")
                                    //  arrAnsModal.append(isCorrectAnswerModel)
                                    //  strSystemAnswer = "\(value["CorrectAnswer"].stringValue)"
                                    //  strYourAnswer = "\(value["Answer"].stringValue)"
                                }
                                if strQuestionTypeID == "4" // true false
                                {
                                    var strTrueUserAnswer = ""//"\(value["Answer"].stringValue)"
                                    var strFalseUserAnswer = ""//"\(value["Answer"].stringValue)"
                                    if value["Answer"].stringValue == "1" // my selected ans
                                    { strTrueUserAnswer = "1";isVisited = "1"}
                                    else if value["Answer"].stringValue == "0"
                                    { strFalseUserAnswer = "1";isVisited = "1"}

                                    var strTrueAnswer = ""
                                    var strFalseAnswer = ""
                                    if value["CorrectAnswer"].stringValue == "True" || value["CorrectAnswer"].stringValue == "true" // original ans
                                    { strTrueAnswer = "1"}
                                    else if value["CorrectAnswer"].stringValue == "False" || value["CorrectAnswer"].stringValue == "false"
                                    { strFalseAnswer = "1"}

                                    let ansTrueModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "", name: "True", type: "A", img_link: "", isCorrectAnswer: strTrueAnswer, selected: strTrueUserAnswer)
                                    arrAnsModal.append(ansTrueModel)
                                    let ansFalseModel:Que_Ans_Model = Que_Ans_Model.init(id: "", display_no: "", name: "False", type: "A", img_link: "", isCorrectAnswer: strFalseAnswer, selected: strFalseUserAnswer)
                                    arrAnsModal.append(ansFalseModel)
                                    //                                    strSystemAnswer = "\(value["CorrectAnswer"].stringValue)"
                                    //                                    strYourAnswer = "\(value["Answer"].stringValue)"
                                    if value["Answer"].stringValue == "1" // my selected ans
                                    {strYourAnswer = "True"}
                                    else if value["Answer"].stringValue == "0"
                                    {strYourAnswer = "False"}
                                }

                            }
                            strSystemAnswer = "\(value["SystemAnswer"].stringValue)"
                            strYourAnswer = "\(value["YourAnswer"].stringValue)"
                            let strExplanation = "\(value["Explanation"].stringValue)"
                            if strExplanation == "" {} else {}
                            let HintModel:Que_Ans_Model = Que_Ans_Model.init(id: "00000", display_no: "Explanation", name: "\(value["Hint"].stringValue)", type: "Hint", img_link: "", isCorrectAnswer: "", selected: "0")

                            arrAnsModal.append(HintModel)

                            let queModel:Que_Ans_Model = Que_Ans_Model.init(title: "\(value["title"].stringValue)", que_no: "\(countTitle)", que_id: "\(value["QuestionID"].stringValue)", que_type: "\(value["QuestionTypeID"].stringValue)", total_timer: "Time: \(value["QuestionTime"].stringValue)", current_time: "", report_issue: "0", mark_as_review: "0", isVisited: "0", isAnsTrue: "\(value["IsCorrect"].stringValue)", que_ans: arrAnsModal, test_que_id: "\(value["TestQuestionID"].stringValue)", str_marks:"Marks: \(value["ObtainMarks"].stringValue)/\(value["Marks"].stringValue)", str_answered:"\(value["Answered"].stringValue)", str_ans:"\(value["Answer"].stringValue)", str_Hint: "\(value["Hint"].stringValue)", str_HintUsed: "\(value["HintUsed"].stringValue)", str_Explanation: "\(value["Explanation"].stringValue)", str_system_answer:strSystemAnswer, str_your_answer:strYourAnswer)
                            arrTempQue.append(queModel)

                            countTitle += 1
                        }
                        let sectionModel:Que_Ans_Model = Que_Ans_Model.init(section_id: "\(values["SectionID"].stringValue)", section_name: "\(values["SectionName"].stringValue)", section_type: "0", section_description: "\(values["SectionInstruction"].stringValue)", section_selected: "0", arr_section_que: arrTempQue)

                        self.arrQueAns.append(sectionModel)

                    }
                    if arrData!.count > 0
                    {
                        self.ShowAll()

                        self.strSelectedIndex = 0
                        self.strSectionSelectedIndex = 0
                        self.reloadView()
                        //                        self.intProdSeconds = 600
                        //                        self.intProdSeconds = self.intProdSeconds * 60
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
                            self.reloadTableview()
                            //                            if self.isTimerRunning == false {
                            //                                self.runProdTimer()
                            //                            }

                        }
                        for var i in (0..<self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count)
                        {
                            self.rowHeights[i] = 0.0
                        }


                        //                        self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
                    }
                    //                    self.quecollectionView.reloadData()
                    self.queCollectionNewView.reloadData()

                }
            case .failure(let error):
                //Bhargav Hide
                ////print("error: ",error)
                                if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                //                    // show Alert
                                    self.hideActivityIndicator()
                //                    print("The network is not reachable")
                //                    // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                                    return
                                }
                //                else{
                //                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
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
            //                }
            }
        }
    }
}


extension SolutionsVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{

    @objc func popupSectionHeading(_ gesture:UIGestureRecognizer)
    {
        var alertWebview = UIAlertController()
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2404", comment: "Secttion Instruction", isFirstTime: "0")

        let Index:Int = (gesture.view?.tag)!
        //            let url = arrQueAns[Index].section_name//section_description
        //            let htmlString = "<html><body style='background-color:clear;'><br><p><font size=18>" + "\(arrQueAns[Index].section_description)" + "</font></p></body></html>"
        //            let htmlString = "<html><body style='background-color:clear;'><br><p style='color:#000000; font-family:Inter-Regular'><font size=18>" + "\(arrQueAns[Index].section_description)" + "</font></p></body></html>"
        let strDesc = "\(arrQueAns[Index].section_description)"
        if strDesc == ""
        {

        }else{
            let htmlString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background-color:clear;'><div style='color:#000000; font-family:Inter-Regular; FONT-SIZE :14PX; LINE-HIGHT : 12PX; vertical-align: middle'>" + "\(arrQueAns[Index].section_description)" + "</div></body></html>"

            loadExpViewPopup(strUrl: htmlString, strTitle: "\(arrQueAns[Index].section_name)")
        }
        //    //        var alert = UIAlertController()
        ////            if UIDevice.current.userInterfaceIdiom == .pad {
        ////                //Bhargav Hide
        ////print("iPad")
        //                alertWebview = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        ////                if let popoverController = alertWebview.popoverPresentationController {
        //////                    popoverController.barButtonItem = self
        ////                    alertWebview.popoverPresentationController?.sourceView = self.view
        ////                    alertWebview.popoverPresentationController?.sourceRect = sender.frame
        ////                }
        ////
        ////            }else{
        ////                //Bhargav Hide
        ////print("not iPad")
        ////                alertWebview = UIAlertController(title: "", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        ////
        ////            }
        //
        //            let cancel = UIAlertAction(title: "Close", style: UIAlertAction.Style.destructive, handler: nil)
        //            let titleFont = [NSAttributedString.Key.font: UIFont(name: "Inter-Medium", size: 18.0)!]
        //            let titleAttrString = NSMutableAttributedString(string: "\(arrQueAns[Index].section_name)", attributes: titleFont)
        //            alertWebview.setValue(titleAttrString, forKey: "attributedMessage")
        //
        //            let height:NSLayoutConstraint = NSLayoutConstraint(item: alertWebview.view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.90)
        //            //        let width:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height - 20)
        //            //        let x_axis:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutConstraint.Attribute.leftMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 10)
        //            ////        alert.view.addConstraint(x_axis);
        //            alertWebview.view.addConstraint(height);
        //            //        alert.view.addConstraint(width);
        //            alertWebview.view.frame.origin.y = 60
        //            //        alert.view.frame.size.height = self.view.frame.height * 0.90
        //            alertWebview.view.frame.size.height = self.view.frame.height * 0.90
        //            alertWebview.view.frame.size.width = self.view.frame.width - 20
        //            let web = UIWebView(frame: CGRect(x: 2, y: alertWebview.view.frame.origin.y + 10, width: alertWebview.view.frame.size.width, height: self.view.frame.size.height * 0.85 - 95)) // take note that right here, in the height:, I’ve changed 0.8 to 0.85 so it should look more consistent on the top and bottom
        //            let htmlString = "<html><body style='background-color:clear;'><br><p><font size=10>" + "Test Section.." + "</font></p></body></html>"//<br><p align=center><font size=30  align=center><b>" + "Explanation" + "</b></font></p><p><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
        //
        //            web.loadHTMLString(htmlString, baseURL: nil)
        //            //        web.backgroundColor = UIColor.lightGray
        //            //        web.scrollView.backgroundColor = UIColor.lightGray
        //            //        let requestURL = NSURL(string: "http://www.google.it");
        //            //        let request = NSURLRequest(url: requestURL! as URL);
        //            //        web.loadRequest(request as URLRequest);
        //            web.scalesPageToFit = true
        //            //        web.loadRequest(request as URLRequest)
        //            //        web.scrollView.bouncesZoom = false
        //            web.scrollView.bounces = false
        //            //        web.scrollView.
        //            //        let htmlString = "<p>Identify the arrow-marked structures in the images<img alt=\"\" src=\"https://dams-apps-production.s3.ap-south-1.amazonaws.com/course_file_meta/73857742.PNG\"></p>"
        //
        //            alertWebview.view.addSubview(web)
        //            alertWebview.addAction(cancel)

        //            self.present(alertWebview, animated: false, completion: nil)

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

            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(popupSectionHeading(_:)))
            userHeader.contentView.tag = indexPath.section
            userHeader.contentView.addGestureRecognizer(tapGesture)

            //            userHeader.btnSeeAll.tag = indexPath.section
            //            userHeader.btnSeeAll.addTarget(self,action:#selector(seeAllClicked(sender:)), for: .touchUpInside)

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
            let cell:QueAnsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "QueAnsCollectionViewSolCell", for: indexPath) as! QueAnsCollectionViewCell
            //  cell.bgView.backgroundColor = GetColor.seaGreen
            //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
            //  cell.bgView.addShadowWithRadius(0,0,0)
            cell.displayData("Main",arrQueAns[indexPath.section].arr_section_que[indexPath.row].que_no)
            cell.lblLine.backgroundColor = UIColor(rgb: 0x000000)
            let isAnsTrue = self.arrQueAns[indexPath.section].arr_section_que[indexPath.row].isAnsTrue
            if strSelectedIndex == indexPath.row && strSectionSelectedIndex == indexPath.section{
                cell.lblLine.isHidden = false
                cell.lblTitle.textColor = UIColor(rgb: 0xFFFFFF)//UIColor(rgb: 0xFFFFFF)
                cell.imgIcon.setImageForName("", backgroundColor: GetColor.blueHeaderText, circular: true, textAttributes: nil, gradient: false)
            }
            else if isAnsTrue == "True" || isAnsTrue == "true" {
                cell.lblLine.isHidden = false
                cell.lblTitle.textColor = UIColor(rgb: 0xFFFFFF)//UIColor(rgb: 0xFFFFFF)
                cell.imgIcon.setImageForName("", backgroundColor: GetColor.dotColorAnswered, circular: true, textAttributes: nil, gradient: false)

//                let imageName = "green-dot.png"
//                cell.imgIcon.image = UIImage(named: imageName)
            }
            else if isAnsTrue == "False" || isAnsTrue == "false"{
                cell.lblLine.isHidden = false
                cell.lblTitle.textColor = UIColor(rgb: 0xFFFFFF)//UIColor(rgb: 0xFFFFFF)
                let imageName = "red-dot.png"
                cell.imgIcon.image = UIImage(named: imageName)
            }
            else//if self.arrQueAns[indexPath.section].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].id
            {
                cell.lblLine.isHidden = true
                cell.lblTitle.textColor = UIColor(rgb: 0x808080)
                cell.imgIcon.setImageForName("", backgroundColor: UIColor(rgb: 0xEBEBEB), circular: true, textAttributes: nil, gradient: false)
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
            strSectionSelectedIndex = indexPath.section
            strSelectedIndex = indexPath.item
            self.count_total_row = 0
//            let indexPath = NSIndexPath(row: indexPath.item, section: 0)
//            queCollectionNewView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            queCollectionNewView.reloadData()
//            rowHeights.removeAll()
                    for var i in (0..<self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
                    {
            //            self.rowHeights[self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count - 1] = nil
                        self.rowHeights[i] = 0.0
                    }
            reloadView()
            self.reloadTableview()
//            self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
                        self.queView.isHidden = true
//            self.hideRedViewAnimated1(animated: false)
        }
        else
        {
            //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubCategory1VC") as? SubCategory1VC
            //        strCategoryID1 = arrHeaderSubTitle[indexPath.item].id ?? ""
            //        strCategoryTitle1 = arrHeaderSubTitle[indexPath.item].title ?? ""
            //        arrPath.append(arrHeaderSubTitle[indexPath.item].title ?? "")
            //
            //        self.navigationController?.pushViewController(vc!, animated: true)
            strSectionSelectedIndex = indexPath.section
            strSelectedIndex = indexPath.item
            self.count_total_row = 0
            let indexPath = NSIndexPath(row: indexPath.item, section: 0)
            quecollectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            quecollectionView.reloadData()
        for var i in (0..<self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        {
//            self.rowHeights[self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count - 1] = nil
            self.rowHeights[i] = 0.0
        }
            //            rowHeights.removeAll()
            reloadView()
            self.reloadTableview()
//            self.lblPage.text = "Section: \(self.strSectionSelectedIndex + 1) / \(self.arrQueAns.count)        Page: \(self.strSelectedIndex + 1) / \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count)"
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
    //                self.lblPage.text = "\(self.strSelectedIndex + 1) /\(self.arrQueAns.count)"
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

extension SolutionsVC:UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate
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
        if arrQueAns.count > 0
        {
            return self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count
        }else
        {
            return 0
        }
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrQueAns.count > 0
        {
            let strAnswear = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count
            if indexPath.row == (strAnswear - 1)
            {
//                if let height = self.rowHeights[indexPath.row]
//                {
//                print(height + 100)
//                return height + 100
//                }
//                else
//                {
//                    return 0
//                }

//                if UIDevice.current.userInterfaceIdiom == .pad {
//                    return 250
//                }
//                else
//                {
//                    return 150
//                }
//                if let height = self.rowHeights[indexPath.row]
//                {
                    return self.rowHeights[indexPath.row] ?? 0
//                }
//                else
//                {
//                    return 50
//                }
//                return UITableView.automaticDimension
            }
            else
            {
                let temp_que_type = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_type
                if temp_que_type == "2" || temp_que_type == "8" //Fill in the blanks
                {
                    if let height = self.rowHeights[indexPath.row]
                    {
                        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2
                        {
                            return height
                        }
                        else
                        {
                            return 50
                        }
                    }
                    else
                    {
                        return 50
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
                        return 50
                    }
                }
            }
        }
        else
        {
            return 50
        }
        //        if let height = self.rowHeights[indexPath.row]{
//            return height
//        }else{
//            return 0
//        }
        //        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0

    }

//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.frame.size.height = 1
//        webView.frame.size = webView.scrollView.contentSize
//    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      print("Strat to load")
        //        self.rowHeights[self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count - 1] = nil
        print("Load start...\n",webView)
        //        webView.frame.size.height = 1
        //        self.rowHeights[webView.tag] = 0.0
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      print("finish to load")
//        print("Load did Finish...\n",webView)
//        let height = webView.scrollView.contentSize.height
//        print("Load did Finish...\n",height,rowHeights[webView.tag]!)
//
//        if (self.rowHeights[webView.tag] == 0.0 || self.rowHeights[webView.tag] == nil)
//        {
//
//            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation == ""
//            {
//                return
//            }
//            // we already know height, no need to reload cell
//            webView.frame.size.height = 1
//            webView.frame.size = webView.scrollView.contentSize
//            self.rowHeights[webView.tag] = webView.scrollView.contentSize.height
//            //Bhargav Hide
//            print("hight depend on hight..... \(webView.scrollView.contentSize.height)")
////                                            tblQuestion.reloadData()
//            tblQuestion.reloadRows(at: [(NSIndexPath(row: webView.tag, section: 0) as IndexPath)], with: .none)
//
//            return
//        }
//        else
//        if WebviewReloadCount < 15{
//            print("WebviewReloadCount______:",WebviewReloadCount)
//
//            if (self.rowHeights[webView.tag] != height || self.rowHeights[webView.tag] == 0.0)
//        {
//            print("Not equal to...",self.rowHeights[webView.tag]!, height)
//            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation == ""
//            {
//                return
//            }
//            // we already know height, no need to reload cell
//            webView.frame.size.height = 1
//            webView.frame.size = webView.scrollView.contentSize
//            self.tblQuestion.beginUpdates()
//
//            self.rowHeights[webView.tag] = webView.scrollView.contentSize.height
//            //Bhargav Hide
//            print("hight depend on hight..... \(webView.scrollView.contentSize.height)")
//            self.tblQuestion.endUpdates()
//
//                                            tblQuestion.reloadData()
////            tblQuestion.reloadRows(at: [(NSIndexPath(row: webView.tag, section: 0) as IndexPath)], with: .none)
//            WebviewReloadCount += 1
//
//            return
//        }
//        }
    }

    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
          print(error.localizedDescription)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        tableView.layer.removeAllAnimations()
        //        UITableView.setAnimationsEnabled(false)
        if strSelectedIndex == self.arrQueAns[self.strSectionSelectedIndex].arr_section_que.count - 1{
            if(strSectionSelectedIndex == arrQueAns.count - 1)
            {
                btnNext.isUserInteractionEnabled = false//
                btnNext.isHidden = true
                btnNext.setTitle("Finish", for: .normal)
            }
            else
            {
                //            strSectionSelectedIndex += 1
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                    self.btnNext.isUserInteractionEnabled = true//
                    self.btnNext.isHidden = false
//                }
                btnNext.setTitle("Next", for: .normal)
                //
            }
        }else{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                self.btnNext.isUserInteractionEnabled = true//
                self.btnNext.isHidden = false
//            }
            btnNext.setTitle("Next", for: .normal)
        }

        if indexPath.row == 0 {
//                        let cell:QuestionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
            let identifier = "QuestionTableViewCell"
            var cell: QuestionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionTableViewCell
            if cell == nil {
//                tableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
//                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? QuestionTableViewCell
            }
            self.lblPage.text = "\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_no) / \(strTotalQuetion)"
            self.lblSystemAnswer.text = "Correct answer : \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].str_SystemAnswer)"
            self.lblYourAnswer.text = "Your answer :      \(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].str_YourAnswer)"
            let TrueAns = "\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].isAnsTrue ?? "")"
            let temp_que_type1 =  "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_type)"
            var tmpMix = "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].str_marks)"
                tmpMix = tmpMix.replacingOccurrences(of: "Marks: ", with: "", options: NSString.CompareOptions.literal, range:nil)
            let fullNameArr = tmpMix.components(separatedBy: "/")
            let temp_obtain_Marks: String = fullNameArr[0]
            print(temp_obtain_Marks)

            let strobtain_marks = Double(temp_obtain_Marks) ?? 0

//            if strQueTypeid =
            if TrueAns == "True" || TrueAns == "true"
            {
                let imageName = "true-green-dot.png"
                imgYourAnsIcon.image = UIImage(named: imageName)
            }
            else if TrueAns == "False" || TrueAns == "false"
            {
                let imageName = "false-red-dot.png"
                imgYourAnsIcon.image = UIImage(named: imageName)
            }else
            {
//                let imageName = "green-dot.png"
                imgYourAnsIcon.image = nil//UIImage(named: imageName)
            }
            print("-------------> strobtain_marks : ",temp_que_type1,TrueAns,strobtain_marks)
            if temp_que_type1 == "7" &&  (TrueAns == "False" || TrueAns == "false") && strobtain_marks > 0
            {
                imgYourAnsIcon.image = nil
            }

            UIView.performWithoutAnimation {

//                cell.imgQueAns.sd_setShowActivityIndicatorView(true)
//                cell.imgQueAns.sd_setIndicatorStyle(.white)
                //            cell.loadingPlaceholderView.cover(cell.contentView)
                cell.imgQueAns.image = nil

                //                if strSelectedIndex > 0 {btnPrevious.isHidden = false}else{btnPrevious.isHidden = true}
                //                if strSelectedIndex == arrQueAns.count - 1 {btnNext.isHidden = true}else{btnNext.isHidden = false}
                //Bhargav Hide
////print("Que_____: " + self.self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].id)
                //Bhargav Hide
////print("https://content.testcraft.co.in/question/" + self.self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link)
                let url = URL.init(string: API.QueImg + (self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].img_link).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                DispatchQueue.main.asyncAfter(deadline: .now() + que_delay) {

                    cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
                        //                cell.loadingPlaceholderView.uncover()

                            if error != nil {
                                //Bhargav Hide
                                ////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                                //                self.image = placeholder
                                tableView.beginUpdates()
                                self.rowHeights[indexPath.row] = 50
                                tableView.endUpdates()
                                self.count_total_row = self.count_total_row + 1
                                self.view.makeToast("Error: Pull to refresh...", duration: 3.0, position: .bottom)

                                return
                            }
                            if self.count_total_row != self.self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count
                                //                        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count > 0
                            {
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
                                    print(self.rowHeights)
                                    self.count_total_row = self.count_total_row + 1
                                }
                        }
                    }
                }
            }
            return cell

        }
        else
        {
            //            let cell:AnswerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
            let strAnswear = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count - 1
            if indexPath.row == strAnswear
            {

                let identifier = "ExplanationTableViewCell"
                var cell: ExplanationTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? ExplanationTableViewCell
                if cell == nil {
//                    tableView.register(UINib(nibName: "ExplanationTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ExplanationTableViewCell
                }

//                let web = UIWebView(frame: CGRect(x: 2, y: cell.lblSubTitle.frame.origin.y + 10, width: cell.lblSubTitle.frame.size.width, height: 50)) // take note that right here, in the height:, I’ve changed 0.8 to 0.85 so it should look more consistent on the top and bottom
                //        let htmlString = "<html><body style='background-color:clear;'><br><p align=center><font size=30><b>" + "Hint" + "</b></font></p><hr><p><font size=10>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Hint)" + "</font></p><br><p align=center><font size=30  align=center><b>" + "Explanation" + "</b></font></p><hr><p><font size=18>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</font></p></body></html>"
//                let htmlString = content[indexPath.row]
//                let htmlHeight = rowHeights[indexPath.row]
                var DisplaySize = "14PX"
                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation == ""
                {
                    self.rowHeights[indexPath.row] = 0   // Explanation HIDE
                    cell.lblTitle.isHidden = true
                }else{
                    cell.lblTitle.isHidden = false
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        //Bhargav Hide
                        ////print("iPad")
                        self.rowHeights[indexPath.row] = tblQuestion.frame.height - 100
                        DisplaySize = "17PX"
                    }else{
                        //Bhargav Hide
                        ////print("not iPad")
                        self.rowHeights[indexPath.row] = tblQuestion.frame.height - 50
                        DisplaySize = "14PX"
                    }
                }
                let htmlString = "<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body style='background-color:clear;'><div style='color:#000000; font-family:Inter-Regular; FONT-SIZE :\(DisplaySize); LINE-HIGHT : 12PX; vertical-align: middle'>" + "\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)" + "</div></body></html>"
//                print("htmlString: ",htmlString)
//                print("\nGetting HTML: \(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_Explanation)")
                let baseurl = URL.init(string: API.imageUrl2.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

                cell.webViewIn.tag = indexPath.row
//                cell.webViewIn.delegate = self as! UIWebViewDelegate
                cell.webViewIn.loadHTMLString(htmlString, baseURL: baseurl)

//                cell.webViewIn.frame = CGRect(x: 0, y: 0, width: cell.webViewIn.frame.size.width, height: htmlHeight ?? 50)


////                var content : [String] = [htmlString]
////                var contentHeights : [CGFloat] = [0.0, 0.0]
//
////                cell.webViewIn.delegate = self as? UIWebViewDelegate
//                cell.webViewIn.loadHTMLString(htmlString, baseURL: nil)
////                cell.webViewIn.stringByEvaluatingJavaScript(from: htmlString)
//
//                        //        web.backgroundColor = UIColor.lightGray
//                        //        web.scrollView.backgroundColor = UIColor.lightGray
//                        //        let requestURL = NSURL(string: "http://www.google.it");
//                        //        let request = NSURLRequest(url: requestURL! as URL);
//                        //        web.loadRequest(request as URLRequest);
//                        cell.webViewIn.scalesPageToFit = true
//                        //        web.loadRequest(request as URLRequest)
//                        //        web.scrollView.bouncesZoom = false
//                        cell.webViewIn.scrollView.bounces = false
////                cell.webViewIn.scrollView.isScrollEnabled = false
//                let htmlHeight = rowHeights[indexPath.row]
//                cell.webViewIn.tag = indexPath.row
//                cell.webViewIn.delegate = self
////                let htmlString = rowHeights[indexPath.row]
//                cell.webViewIn.loadHTMLString(htmlString, baseURL: nil)
//
////                cell.webView.loadHTMLString(htmlString, baseURL: nil)
//                cell.webViewIn.frame = CGRect(x: 0, y: 0, width: cell.webViewIn.frame.size.width, height: htmlHeight ?? 0)//0, 0, cell.frame.size.width, htmlHeight ?? 0)
//
////                self.rowHeights[indexPath.row] = 150
//
//                        //        web.scrollView.
//                        //        let htmlString = "<p>Identify the arrow-marked structures in the images<img alt=\"\" src=\"https://dams-apps-production.s3.ap-south-1.amazonaws.com/course_file_meta/73857742.PNG\"></p>"
////                cell.view
////                        alert.view.addSubview(web)
////                        alert.addAction(cancel)
////                        self.present(alert, animated: false, completion: nil)

                return cell
            }
            let temp_que_type =  arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type

            if temp_que_type == "2" || temp_que_type == "8" //Fill in the blanks
            {
                let identifier = "TextFieldAnswerTableViewCell"
                var cell: TextFieldAnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TextFieldAnswerTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: "TextFieldAnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TextFieldAnswerTableViewCell
                }
                let imageName = "gray-circle.png"
                cell.bgView.isHidden = true
                cell.imgSelected.image = UIImage(named: imageName)
                let isCorrectAnswer = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].isCorrectAnswer
                let selected = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected
                //Bhargav Hide
////print("isCorrectAnswer__: \(isCorrectAnswer)       userSelected__: \(selected)")
                if  isCorrectAnswer == "1" && selected == "1"
                {
                    let imageName = "true-green-dot.png"
                    cell.bgView.isHidden = true
                    cell.imgSelected.image = UIImage(named: imageName)
                }
                else
                {
                    if selected == "1"
                    {
                        let imageName = "false-red-dot.png"//blue-dot.png"
                        cell.bgView.isHidden = true
                        cell.imgSelected.image = UIImage(named: imageName)
                    }
                    if isCorrectAnswer == "1"
                    {
                        let imageName = "true-green-dot.png"
                        cell.bgView.isHidden = true
                        cell.imgSelected.image = UIImage(named: imageName)
                    }
                }

                cell.txtWriteAns.tag = indexPath.row
                //                self.addDoneButtonOnKeyboard(txt: cell!.txtWriteAns)
                cell.txtWriteAns.addShadowWithRadius(2,2,1.1,color: GetColor.lightGray)
                var strAnswear = "\(self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].name)"
                if strAnswear == ""{
                    strAnswear = ""//" Enter your answer here..."
                    cell.txtWriteAns.textColor = UIColor.lightGray
                }
                else
                {
                    cell.txtWriteAns.textColor = UIColor.darkGray
                }
                cell.txtWriteAns.text = strAnswear

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
                }

                return cell
            }
            else if temp_que_type == "4"
            {
                let identifier = "AnswerTableViewCell"
                var cell: AnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                }

                cell.imgQueAns.image = nil
                cell.lblView.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].name
                cell.lblDisplayNo.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].display_no
                let imageName = "gray-circle.png"
                cell.bgView.isHidden = true
                cell.imgSelected.image = UIImage(named: imageName)

                //                //Bhargav Hide
////print("____________________________________", arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected, arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].isCorrectAnswer)
                //                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].isCorrectAnswer == "true" && arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected == "ture"
                //                {
                //                    let imageName = "true-green-dot.png"
                //                    cell.bgView.isHidden = true
                //                    cell.imgSelected.image = UIImage(named: imageName)
                //                }
                //                else
                //                {
                //                    let strSelected = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected
                //                    if strSelected == "true"
                //                    {
                //                        let imageName = "true-red-dot.png"
                //                        cell.bgView.isHidden = true
                //                        cell.imgSelected.image = UIImage(named: imageName)
                //                    }
                //                    else if strSelected == "false"
                //                    {
                //                        let imageName = "true-green-dot.png"
                //                        cell.bgView.isHidden = true
                //                        cell.imgSelected.image = UIImage(named: imageName)
                //                    }
                //                    if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].isCorrectAnswer == "true"
                //                    {
                //                        let imageName = "true-green-dot.png"
                //                        cell.bgView.isHidden = true
                //                        cell.imgSelected.image = UIImage(named: imageName)
                //                    }
                let isCorrectAnswer = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].isCorrectAnswer
                let selected = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected
                //Bhargav Hide
////print("isCorrectAnswer__: \(isCorrectAnswer)       userSelected__: \(selected)")

                if isCorrectAnswer == "1" && selected == "1"
                {
                    let imageName = "true-green-dot.png"
                    cell.bgView.isHidden = true
                    cell.imgSelected.image = UIImage(named: imageName)
                }
                else
                {
                    if selected == "1"
                    {
                        let imageName = "false-red-dot.png"//blue-dot.png"
                        cell.bgView.isHidden = true
                        cell.imgSelected.image = UIImage(named: imageName)
                    }
                    if isCorrectAnswer == "1"
                    {
                        let imageName = "true-green-dot.png"
                        cell.bgView.isHidden = true
                        cell.imgSelected.image = UIImage(named: imageName)
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + ans_delay) {
                    UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    self.rowHeights[indexPath.row] = 50

                        tableView.endUpdates()
                    }
                }

                //                    else
                //                    {
                //                    }
                //                }
                //                if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].selected == "1"
                //                {
                //                    let imageName = "checked.png"
                //                    cell.bgView.isHidden = true
                //                    cell.imgSelected.image = UIImage(named: imageName)
                //                }
                //                else
                //                {
                //                    let imageName = "unchecked.png"
                //                    cell.bgView.isHidden = true
                //                    cell.imgSelected.image = UIImage(named: imageName)
                //                }
                return cell
            }else
                //            {
                //                let identifier = "AnswerTableViewCell"
                //                var cell: AnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                //                if cell == nil {
                //                    tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                //                    cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                //                }
                //                UIView.performWithoutAnimation {
                //
                //                    cell.imgQueAns.sd_setShowActivityIndicatorView(true)
                //                    cell.imgQueAns.sd_setIndicatorStyle(.white)
                //                    cell.lblView.text = ""
                //                    //            if ((self.rowHeights[indexPath.row]) != nil)
                //                    //            {
                //                    //
                //                    //            }else{
                //                    cell.imgQueAns.image = nil
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                //                        //Bhargav Hide
////print("Ans_____: " + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].id)
                //                        //Bhargav Hide
////print("https://content.testcraft.co.in/question/" + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link)
                //                        let url = URL.init(string: "https://content.testcraft.co.in/question/" + (self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                //                        cell.imgQueAns.image = nil
                //                        //                        cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .continueInBackground){ (fetchedImage, error, cacheType, url) in
                //                        cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
                //                            if error != nil {
                //                                //Bhargav Hide
////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                //                                //                self.image = placeholder
                //                                //Bhargav Hide
////print("error_________________________________________________________________________\n",error)
                //                                tableView.beginUpdates()
                //                                self.rowHeights[indexPath.row] = 50
                //                                tableView.endUpdates()
                //                                self.count_total_row = self.count_total_row + 1
                //
                //                                return
                //                            }
                //                            if self.count_total_row != self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count
                //                            {
                //                                let aspectRatio = (cell.imgQueAns.image! as UIImage).size.height/(cell.imgQueAns.image! as UIImage).size.width
                //                                cell.imgQueAns.image = fetchedImage
                //                                let imageHeight = self.view.frame.width*aspectRatio
                //                                UIView.performWithoutAnimation {
                //                                    tableView.beginUpdates()
                //                                    self.rowHeights[indexPath.row] = imageHeight + 14
                //                                    tableView.endUpdates()
                //                                    //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
                //                                    //                    tableView.reloadRows(at: [indexPath1], with: .fade)
                //                                    self.count_total_row = self.count_total_row + 1
                //
                //                                }
                //                            }
                //                            //Bhargav Hide
////print(self.rowHeights)
                //                        }
                //                        //            }
                //                        cell.imgQueAns.addShadowWithRadius(0,15.0,0,color: UIColor.clear)
                //                        cell.bgView.addShadowWithRadius(13,5.0,1,color: UIColor.black)
                //                        if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_type == "1" //single selection
                //                        {
                //                            if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].selected == "1"
                //                            {
                //                                let imageName = "checked.png"
                //                                cell.bgView.isHidden = true
                //                                cell.imgSelected.image = UIImage(named: imageName)
                //                            }
                //                            else
                //                            {
                //                                let imageName = "unchecked.png"
                //                                cell.bgView.isHidden = true
                //                                cell.imgSelected.image = UIImage(named: imageName)
                //                            }
                //                        }
                //                        else //Multipul selection
                //                        {
                //                            if self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].selected == "1"
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
                //
                //                        }
                //                        //  cell.bgView.backgroundColor = GetColor.seaGreen
                //                        //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
                //                    }
                //                }
                //
                //                return cell
                //            }
                //        }
            {

                let identifier = "AnswerTableViewCell"
//                var cell:AnswerTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AnswerTableViewCell
                var cell: AnswerTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell
                if cell == nil {
                    tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
                    cell = (tableView.dequeueReusableCell(withIdentifier: identifier) as? AnswerTableViewCell)!
                }
                let imageName = "gray-circle.png"
                cell.bgView.isHidden = true
                cell.imgSelected.image = UIImage(named: imageName)
                cell.lblDisplayNo.text = self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].display_no
                let isCorrectAnswer = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].isCorrectAnswer
                let selected = arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected
                //Bhargav Hide
////print("isCorrectAnswer__: \(isCorrectAnswer)       userSelected__: \(selected)")

                if isCorrectAnswer == "true" && selected == "true"
                {
                    let imageName = "true-green-dot.png"
                    cell.bgView.isHidden = true
                    cell.imgSelected.image = UIImage(named: imageName)
                }
                else
                {
                    if selected == "true"
                    {
                        let imageName = "false-red-dot.png"//blue-dot.png"
                        cell.bgView.isHidden = true
                        cell.imgSelected.image = UIImage(named: imageName)
                    }
                    if isCorrectAnswer == "true"
                    {
                        let imageName = "true-green-dot.png"
                        cell.bgView.isHidden = true
                        cell.imgSelected.image = UIImage(named: imageName)
                    }
                    //                    else
                    //                    {
                    //                    }
                }
                cell.imgQueAns.image = nil

                UIView.performWithoutAnimation {

//                    cell.imgQueAns.sd_setShowActivityIndicatorView(true)
//                    cell.imgQueAns.sd_setIndicatorStyle(.gray)
                    cell.lblView.text = ""
                    //            if ((self.rowHeights[indexPath.row]) != nil)
                    //            {
                    //
                    //            }else{

                    DispatchQueue.main.asyncAfter(deadline: .now() + ans_delay) {
                        //Bhargav Hide
                        ////print("Ans_____: " + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].id)
                        //Bhargav Hide
                        ////print("https://content.testcraft.co.in/question/" + self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link)
                        let url = URL.init(string: API.QueImg + (self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans[indexPath.row].img_link).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                        cell.imgQueAns.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
                            if error != nil {
                                //Bhargav Hide
                                ////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                                //                self.image = placeholder
                                //Bhargav Hide
                                ////print("error_______________________________________________________________\n",error!)
                                tableView.beginUpdates()
                                self.rowHeights[indexPath.row] = 50
                                tableView.endUpdates()
                                self.count_total_row = self.count_total_row + 1
                                self.view.makeToast("Error: Pull to refresh...", duration: 3.0, position: .bottom)
                                return
                            }
                            if self.count_total_row != self.arrQueAns[self.strSectionSelectedIndex].arr_section_que[self.strSelectedIndex].que_ans.count
                            {
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
                                    self.count_total_row = self.count_total_row + 1
                                }
                            }
                            //Bhargav Hide
                            ////print(self.rowHeights)
                        }
                    }
                    //                }
                    cell.imgQueAns.addShadowWithRadius(0,15.0,0,color: UIColor.clear)
                    cell.bgView.addShadowWithRadius(13,5.0,1,color: UIColor.black)
                    //  cell.bgView.backgroundColor = GetColor.seaGreen
                    //  cell.bgView.layer.addBorder(edge: UIRectEdge.all, color: UIColor.black, thickness: 0.0)
                }
                return cell

            }

        }
        //        cell.displayData(arrViewLessonPlanData[indexPath.section])
        //        rbgA

        //        //Bhargav Hide
////print("bhargav_profil_url_name_______",API.hostName,arrQueAns[self.strSectionSelectedIndex].arr_section_que[indexPath.section].AnsImgLink as Any)

        //        cell.imgQueAns.setImageWithFadeFromURL(url: URL.init(string: "https://content.testcraft.co.in/question/" + (arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].AnsDetail[indexPath.row].AnsImgLink).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!, placeholderImage: Constants.studentPlaceholder, animationDuration: 0, finish: {
        //            let aspectRatio = (cell.imgQueAns.image! as UIImage).size.height/(cell.imgQueAns.image! as UIImage).size.width
        ////            cell.articleImage.image = image
        //            let imageHeight = self.view.frame.width*aspectRatio
        //            tableView.beginUpdates()
        //            self.rowHeights[indexPath.row] = imageHeight
        //            tableView.endUpdates()
        //
        //        })

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //        //        UIView.performWithoutAnimation {
        //        //            tblQuestion.beginUpdates()
        //        UIView.setAnimationsEnabled(false)
        //        self.tblQuestion.beginUpdates()
        //        if indexPath.row == 0 {
        //        }
        //        else
        //        {
        //            if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_type == "1"
        //            {
        //                //                            var i = 0
        //                var oldvalue = 0//arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected
        //                for var i in (0..<arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans.count)
        //                {
        //                    if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected == "1"
        //                    {
        //                        arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[i].selected = "0"
        //                        let indexPath1 = IndexPath(item: i, section: 0)
        //                        tblQuestion.reloadRows(at: [indexPath1], with: .none)
        //                        oldvalue = i
        //                    }
        //                    i += 1
        //                }
        //                //                            tblQuestion.reloadData()
        //                if oldvalue == indexPath.row//oldvalue == "1" && arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected == "1" //arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row + 1].selected == "1"
        //                {
        //                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "0"
        //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
        //                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
        //                }
        //                else
        //                {
        //                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "1"
        //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
        //                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
        //                }
        //
        //                //  self.tblQuestion.layer.removeAllAnimations()
        //                //  tblQuestion.reloadData()
        //            }
        //            else if strQueType == "2"
        //            {
        //                if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected == "1"
        //                {
        //                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "0"
        //                    //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
        //                    //                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
        //                }
        //                else
        //                {
        //                    arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].que_ans[indexPath.row].selected = "1"
        //                    //                    let indexPath1 = IndexPath(item: indexPath.row, section: 0)
        //                    //                    tblQuestion.reloadRows(at: [indexPath1], with: .none)
        //                }
        //            }
        //        }
        //        //            tblQuestion.endUpdates()
        //        //        }
        //
        //        self.tblQuestion.endUpdates()
        //
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView)
//        print(scrollView.tag)
//        print(scrollView.subviews[0].tag)
        if scrollView == tblQuestion{
            let currentY = tblQuestion.contentOffset.y
            let currentBottomY = scrollView.frame.size.height + currentY
//            print("currentY",currentY)
//            print("currentBottomY",currentBottomY)
            //            if currentY == 0.0 {
            //
            //            }else
            if currentY < 5 {
                //"scrolling down"
                tblQuestion.bounces = true
            } else {
                //"scrolling up"
                //             Check that we are not in bottom bounce
//                if currentBottomY < scrollView.contentSize.height + scrollView.contentInset.bottom {
                    tblQuestion.bounces = false
//                }
            }
        }else
        {
             print("scrollView: ",scrollView)
        }
        //        lastContentOffset = scrollView.contentOffset.y
    }

}

