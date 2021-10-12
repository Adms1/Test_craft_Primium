//
//  CreateTestVC.swift
//  TestCraft
//
//  Created by ADMS on 16/06/20.
//  Copyright © 2020 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import DropDown
import TagListView

class CreateTestVC: UIViewController, UITextFieldDelegate, ActivityIndicatorPresenter,TagListViewDelegate {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblTestName:UILabel!
//    @IBOutlet var lblQueType:UILabel!
    @IBOutlet var lblQueCount:UILabel!
    @IBOutlet var lblDuration:UILabel!
    @IBOutlet var lblChapter:UILabel!
    @IBOutlet var lblPopupChapter:UILabel!
//    @IBOutlet var lblDifficulty:UILabel!
//    @IBOutlet var lblRemarks:UILabel!

    @IBOutlet var popupvViewChapter:UIView!
    @IBOutlet var lblTemplete:UILabel!

    @IBOutlet var txtTestName:UITextField!
    @IBOutlet var txtQueCount:UITextField!
    @IBOutlet var txtDuration:UITextField!
//    @IBOutlet var txtRemarks:UITextField!

    @IBOutlet var btnChapter:UIButton!
    @IBOutlet var btnCreateTest:UIButton!
    @IBOutlet var btnChapterSelect:UIButton!
    @IBOutlet var btnChapterClose:UIButton!
    @IBOutlet var btnSelectAll:UIButton!
    @IBOutlet var imgSelectAll:UIImageView!
//    @IBOutlet var btnAddQue:UIButton!
//    @IBOutlet var btnDifficulty:UIButton!
    @IBOutlet var btnTemplete:UIButton!
    @IBOutlet var imgTemplete:UIImageView!

    @IBOutlet var collectionView:UICollectionView!
    @IBOutlet var scrlView: UIScrollView!
    @IBOutlet var TagHeight:NSLayoutConstraint!

    var arrChapter = [SubCategory1ListModal]()
    @IBOutlet weak var tagListView_QueCount: TagListView!

    var strTitle = ""
    var strtempBoardID = ""
    var strtempSubjectID = ""
    var strIsCompetitive = ""
    var strtempStandardID = ""
    var strtempStandardName = ""
    var intTotalQue : Double = 150
    var MaxQueTime = 180
    var chSelected = ""
//    var strTempSelected = ""

//    var arrDifficultys = [""]
    var arrQueType = [""]
        var arrTemplete = [SubCategory1ListModal]()

    //    @IBOutlet var scrlView: UIScrollView!

//    let DifficultysDropDown = DropDown()
//    let QueTypeDropDown = DropDown()
        let TempleteDropDown = DropDown()

    lazy var dropDowns: [DropDown] = {
        return [
//            self.DifficultysDropDown,
//            self.QueTypeDropDown
        self.TempleteDropDown
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTitle.text = "Create Test (\(strTitle))"
        if strIsCompetitive == "1"
        {
            lblChapter.text = "Subject"
            lblPopupChapter.text = "Subject"
            Get_Chapters_ListApi()
            Get_Template_ListApi()
            //            lblChapter.isHidden = true
//            btnChapter.isHidden = true
            TagHeight.constant = 95
        }
        else
        {
            Get_Chapters_ListApi()
            lblChapter.text = "Chapter"
            lblPopupChapter.text = "Chapter"
            lblTemplete.isHidden = true
            btnTemplete.isHidden = true
            imgTemplete.isHidden = true
            TagHeight.constant = 15

        }
//
//        self.arrChapter.append(TempModel)
//        self.arrChapter.append(TempModel1)
//        self.arrChapter.append(TempModel2)

        lblQueCount.text = "Total Questions"
        lblDuration.text = "Duration (minutes)"
        lblTemplete.text = "Templete"
//        lblQueType.text = "Question Type"
//        btnQueType.setTitle("Select Question Type", for: .normal)
        btnTemplete.setTitle("Select Templete", for: .normal)
        chSelected = "0"
        btnChapter.addShadowWithRadius(0,btnChapter.frame.width/9,0,color: UIColor.white)
        btnCreateTest.addShadowWithRadius(0,btnCreateTest.frame.width/9,0,color: UIColor.white)
//        btnChapterSelect.addShadowWithRadius(0,btnChapterSelect.frame.width/9,0,color: UIColor.white)
//        btnChapterClose.addShadowWithRadius(0,btnChapterClose.frame.width/9,0,color: UIColor.white)

        btnChapterSelect.layer.cornerRadius = btnChapterSelect.layer.frame.height/2
        btnChapterSelect.layer.masksToBounds = true

        btnChapterClose.layer.cornerRadius = btnChapterSelect.layer.frame.height/2
        btnChapterClose.layer.masksToBounds = true

//        btnAddQue.addShadowWithRadius(0,9,0,color: UIColor.white)

        self.txtTestName.delegate = self
        self.txtQueCount.delegate = self
        self.txtDuration.delegate = self
//        self.txtRemarks.delegate = self
        txtTestName.attributedPlaceholder = NSAttributedString(string: "Test Name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtQueCount.attributedPlaceholder = NSAttributedString(string: "Total Question",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtDuration.attributedPlaceholder = NSAttributedString(string: "Duration",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
//        txtRemarks.attributedPlaceholder = NSAttributedString(string: "Enter Remark",
//        attributes: [NSAttributedString.Key.foregroundColor: GetColor.lightGray])

        //        txtTestName.layer.borderColor = GetColor.themeBlueColor.cgColor
        //        txtTestName.layer.borderWidth = 1.0
        txtTestName.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)
        txtQueCount.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)
        txtDuration.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)
//        txtRemarks.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)
//        btnQueType.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)
//        btnDifficulty.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)
        btnTemplete.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)

        self.addDoneButtonOnKeyboard(txt: txtTestName)
        self.addDoneButtonOnKeyboard(txt: txtQueCount)
        self.addDoneButtonOnKeyboard(txt: txtDuration)
//        self.addDoneButtonOnKeyboard(txt: txtRemarks)

        //        btnChapter.backgroundColor = GetColor.themeBlueColor
        btnCreateTest.backgroundColor = GetColor.themeBlueColor
        btnChapterSelect.backgroundColor = GetColor.themeBlueColor
        btnChapterClose.backgroundColor = GetColor.darkGray
        popupvViewChapter.isHidden = true

        tagListView_QueCount.delegate = self
//        tagListView_QueCount.textFont = .systemFont(ofSize: 14)
//        tagListView_QueCount.shadowRadius = 2
//        tagListView_QueCount.shadowOpacity = 0.4
//        tagListView_QueCount.shadowColor = GetColor.blackColor//UIColor.black
//        tagListView_QueCount.shadowOffset = CGSize(width: 1, height: 1)
//        tagListView_QueCount.addTag("On tap will be removed").onTap = { [weak self] tagView in
//            self?.tagListView_QueCount.removeTagView(tagView)
//        }
        tagListView_QueCount.borderColor = GetColor.themeBlueColor
        tagListView_QueCount.borderWidth = 1
        tagListView_QueCount.cornerRadius = 7
        tagListView_QueCount.backgroundColor = GetColor.whiteColor
        tagListView_QueCount.enableRemoveButton = false
        tagListView_QueCount.removeIconLineColor = GetColor.blueHeaderText
        tagListView_QueCount.selectedTextColor = GetColor.darkGray//removeAllTags()
        tagListView_QueCount.removeIconLineWidth = 1
        tagListView_QueCount.removeButtonIconSize = 6
//        tagListView.removeIconLineColor = UIColor.white.withAlphaComponent(1)

//        tagListView_QueCount.alignment = .center
//        arrDifficultys = ["Hard","Midium","Easy"]
//
//        arrQueType = ["MCQ","Fill In The Blank","Match The Following","True and False","Descriptive","Comprehension","MCQ 2","Integer Type"]
//        arrTemplete = ["Hard","Midium","Easy"]
//                let TempModel:SubCategory1ListModal = SubCategory1ListModal.init(id: "", title: "GUJ", subTitle: "", image: "", selected: "0")
//                let TempModel1:SubCategory1ListModal = SubCategory1ListModal.init(id: "", title: "Eng", subTitle: "", image: "", selected: "0")
//                let TempModel2:SubCategory1ListModal = SubCategory1ListModal.init(id: "", title: "Hindi", subTitle: "", image: "", selected: "0")
//
//                self.arrTemplete.append(TempModel)
//                self.arrTemplete.append(TempModel1)
//                self.arrTemplete.append(TempModel2)
//        setupQueListDropDown()
//        setupDifficultysListDropDown()
//                setupTempleteListDropDown()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        // Keyboard Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func BackClicked(_ sender: AnyObject) {
        //        SJSwiftSideMenuController.toggleLeftSideMenu()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func CreateTestClicked(_ sender: AnyObject) {
        if validated() == true
        {
            //            apiSignUp()
//            Insert_StudentSubscription_API()
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "4301", comment: "Create test button", isFirstTime: "0")

            CreateTest()
        }
    }
    @IBAction func ChapterSelectAllClicked(_ sender: AnyObject) {
        selection()
//        if chSelected == "0"
//        {
//            for i in 0..arrChapter.count{
//                arrChapter[indexPath.item].selected = "1"
//            }
//            chSelected = "1"
//            let image : UIImage = UIImage(named:"true-sign-icon-white_NEW")!
//            imgSelectAll.image = image
//            imgSelectAll.backgroundColor = GetColor.themeBlueColor
//            imgSelectAll.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
//
//        }else{
//            for i in 0..arrChapter.count{
//                arrChapter[indexPath.item].selected = "0"
//            }
//            chSelected = "0"
//            imgSelectAll.tintColor = UIColor.lightGray
//            imgSelectAll.image = nil//image//UIImageView(image: <#T##UIImage?#>)
//            imgSelectAll.backgroundColor = UIColor.white
//            imgSelectAll.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
//
//        }
    }
func selection()
{
    if chSelected == "1"
    {
        for i in 0..<arrChapter.count{
            self.arrChapter[i].selected = "1"
        }
        chSelected = "0"
    }else{
        for i in 0..<arrChapter.count{
            self.arrChapter[i].selected = "0"
        }
        chSelected = "1"
    }
    collectionView.reloadData()
}

    @IBAction func AddChapterClicked(_ sender: AnyObject) {
        popupvViewChapter.isHidden = false
        collectionView.reloadData()
        self.view.endEditing(true)
    }
    @IBAction func ChapterSelectClicked(_ sender: AnyObject) {
        popupvViewChapter.isHidden = true
        self.view.endEditing(true)
        tagListView_QueCount.removeAllTags()
        for value in arrChapter
        {
            if value.selected == "1"
            {
                tagListView_QueCount.addTag("\(value.title ?? "")").onTap = { [weak self] tagView in
                //            self?.tagListView_QueCount.removeTagView(tagView)
                        }
            }

        }
        if tagListView_QueCount.tagViews.count != 0
        {
            BoardLimit()
        }


    }
    @IBAction func ChapterCloseClicked(_ sender: AnyObject) {
        popupvViewChapter.isHidden = true
//        tagListView_QueCount.removeAllTags()
//        for value in arrChapter
//        {
//            if value.selected == "1"
//            {
//                tagListView_QueCount.addTag("\(value.title ?? "")").onTap = { [weak self] tagView in
//                //            self?.tagListView_QueCount.removeTagView(tagView)
//                        }
//            }
//
//        }
//        if tagListView_QueCount.tagViews.count != 0
//        {
//            BoardLimit()
//        }
    }

//    @IBAction func AddQueTypeClicked(_ sender: AnyObject) {
//        QueTypeDropDown.show()
//    }
//    @IBAction func AddQueClicked(_ sender: AnyObject) {
//        self.view.endEditing(true)
//        if btnQueType.titleLabel?.text == "Select Question Type" && txtQueCount.text == ""
//        {
//            self.view.makeToast("Select Quetion Type", duration: 3.0, position: .bottom)
//
//        }else{
//        tagListView_QueCount.addTag("\(btnQueType.titleLabel?.text ?? "") - \(txtQueCount.text ?? "")").onTap = { [weak self] tagView in
////            self?.tagListView_QueCount.removeTagView(tagView)
//        }
//        btnQueType.setTitle("Select Question Type", for: .normal)
//        txtQueCount.text = ""
//        }
//    }

//    @IBAction func DifficultysClicked(_ sender: AnyObject) {
//        DifficultysDropDown.show()
//    }
    @IBAction func TempleteClicked(_ sender: AnyObject) {
        TempleteDropDown.show()
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
        //            let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        //            self.scrlView.contentInset = contentInset
        view.endEditing(true)
        //        self.view.endEditing(true)
        //                if validated() == true
        //                {
        //                    apiSignUp()
        //                }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
        case self.txtTestName:
            self.txtDuration.becomeFirstResponder()
            break
        case self.txtDuration:
            self.txtQueCount.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true

        if txtQueCount == textField {
            if textField.text?.count == 0 && string == "0" {

                return false
            }

            if (string).count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                if textField.text!.count > 5
                {
                    result = false
                }
                else
                {
                    result = replacementStringIsLegal
                }
            }
        }
        if txtDuration == textField {
            if textField.text?.count == 0 && string == "0" {

                return false
            }

            if (string).count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                if textField.text!.count > 3
                {
                    result = false
                }
                else
                {
                    result = replacementStringIsLegal
                }
            }
        }

        return result
    }

    func validated() -> Bool {
        var valid: Bool = true
        if txtTestName.text == ""{
            txtTestName.attributedPlaceholder = NSAttributedString(string: "Enter Test Name",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: GetColor.red])
            valid = false
        }
        //        if tagListView_QueCount.tagViews.count == 0 {
        if txtQueCount.text == ""{
            txtQueCount.attributedPlaceholder = NSAttributedString(string: "Enter Total Question",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: GetColor.red])
            //            self.view.makeToast("Add Question Type", duration: 3.0, position: .bottom)

            valid = false
        }
        if txtDuration.text == ""{
            txtDuration.attributedPlaceholder = NSAttributedString(string: "Enter Duration",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: GetColor.red])
            valid = false
        }
        if strIsCompetitive == "1"
        {
            if btnTemplete.titleLabel?.text == "Select Templete" {
                self.view.makeToast("Please Select Templete", duration: 3.0, position: .bottom)
                valid = false
            }
        }else
        {
            if tagListView_QueCount.tagViews.count == 0 {
                self.view.makeToast("Please Add Chapter", duration: 3.0, position: .bottom)
                valid = false
            }else
            {

            }
        }
        //        if txtRemarks.text == ""{
        //            txtRemarks.attributedPlaceholder = NSAttributedString(string: "Enter Remoarks",
        //                                                                   attributes: [NSAttributedString.Key.foregroundColor: GetColor.red])
        //            valid = false
        //        }
        if txtQueCount.text == "" || txtDuration.text == "" || tagListView_QueCount.tagViews.count == 0 {
            valid = false
        }
        else //if tagListView_QueCount.tagViews.count > 0
        {
           let totalDisplay = String(format: "%.0f", self.intTotalQue)
            if Double(txtQueCount.text ?? "0") ?? 0.0 > self.intTotalQue && Int(txtDuration.text ?? "0") ?? 0 > self.MaxQueTime
            {
                self.view.makeToast("Please reduce question count less than \(totalDisplay)\nand reduce test duration less than \(self.MaxQueTime)", duration: 5.0, position: .center)
                valid = false
            }
            else if Double(txtQueCount.text ?? "0") ?? 0.0 > self.intTotalQue || Double(txtQueCount.text ?? "0") ?? 0.0 == 0
            {
                self.view.makeToast("Please reduce question count less than \(totalDisplay)", duration: 5.0, position: .center)
                valid = false //Please reduce questions count //Enter max que count
            }
            else if Int(txtDuration.text ?? "0") ?? 0 > self.MaxQueTime || Int(txtDuration.text ?? "0") ?? 0 == 0
            {
                self.view.makeToast("Please reduce test duration less than \(self.MaxQueTime) ", duration: 5.0, position: .center)
                valid = false
            }
        }
        return valid
    }

    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }

    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrlView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 70
        scrlView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification)
    {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrlView.contentInset = contentInset
    }
}
extension CreateTestVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
//        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
////        heightConstraint.constant = height
//        print(height)
        return CGSize(width: collectionView.frame.size.width, height: 55);
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrChapter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell

        cell.displayData("Main","\(arrChapter[indexPath.row].title ?? "") (\(arrChapter[indexPath.row].subTitle ?? ""))")
//        var strSelectedImg = ""
//        cell.imgIcon.addShadowWithRadius(0,cell.imgIcon.frame.width/2,0,color: UIColor.white)
        cell.bgView.backgroundColor = UIColor.clear//GetColor.whiteColor
        cell.lblTitle.textColor = GetColor.blackColor

        if arrChapter[indexPath.row].selected == "1"
        {
            let image : UIImage = UIImage(named:"true-sign-icon-white_NEW")!
            cell.imgIcon.image = image
            cell.imgIcon.backgroundColor = GetColor.themeBlueColor
            cell.imgIcon.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
//            let image : UIImage = UIImage(named:"selected_box.png")!
//            cell.imgIcon.image = image

////            cell.imgIcon.backgroundColor = GetColor.themeBlueColor
////            cell.imgIcon.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
//
////            strSelectedImg = "white-dot.png"
////
////                        let image : UIImage = UIImage(named:"true-sign-icon-blue")!
////                        cell.imgIcon.image = image
////                        cell.imgIcon.tintColor = UIColor.lightGray
//////                        userHeader.imgDerctionIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
        }
        else
        {

//            let image : UIImage = UIImage(named:"true-sign-icon-black")!
            cell.imgIcon.tintColor = UIColor.lightGray
            cell.imgIcon.image = nil//image//UIImageView(image: <#T##UIImage?#>)
            cell.imgIcon.backgroundColor = UIColor.white
            cell.imgIcon.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)

////            cell.bgView.backgroundColor = UIColor.clear
////            cell.lblTitle.textColor = UIColor(rgb: 0x838283)
//            let image : UIImage = UIImage(named:"select_box.png")!
//            cell.imgIcon.tintColor = UIColor.lightGray
//            cell.imgIcon.image = image//UIImageView(image: <#T##UIImage?#>)
////            cell.imgIcon.backgroundColor = UIColor.white
////            //                self.DashButton.imageView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
////            cell.imgIcon.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
//
////            strSelectedImg = "blue-dot.png"
////
////                        let image : UIImage = UIImage(named:"true-sign-icon-blue")!
////                        cell.imgIcon.image = image//UIImageView(image: <#T##UIImage?#>)
////            //                self.DashButton.imageView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);

        }

        if chSelected == "0"
        {
        let image : UIImage = UIImage(named:"true-sign-icon-white_NEW")!
        imgSelectAll.image = image
        imgSelectAll.backgroundColor = GetColor.themeBlueColor
        imgSelectAll.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
            print("Selected   1")
        }else
        {
            imgSelectAll.tintColor = UIColor.lightGray
            imgSelectAll.image = nil//image//UIImageView(image: <#T##UIImage?#>)
            imgSelectAll.backgroundColor = UIColor.white
            imgSelectAll.addShadowWithRadius(2,3,1.1,color: UIColor.lightGray)
            print("Not Selected")

        }

//        cell.imgIcon.image = UIImage(named: "")

        //["Boards", "Standard", "Subjects", "Price", "Tutors"]...["Course", "Subjects", "Price", "Tutors"]
//        if strtempCategoryID == "1"
//        {
//            if arrFilterTitle[indexPath.row] == "Boards" && temp_strCategoryID1 != ""{cell.imgIcon.image = UIImage(named: strSelectedImg)}
//        }else
//        {
//            if arrFilterTitle[indexPath.row] == "Course" && temp_strCategoryID1 != ""{cell.imgIcon.image = UIImage(named: strSelectedImg)}
//        }
//        if arrFilterTitle[indexPath.row] == "Standard" && temp_strCategoryID2 != ""{cell.imgIcon.image = UIImage(named: strSelectedImg)}
//        if arrFilterTitle[indexPath.row] == "Subjects" && temp_strCategoryID3 != ""{cell.imgIcon.image = UIImage(named: strSelectedImg)}
//        if arrFilterTitle[indexPath.row] == "Price" && (temp_curMinPrice != MinPrice || temp_curMaxPrice != MaxPrice){cell.imgIcon.image = UIImage(named: strSelectedImg)}
//        if arrFilterTitle[indexPath.row] == "Tutors" && temp_strTutorsId != ""{cell.imgIcon.image = UIImage(named: strSelectedImg)}

        //        if strtempCategoryID == "1" //Exam
        //        {
        //            //                if(arrData0.count>0){strCategoryID1 = arrData0.joined(separator:",")}//Board
        //            if(arrData0.count>0){strCategoryID1 = arrData0.joined(separator:",")}else{strCategoryID1 = ""}//Board
        //            if(arrData1.count>0){strCategoryID2 = arrData1.joined(separator:",")}else{strCategoryID2 = ""}//Standard
        //            if(arrData2.count>0){strCategoryID3 = arrData2.joined(separator:",")}else{strCategoryID3 = ""}//Subject
        //            if(arrDataTitle0.count>0){strCategoryTitle1 = arrDataTitle0.joined(separator:", ")}else{strCategoryTitle1 = ""}//Board
        //            if(arrDataTitle1.count>0){strCategoryTitle2 = arrDataTitle1.joined(separator:", ")}else{strCategoryTitle2 = ""}//Standard
        //            if(arrDataTitle2.count>0){strCategoryTitle3 = arrDataTitle2.joined(separator:", ")}else{strCategoryTitle3 = ""}//Subject
        //        }
        //        else
        //        {
        //            if(arrData0.count>0){strCategoryID1 = arrData0.joined(separator:",")}else{strCategoryID1 = ""}//Exam
        //            strCategoryID2 = ""//Standard
        //            if(arrData2.count>0){strCategoryID3 = arrData2.joined(separator:",")}else{strCategoryID3 = ""}//Subject
        //            if(arrDataTitle0.count>0){strCategoryTitle1 = arrDataTitle0.joined(separator:", ")}else{strCategoryTitle1 = ""}//Board
        //            strCategoryTitle2 = ""//Standard
        //            if(arrDataTitle2.count>0){strCategoryTitle3 = arrDataTitle2.joined(separator:", ")}else{strCategoryTitle3 = ""}//Subject
        //        }

        //        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(expandCollapseSection(_:)))
        //        cell.contentView.tag = indexPath.section
        //        cell.contentView.addGestureRecognizer(tapGesture)


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if arrChapter[indexPath.item].selected == "0"
        {
            arrChapter[indexPath.item].selected = "1"
        }
        else
        {
            arrChapter[indexPath.item].selected = "0"
        }
        var strTempSelected = ""
        for i in 0..<arrChapter.count{
            if arrChapter[i].selected == "0"
            {
                strTempSelected = "0"
            }
        }
        if strTempSelected == "" {
            self.chSelected = "0"
        }else{
            self.chSelected = "1"
        }

//        selectedIndex = indexPath.item
//        criteria_update()
//        if arrFilterTitle[indexPath.row] == "Price"
//        {
//            tblDashbord.isHidden = true
//            SliderView.isHidden = false
//        }
//        else
//        {
//            tblDashbord.isHidden = false
//            SliderView.isHidden = true
//            var type_exam = "Course"
//            if strtempCategoryID == "1"
//            {
//                type_exam = "Board"
//            }
//            if arrFilterTitle[selectedIndex] == "Course Type" {
//                //                Get_CourseType_ListApi()
//                //                if strtempCategoryID == "1"
//                //                {
//                //                    strtempCategoryID = "2"
//                //                    arrFilterTitle = ["Boards", "Standard", "Subjects", "Price", "Tutors"]
//                //                }
//                //                else
//                //                {
//                //                    strtempCategoryID = "1"
//                //                    arrFilterTitle = ["Course", "Subjects", "Price", "Tutors"]
//                //                }
//
//            }
//            else if arrFilterTitle[selectedIndex] == "Boards" {
//                //                Get_Course_ListApi(strCourseTypeId: "1")
//                tblDashbord.reloadData()
//            }
//            else if arrFilterTitle[selectedIndex] == "Course" {
//                //                Get_Course_ListApi(strCourseTypeId: "2")
//                tblDashbord.reloadData()
//            }
//            else if arrFilterTitle[selectedIndex] == "Standard" {
//                arrStandardFilter.removeAll()
//                //                var arrData1 = [String]()
//                //                var arrDataTitle1 = [String]()
//                //                if (arrStandardFilter.count > 1)
//                //                {for value in arrStandardFilter{if value.selected == "1" { arrData1.append(value.id ?? "")
//                //                    arrDataTitle1.append(value.title ?? "")}}}
//                ////                var temp_strCategoryID2 = ""
//                //                if(arrData1.count>0){temp_strCategoryID2 = arrData1.joined(separator:",")}else{temp_strCategoryID2 = ""}//Standard
//                if temp_strCategoryID1 == ""
//                {self.view.makeToast("Please Select Board", duration: 3.0, position: .bottom)}
//                else{ Get_Std_ListApi(strStd: "1", BoardID: temp_strCategoryID1)}
//            }
//            else if arrFilterTitle[selectedIndex] == "Subjects" {
//                arrSubjectFilter.removeAll()
//                if temp_strCategoryID1 == ""
//                {self.view.makeToast("Please Select \(type_exam)", duration: 3.0, position: .bottom)}
//                else if temp_strCategoryID2 == ""
//                {self.view.makeToast("Please Select Standard", duration: 3.0, position: .bottom)}
//                else
//                {
//
//                    Get_Sub_ListApi(strSub: "2", BoardID: temp_strCategoryID1, StandardID: temp_strCategoryID2)
//                }
//            }
//            else if arrFilterTitle[selectedIndex] == "Tutors"
//            {
//                arrTutorFilter.removeAll()
//
//                if temp_strCategoryID1 == ""
//                {self.view.makeToast("Please Select \(type_exam)", duration: 3.0, position: .bottom)}
//                else //if temp_strCategoryID2 == ""
//                    //                {self.view.makeToast("Please Select Standard", duration: 3.0, position: .bottom)}
//                    //                else
//                {
//                    apiGet_Tutor_ListApi(Board_Course_ID: temp_strCategoryID1, StandardID: temp_strCategoryID2, SubjectID: temp_strCategoryID3)
//                }
//            }
//
//        }
//        tblDashbord.reloadData()
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {


        //        let animation = CABasicAnimation(keyPath: "cornerRadius")
        //        animation.fromValue = cell.frame.size.width
        //        cell.layer.cornerRadius = 0
        //        animation.toValue = 0
        //        animation.duration = 1
        //        cell.layer.add(animation, forKey: animation.keyPath)

    }

}

extension CreateTestVC
{
    //        func setupQueListDropDown() {
    //            QueTypeDropDown.anchorView = btnQueType
    //
    //            // By default, the dropdown will have its origin on the top left corner of its anchor view
    //            // So it will come over the anchor view and hide it completely
    //            // If you want to have the dropdown underneath your anchor view, you can do this:
    //            QueTypeDropDown.bottomOffset = CGPoint(x: 0, y: btnQueType.bounds.height)
    //
    //            // You can also use localizationKeysDataSource instead. Check the docs.
    //            QueTypeDropDown.dataSource = arrQueType
    //
    //            // Action triggered on selection
    //            QueTypeDropDown.selectionAction = { [weak self] (index, item) in
    //                self?.btnQueType.setTitle(item, for: .normal)
    ////                self?.btnQueType.text = item
    ////                self?.GetCity(strState:item)
    //            }
    //        }
    //            func setupDifficultysListDropDown() {
    //                DifficultysDropDown.anchorView = btnDifficulty
    //
    //                // By default, the dropdown will have its origin on the top left corner of its anchor view
    //                // So it will come over the anchor view and hide it completely
    //                // If you want to have the dropdown underneath your anchor view, you can do this:
    //                DifficultysDropDown.bottomOffset = CGPoint(x: 0, y: btnDifficulty.bounds.height)
    //
    //                // You can also use localizationKeysDataSource instead. Check the docs.
    //                DifficultysDropDown.dataSource = arrDifficultys
    //
    //                // Action triggered on selection
    //                DifficultysDropDown.selectionAction = { [weak self] (index, item) in
    //                    self?.btnDifficulty.setTitle(item, for: .normal)
    ////                    self?.btnDifficulty.text = item
    //    //                self?.GetCity(strState:item)
    //                }
    //            }
    func setupTempleteListDropDown() {
        TempleteDropDown.anchorView = btnTemplete

        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        TempleteDropDown.bottomOffset = CGPoint(x: 0, y: btnTemplete.bounds.height)
        var tempArray = [""]
        tempArray.removeAll()
        for value in arrTemplete{
            tempArray.append("\(value.title ?? "")")// = ["\(value.title ?? "")"]
        }
        // You can also use localizationKeysDataSource instead. Check the docs.
        TempleteDropDown.dataSource = tempArray//["\(arrTemplete[0].title ?? "")"]

        // Action triggered on selection
        TempleteDropDown.selectionAction = { [weak self] (index, item) in
            let temp_title = "\(self!.arrTemplete[index].title ?? "")"
            self?.btnTemplete.setTitle(temp_title, for: .normal)
            //                    self?.btnDifficulty.text = item
            //                self?.GetCity(strState:item)
        }
    }
    func Get_Chapters_ListApi()
    {
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //        var strSet_Title = ""
        var api = ""
        showActivityIndicator()
        if strIsCompetitive == "1"
        {
            api = API.Get_Get_Course_Subject_ListApi
            params = ["CourseID":strtempSubjectID]
        }
        else
        {
            api = API.Get_ChapterListApi
            params = ["BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]
        }
        //Get_ChapterList(string BoardID, string StandardID, string SubjectID)

        arrChapter.removeAll()

        //Bhargav Hide
        print("API, Params: \n",api,params)
        self.collectionView.reloadData()
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.collectionView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            self.chSelected = "0"
            self.selection()

            switch response.result {
            case .success(let value):
                //                self.arrHeaderSubTitle.removeAll()
                let json = JSON(value)
                //Bhargav Hide
                print("d",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    //                    var arrChild = [YourPreferencesModal]()

                    for value in arrData! {

                        let ChildModel:SubCategory1ListModal = SubCategory1ListModal.init(id: value["ID"].stringValue, title: value["Name"].stringValue, subTitle: "\(value["Count"].stringValue)", image: "\(API.imageUrl)\(value["Icon"].stringValue)", selected: "0")

                        self.arrChapter.append(ChildModel)
                    }
                    //                    self.Get_Sub_ListApi(strSub: "2")

                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                    //                    self.collectionView.reloadData()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print(error)
            }
            self.collectionView.reloadData()
        }
    }
    func CreateTest()
    {
        var params = ["":""]

        let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        ////print(result)
        if strIsCompetitive == "1"
        {
            //            api = API.Create_SelfTest_Competitive_Api
            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":strtempSubjectID,"BoardID":"0","StandardID":"0","TypeID":"2"]
        }
        else
        {
            //            api = API.Create_SelfTest_Bord_Api
            var tempArray = [""]
            tempArray.removeAll()
            for value in arrChapter{
                if value.selected == "1"{
                    tempArray.append("\(value.id ?? "")")
                }
            }
            let stringArray2 = tempArray.map { String($0) }
            let strChapter = stringArray2.joined(separator: ",")

            params = ["UserID":"\(result.value(forKey: "StudentID") ?? "")",
                      "CourseID":"0", "BoardID":"\(strtempBoardID)",
                      "StandardID":"\(strtempStandardID)",
                      "TypeID":"1",
                      "SubjectID":"\(strtempSubjectID)",
                      "TestName":"\(txtTestName.text ?? "")",
                      "desc": "",
                      "Hint": "",
                      "Duration":"\(txtDuration.text ?? "")",
                      "DifficultyLevelIDs":"1,2,3,4",
                      "ChapterID":"\(strChapter)",
                      "QueCount":"\(txtQueCount.text ?? "")"]
        }
        Insert_StudentSubscription_API(params: params)
    }
    func Insert_StudentSubscription_API(params:[String:String])
    {
        showActivityIndicator()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = API.Create_SelfTest_Bord_Api
        if strIsCompetitive == "1"
        {
            api = API.Create_SelfTest_Competitive_Api
        }
        else
        {
            api = API.Create_SelfTest_Bord_Api
        }
        //
        //Bhargav Hide
        print("API, Params: \n",api,params)
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.collectionView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    let alert = UIAlertController(title: "Test create sucessfully", message: "", preferredStyle: UIAlertController.Style.alert)
                    let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(action1)
                    //                            alert.addAction(actionContinue)
                    self.present(alert, animated: true, completion: {
                        //Bhargav Hide
                        ////print("completion block")
                    })


                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print(error)
            }
        }
    }

    func BoardLimit()
    {
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var api = ""//API.Get_SelfTest_QueLimit_Board_Api
        //            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
        //Bhargav Hide
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.collectionView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        //Bhargav Hide
        ////print(result)
        if strIsCompetitive == "1"
        {
            //                api = API.Create_SelfTest_Competitive_Api
            //                params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":strtempSubjectID]
        }
        else
        {
            api = API.Get_SelfTest_QueLimit_Board_Api
            var tempArray = [""]
            tempArray.removeAll()
            for value in arrChapter{
                if value.selected == "1"{
                    tempArray.append("\(value.id ?? "")")
                }
            }
            let stringArray2 = tempArray.map { String($0) }
            let strChapter = stringArray2.joined(separator: ",")
            params = ["BoardID":"\(strtempBoardID)","StandardID":"\(strtempStandardID)","SubjectID":"\(strtempSubjectID)","ChapterID":"\(strChapter)"]
        }
        print("API, Params: \n",api,params)
        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].doubleValue
                    self.intTotalQue = Double(arrData)
                    self.MaxQueTime = 180
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }

            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print(error)
            }
        }
    }

    func Get_Template_ListApi()
    {
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //        var strSet_Title = ""
        var api = ""
        showActivityIndicator()
        if strIsCompetitive == "1"
        {
            api = API.Get_Course_SectionTemplateApi
            params = ["CourseID":strtempSubjectID]
        }
        else
        {
            //                        api = API.Get_ChapterListApi
            //                        params = ["BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]
        }
        //Get_ChapterList(string BoardID, string StandardID, string SubjectID)

        arrChapter.removeAll()

        //Bhargav Hide
        print("API, Params: \n",api,params)
        self.collectionView.reloadData()
        if !Connectivity.isConnectedToInternet() {
            self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.collectionView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request(api, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):
                //                self.arrHeaderSubTitle.removeAll()
                let json = JSON(value)
                //Bhargav Hide
                print("d",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    //                    var arrChild = [YourPreferencesModal]()

                    for value in arrData! {

                        let ChildModel:SubCategory1ListModal = SubCategory1ListModal.init(id: value["QuestionTypeID"].stringValue, title: value["Sectionname"].stringValue, subTitle: "", image: "\(API.imageUrl)\(value["Icon"].stringValue)", selected: "0")

                        self.arrTemplete.append(ChildModel)
                    }
                    //                    self.Get_Sub_ListApi(strSub: "2")
                    if self.arrTemplete.count > 0{
                        self.setupTempleteListDropDown()
                        self.btnCreateTest.isHidden = false
                    }else{
                        let alert = UIAlertController(title: "No Template found...", message: "", preferredStyle: UIAlertController.Style.alert)
                        let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                            //                                self.navigationController?.popViewController(animated: true)
                        }
                        alert.addAction(action1)
                        //                            alert.addAction(actionContinue)
                        self.present(alert, animated: true, completion: {
                        })
                        self.btnCreateTest.isHidden = true

                    }
                    //                        if arrData?.count == 0 {
                    //                            let alert = UIAlertController(title: "No Template found...", message: "", preferredStyle: UIAlertController.Style.alert)
                    //                            let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
                    ////                                self.navigationController?.popViewController(animated: true)
                    //                            }
                    //                            alert.addAction(action1)
                    //                            //                            alert.addAction(actionContinue)
                    //                            self.present(alert, animated: true, completion: {
                    //                            })
                    //                        }
                }
                else
                {
                    //                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                    //                    self.collectionView.reloadData()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print(error)
            }
        }
    }
}
