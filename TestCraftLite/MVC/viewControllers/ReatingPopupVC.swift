//
//  ReatingPopupVC.swift
//  TestCraft
//
//  Created by ADMS on 15/02/21.
//  Copyright © 2021 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage
import Cosmos

class ReatingPopupVC: UIViewController, ActivityIndicatorPresenter, UITextViewDelegate {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var viewPopupWriteReview: UIView!
    @IBOutlet var subViewPopupWriteReview: UIView!
    @IBOutlet var lblPopupWriteReviewTitle: UILabel!
    @IBOutlet var lblPopupWriteReviewSubTitle: UILabel!
    @IBOutlet var viewAddRateStar:CosmosView!
    @IBOutlet var btnSubmitReview:UIButton!
    @IBOutlet var txtWriteReview:UITextView!
    @IBOutlet var btnCloseReview:UIButton!
    @IBOutlet var imgSmilyReview: UIImageView!
    @IBOutlet var SliderReview: UISlider!
    @IBOutlet var lblLeftSlider: UILabel!
    @IBOutlet var lblRightSlider: UILabel!

    @IBOutlet var txtviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var subviewPopupMidConstraint: NSLayoutConstraint!
    var strReviewText = ""
    var strReviewStar = ""

    var strTestID = ""
    var strStudentTestID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true

        lblPopupWriteReviewTitle.text = "Do you like the app?"
        lblPopupWriteReviewSubTitle.text = "Use the slider to tell it in the language of Emojis."
        lblLeftSlider.text = "Not really"
        lblRightSlider.text = "Love it"
        self.btnCloseReview.setTitle("Dismiss", for: .normal)
        self.btnSubmitReview.setTitle("Next", for: .normal)
        lblLeftSlider.textColor = GetColor.lightGray
        lblRightSlider.textColor = GetColor.darkGray
        lblPopupWriteReviewTitle.backgroundColor = UIColor.clear//GetColor.ColorGrayF5F5F5
//        self.btnCloseReview.addShadowWithRadius(0,self.btnCloseReview.frame.width/6,0,color: GetColor.themeBlueColor)
        self.btnCloseReview.backgroundColor = UIColor.lightGray
//        self.btnSubmitReview.addShadowWithRadius(0,self.btnSubmitReview.frame.width/6,0,color: GetColor.themeBlueColor)
        self.btnSubmitReview.backgroundColor = GetColor.themeBlueColor


        SliderReview.minimumValue = 1
        SliderReview.maximumValue = 5
        SliderReview.value = 3
        imgSmilyReview.image = UIImage(named: "3.png")
        strReviewStar = "3"
        txtviewHeightConstraint.constant = 0
        txtWriteReview.tag = 101//indexPath.row
        txtWriteReview.text = ""
        txtWriteReview.delegate = self
        self.addDoneButtonOnKeyboard(txt: txtWriteReview)
        self.addDoneButtonOnKeyboard(txt: txtWriteReview)
        txtWriteReview.addShadowWithRadius(2,2,1.1,color: GetColor.lightGray)


        viewAddRateStar.rating = 0 // Change the cosmos view rating
        viewAddRateStar.settings.updateOnTouch = true            // Use if you need just to show the stars without getting user's input
        //            cell.viewRateStar.settings.fillMode = .full // Show only fully filled stars
        //            // Other fill modes: .half, .precise

        viewAddRateStar.settings.starSize = 25            // Change the size of the stars
        viewAddRateStar.settings.starMargin = 1            // Set the distance between stars
        viewAddRateStar.settings.filledColor = GetColor.yellow          // Set the color of a filled star
        viewAddRateStar.settings.filledBorderColor = GetColor.yellow
        viewAddRateStar.settings.emptyBorderColor = GetColor.lightGray
        viewAddRateStar.settings.emptyColor = GetColor.lightGray
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        viewAddRateStar.didFinishTouchingCosmos = { rating in print("didFinishTouchingCosmos__: ",self.viewAddRateStar.rating)}

        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        viewAddRateStar.didTouchCosmos = { rating in print("didTouchCosmos__: ",self.viewAddRateStar.rating)}
        viewAddRateStar.isHidden = true
        //        txtWriteReview.tag = 101//indexPath.row
        //        txtWriteReview.text = ""
        //        txtWriteReview.delegate = self
        subViewPopupWriteReview.addShadowWithRadius(7,16.0,0,color: UIColor.darkGray)


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
    }

    @IBAction func sliderValueChanged(sender: UISlider)
    {
        let currentValue = Int(sender.value)
        print("Slider changing to \(currentValue)")
        strReviewStar = "\(currentValue)"
//        DispatchQueue.main.async {
            self.imgSmilyReview.image = UIImage(named: "\(currentValue).png")

//            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(ac, animated: true)
//        }

//        dispatch_async(dispatchMain(){
////            SliderReview.text = "\(currentValue) Km"
//        }, <#() -> Void#>)
    }

    @IBAction func SubmitReviewClicked(_ sender: AnyObject) {
//        view.endEditing(true)
        if self.btnSubmitReview.titleLabel?.text == "Next"
        {
            self.btnSubmitReview.setTitle("Submit", for: .normal)

            txtviewHeightConstraint.constant = 50

            var strAnswear = strReviewText //"\(arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].str_ans)"
            if strAnswear == ""{
                strAnswear = " Let us know why"//Let us know why
                txtWriteReview.textColor = UIColor.lightGray
            }
            else
            {
                txtWriteReview.textColor = UIColor.darkGray
            }
            txtWriteReview.text = strAnswear
        }else{

//            strReviewText
        AddReview(strTotalStar: "\(strReviewStar)", strReviewText: "\(strReviewText)")
        }
    }
    @IBAction func closeWriteReviewClicked(_ sender: AnyObject) {
        view.endEditing(true)
//        viewPopupWriteReview.isHidden = true
//        self.tabBarController?.tabBar.isHidden = false
        let presentingVC = self.presentingViewController
        self.dismiss(animated: false, completion: {
            // // //Bhargav Hide
            print("completion block")
//            self.tabBarController?.tabBar.isHidden = false
              presentingVC?.tabBarController?.tabBar.isHidden = false
            //  presentingVC?.tabBarController!.selectedIndex = 0
        })
    }

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
//        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
//            //        self.scrlView.contentInset = contentInset
        view.endEditing(true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        subviewPopupMidConstraint.constant = 0

        if textView.text.isEmpty {
            textView.text = " Let us know why"
            textView.textColor = UIColor.lightGray
            strReviewText = ""
        }
        else
        {
            strReviewText = textView.text
            //Bhargav Hide
////print("strReviewText_:",strReviewText)
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        subviewPopupMidConstraint.constant = -80

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
            strReviewText = ""
        //            textView.textColor = UIColor.lightGray
        }
        else
        {
            strReviewText = textView.text
            //Bhargav Hide
////print("strReviewText_:",strReviewText)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func AddReview(strTotalStar:String, strReviewText:String) {
        //        function body
        //Bhargav Hide

        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "4400", comment: "smiley rating submit button", isFirstTime: "0")

        showActivityIndicator()

        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","Rating": strTotalStar, "Remark":strReviewText]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Insert_AppRatingApi,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(API.Insert_AppRatingApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1")
                {
//                    self.viewPopupWriteReview.isHidden = true
//                    self.apiReviewList()

                    self.view?.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)
                    
//                    let alert = AlertController(title: "", message: "\(json["Msg"])", preferredStyle: .alert)
//                    // Add actions
//                    //                    let action = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                    //        action.actionImage = UIImage(named: "No")
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
////                        self.viewPopupWriteReview.isHidden = true
                        self.tabBarController?.tabBar.isHidden = false
                        let presentingVC = self.presentingViewController

                        self.dismiss(animated: false, completion: {

                            //Bhargav Hide
                            print("completion block")
                //            self.tabBarController?.tabBar.isHidden = false
                            presentingVC?.view.makeToast("\(json["Msg"])", duration: 3.0, position: .bottom)

                              presentingVC?.tabBarController?.tabBar.isHidden = false
                            //  presentingVC?.tabBarController!.selectedIndex = 0
                        })
////                        for controller in self.navigationController!.viewControllers as Array {
////                            //Bhargav Hide
////                            //print(controller)
////                            if controller.isKind(of: DashboardVC.self) {
////                                //                            self
////                                controller.tabBarController!.selectedIndex = 0
////                                //                                controller.tabBarController?.tabBarItem
////                                self.navigationController!.popToViewController(controller, animated: false)
////                                break
////                            }
////                        }
//
//                    }))
//                    //                    alert.addAction(action)
//                    self.present(alert, animated: true, completion: nil)


                    //                    let jsonArray = json["data"][0].dictionaryObject!

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
