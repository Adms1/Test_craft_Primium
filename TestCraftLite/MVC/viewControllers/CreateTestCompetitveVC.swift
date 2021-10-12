//
//  CreateTestCompetitveVC.swift
//  TestCraft
//
//  Created by ADMS on 23/06/20.
//  Copyright © 2020 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import DropDown
import TagListView

class CreateTestCompetitveVC: UIViewController , UITextFieldDelegate, ActivityIndicatorPresenter,TagListViewDelegate {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    @IBOutlet var tblTampleteList:UITableView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblTestName:UILabel!
//    @IBOutlet var lblQueType:UILabel!
    @IBOutlet var lblQueCount:UILabel!
    @IBOutlet var lblDuration:UILabel!
    @IBOutlet var lblChapter:UILabel!
    @IBOutlet var lblPopupChapter:UILabel!
    @IBOutlet var lblTemplateDetail:UILabel!
//    @IBOutlet var lblDifficulty:UILabel!
//    @IBOutlet var lblRemarks:UILabel!

    @IBOutlet var popupvViewChapter:UIView!
    @IBOutlet var viewTemplateDetail:UIView!
    @IBOutlet var lblTemplete:UILabel!

    @IBOutlet var txtTestName:UITextField!
    @IBOutlet var txtQueCount:UITextField!
    @IBOutlet var txtDuration:UITextField!
//    @IBOutlet var txtRemarks:UITextField!

    @IBOutlet var btnChapter:UIButton!
    @IBOutlet var btnCreateTest:UIButton!
    @IBOutlet var btnChapterSelect:UIButton!
    @IBOutlet var btnChapterClose:UIButton!
//    @IBOutlet var btnQueType:UIButton!
//    @IBOutlet var btnAddQue:UIButton!
//    @IBOutlet var btnDifficulty:UIButton!
    @IBOutlet var btnTemplete:UIButton!
    @IBOutlet var imgTemplete:UIImageView!

    @IBOutlet var collectionView:UICollectionView!
    @IBOutlet var scrlView: UIScrollView!
    @IBOutlet var TagHeight:NSLayoutConstraint!

    var arrChapter = [SubCategory1ListModal]()
    @IBOutlet weak var tagListView_QueCount: TagListView!
    @IBOutlet var tblTampleteHeight:NSLayoutConstraint!

    var strTitle = ""
    var strtempBoardID = ""
    var strtempSubjectID = ""
    var strIsCompetitive = ""
    var strtempStandardID = ""
    var strtempStandardName = ""
    var intTotalQue : Double = 9000
    var MaxQueTime = 180
    var TemplateID = ""
//    var arrDifficultys = [""]
    var arrQueType = [""]
        var arrTemplete = [SectionTemplateListModal]()
    var arrTempleteDetail = [SectionTemplateListModal]()

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
//            Get_Chapters_ListApi()
            lblChapter.isHidden = true
            btnChapter.isHidden = true
            lblQueCount.isHidden = true
            txtQueCount.isHidden = true
            btnChapter.isHidden = true
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
        self.tblTampleteList.isHidden = true

        lblQueCount.text = "Total Question"
        lblDuration.text = "Duration (minutes)"
        lblTemplete.text = "Templete"
//        lblQueType.text = "Question Type"
//        btnQueType.setTitle("Select Question Type", for: .normal)
        btnTemplete.setTitle("Select Templete", for: .normal)
        lblTemplateDetail.text = ""
        lblTemplateDetail.textColor = UIColor.lightGray
        viewTemplateDetail.addShadowWithRadius(0,3,1,color: GetColor.green)
        viewTemplateDetail.isHidden = true
        lblTemplateDetail.isHidden = true

        btnChapter.addShadowWithRadius(0,btnChapter.frame.width/9,0,color: UIColor.white)
        btnCreateTest.addShadowWithRadius(0,btnCreateTest.frame.width/9,0,color: UIColor.white)
        btnChapterSelect.addShadowWithRadius(0,btnChapterSelect.frame.width/9,0,color: UIColor.white)
        btnChapterClose.addShadowWithRadius(0,btnChapterClose.frame.width/9,0,color: UIColor.white)
//        btnAddQue.addShadowWithRadius(0,9,0,color: UIColor.white)

        self.txtTestName.delegate = self
        self.txtQueCount.delegate = self
        self.txtDuration.delegate = self
//        self.txtRemarks.delegate = self
        txtTestName.attributedPlaceholder = NSAttributedString(string: "Enter Test Name",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtQueCount.attributedPlaceholder = NSAttributedString(string: "Enter Total Question",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        txtDuration.attributedPlaceholder = NSAttributedString(string: "Enter Duration",
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
        tblTampleteList.addShadowWithRadius(0,5,1,color: GetColor.themeBlueColor)

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
            api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "4301", comment: "Create test button", isFirstTime: "0")

            //            apiSignUp()
//            Insert_StudentSubscription_API()
            CreateTest()
        }
    }
    @IBAction func AddChapterClicked(_ sender: AnyObject) {
        popupvViewChapter.isHidden = false
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
//            BoardLimit()
        }


    }
    @IBAction func ChapterCloseClicked(_ sender: AnyObject) {
        popupvViewChapter.isHidden = true
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
//            BoardLimit()
        }
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
        self.view.endEditing(true)
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
//        case self.txtDuration:
//            self.txtQueCount.becomeFirstResponder()
//            break
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
//        if txtQueCount.text == ""{
//            txtQueCount.attributedPlaceholder = NSAttributedString(string: "Enter Total Question",
//                                                                   attributes: [NSAttributedString.Key.foregroundColor: GetColor.red])
//            //            self.view.makeToast("Add Question Type", duration: 3.0, position: .bottom)
//
//            valid = false
//        }
        if txtDuration.text == ""{
            txtDuration.attributedPlaceholder = NSAttributedString(string: "Enter Duration",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: GetColor.red])
            valid = false
        }
        if strIsCompetitive == "1"
        {
//            if btnTemplete.titleLabel?.text == "Select Templete" && tagListView_QueCount.tagViews.count == 0
//            {
//                self.view.makeToast("Please Select Templete\nPlease Add Subject", duration: 3.0, position: .bottom)
//                valid = false
//            }else{
            if btnTemplete.titleLabel?.text == "Select Templete" {
                self.view.makeToast("Please Select Templete", duration: 3.0, position: .bottom)
                valid = false
            }
//            if tagListView_QueCount.tagViews.count == 0 {
//                self.view.makeToast("Please Add Subject", duration: 3.0, position: .bottom)
//                valid = false
//            }
//            }
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
        if txtDuration.text == ""// || txtQueCount.text == "" //|| tagListView_QueCount.tagViews.count == 0
        {
            valid = false
        }
        else //if tagListView_QueCount.tagViews.count > 0
        {
//            if Double(txtQueCount.text ?? "0") ?? 0.0 >= self.intTotalQue // && Int(txtDuration.text ?? "0") ?? 0 >= self.MaxQueTime
//            {
//                self.view.makeToast("Enter max que count \(self.intTotalQue)\nEnter max test duration \(self.MaxQueTime)", duration: 5.0, position: .center)
//                valid = false
//            }
//            else if Double(txtQueCount.text ?? "0") ?? 0.0 >= self.intTotalQue
//            {
//                self.view.makeToast("Enter max que count \(self.intTotalQue)", duration: 5.0, position: .center)
//                valid = false
//            }
//            else
            if Int(txtDuration.text ?? "0") ?? 0 > self.MaxQueTime || Int(txtDuration.text ?? "0") ?? 0 == 0
            {
                self.view.makeToast("Enter max test duration \(self.MaxQueTime) ", duration: 5.0, position: .center)
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
extension CreateTestCompetitveVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width, height: 50);
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrChapter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let result = arrChapter[indexPath.row].title?.filter { "\t".range(of: String($0)) == nil } ?? ""
        let trimmedString = result.trimmingCharacters(in: .whitespacesAndNewlines)


//            String(arrChapter[indexPath.row].title?.filter {![" ", "\t", "\n"].contains($0)} ?? "")

        cell.displayData("Main",trimmedString)
//        var strSelectedImg = ""
//        cell.imgIcon.addShadowWithRadius(0,cell.imgIcon.frame.width/2,0,color: UIColor.white)
        cell.bgView.backgroundColor = UIColor.clear//GetColor.whiteColor
        cell.lblTitle.textColor = GetColor.blackColor
        cell.lblTitle.textAlignment = .left
        cell.lblTitle.sizeToFit()

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

extension CreateTestCompetitveVC
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
//        let appearance = DropDown.appearance()
//        DropDown.setupDefaultAppearance()
//        DropDown.appearance().width = 200
//        TempleteDropDown.cell
//

        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        TempleteDropDown.bottomOffset = CGPoint(x: 0, y: btnTemplete.bounds.height)
        var tempArray = [""]
        tempArray.removeAll()
        for value in arrTemplete{
            tempArray.append("\(value.Sectionname ?? "")")// = ["\(value.title ?? "")"]
        }
        // You can also use localizationKeysDataSource instead. Check the docs.
        TempleteDropDown.dataSource = tempArray//["\(arrTemplete[0].title ?? "")"]
//        TempleteDropDown.
//        if #available(iOS 11.0, *) {
//                appearance.setupMaskedCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
//            }

//            dropDowns.forEach {
                /*** FOR CUSTOM CELLS ***/
//                $0.cellNib = UINib(nibName: "MyCell", bundle: nil)

//                $0.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//                    guard let cell = cell as? MyCell else { return }
//
//                    // Setup your custom UI components
//                    cell.logoImageView.image = UIImage(named: "logo_\(index % 10)")
//                }
                /*** ---------------- ***/
//            }
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 13)
        DropDown.appearance().cellHeight = 50
//        DropDown.appearance().height = .auto
//        DropDown.appearance().optionLabel.numberOfLines = 0
//        DropDown.appearance().?.lineRange(for: 2)
        // Action triggered on selection
//        TempleteDropDown.updateConstraints()// = true
                dropDowns.forEach {
                    $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
        //            $0.largeContentTitle.text
        //            $0.customCellConfiguration = nil
                    $0.customCellConfiguration = { (index: Int, item: String, cell: DropDownCell) -> Void in
                        cell.optionLabel.textAlignment = .left
                            cell.optionLabel.numberOfLines = 2
//                        cell.optionLabel
//                            cell.optionLabel.lineBreakMode = .byWordWrapping
                        }

                }

        TempleteDropDown.selectionAction = { [weak self] (index, item) in
            let temp_title = "\(self!.arrTemplete[index].Sectionname ?? "")"
            self?.btnTemplete.setTitle(temp_title, for: .normal)
            self?.TemplateID = "\(self!.arrTemplete[index].SubjectID ?? "")"
            //  self?.btnDifficulty.text = item
            //  self?.GetCity(strState:item)
            self!.Get_Template_List_DetailApi(strTemplateID: "\(self!.arrTemplete[index].SubjectID ?? "")")
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineSpacing = 5
//
//            let attrString = NSMutableAttributedString(string: "Physics Section 1. MCQ 20x2\nPhysics Section 2. MCQ 15x1")
//            attrString.addAttribute(.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
//
//            self?.lblTemplateDetail.attributedText = attrString//.text = "Physics Section 1. MCQ 20x2\nPhysics Section 2. MCQ 15x1"//"\(temp_title)"
//            if temp_title == ""
//            {
                self?.viewTemplateDetail.isHidden = true
            self?.lblTemplateDetail.isHidden = true
//            }else
//            {
//                self?.viewTemplateDetail.isHidden = false
//            }
//            self?.tagListView_QueCount.removeAllTags()
//            self?.tagListView_QueCount.addTag("\(temp_title)").onTap = { [weak self] tagView in
//            }
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

            switch response.result {
            case .success(let value):
                //                self.arrHeaderSubTitle.removeAll()
                let json = JSON(value)
                //Bhargav Hide
               // print("d",json)

                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    //                    var arrChild = [YourPreferencesModal]()

                    for value in arrData! {

//                        let result = value["Name"].stringValue.filter { "\t".range(of: String($0)) == nil }
//                        let trimmedString = result.trimmingCharacters(in: .whitespacesAndNewlines)
//                        print("trimmedString",trimmedString)
                        let ChildModel:SubCategory1ListModal = SubCategory1ListModal.init(id: value["ID"].stringValue, title: value["Name"].stringValue, subTitle: "", image: "\(API.imageUrl)\(value["Icon"].stringValue)", selected: "0")
//                        print(self.arrChapter[index].title!)
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
//            params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")","CourseID":strtempSubjectID,"BoardID":"0","StandardID":"0","TypeID":"2"]

//            Create_SelfTest_CE(string UserID, string CourseID, string BoardID, string StandardID, string SubjectID, string TypeID, string TestName, string desc, string Hint, string Duration, string DifficultyLevelIDs, string TopicID, string QueCount,string TemplateID)

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
                "CourseID":"\(strtempSubjectID)", "BoardID":"0",
                "StandardID":"0",
                "TypeID":"2",
                "SubjectID":"0",
                "TestName":"\(txtTestName.text ?? "")",
                "desc": "",
                "Hint": "",
                "Duration":"\(txtDuration.text ?? "")",
                "DifficultyLevelIDs":"1,2,3,4",
                "TopicID":"\(strChapter)",
//                "QueCount":"\(txtQueCount.text ?? "")",
                "TemplateID":"\(self.TemplateID)"]


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
            //            self.tblTampleteList.isHidden = true
            //            self.tblTampleteHeight.constant = 10

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

                            let result = value["Name"].stringValue.filter { "\t".range(of: String($0)) == nil }
                            let trimmedString = result.trimmingCharacters(in: .whitespacesAndNewlines)
                            print("trimmedString",trimmedString)


                            let ChildModel:SectionTemplateListModal = SectionTemplateListModal.init(SubjectID: value["ID"].stringValue,SubjectName: value["ID"].stringValue, Sectionname: trimmedString, QuestionTypeID: value["QuestionTypeID"].stringValue, QuestionTypeName: value["QuestionTypeName"].stringValue, NoOfQue: value["NoOfQue"].stringValue, Marks: value["Marks"].stringValue, NegativeMarks: value["NegativeMarks"].stringValue, SectionInstruction: value["SectionInstruction"].stringValue, TotalMarks: "")

                            //                            let ChildModel:SectionTemplateListModal = SectionTemplateListModal.init(SubjectID: value["SubjectID"].stringValue, Sectionname: value["Sectionname"].stringValue, QuestionTypeID: value["QuestionTypeID"].stringValue, QuestionTypeName: value["QuestionTypeName"].stringValue, NoOfQue: value["NoOfQue"].stringValue, Marks: value["Marks"].stringValue, NegativeMarks: value["NegativeMarks"].stringValue, SectionInstruction: value["SectionInstruction"].stringValue)

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
                    }
                    else
                    {
                        //  self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                        //  self.collectionView.reloadData()
                    }
                case .failure(let error):
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                    print(error)
                }
                //                self.tblTampleteList.reloadData()
                //                self.tblTampleteHeight.constant = self.tblTampleteList.contentSize.height - CGFloat(self.arrTemplete.count * 4)

                //                self.tblTampleteList.isHidden = true
                //                self.tblTampleteHeight.constant = 10
            }
    }
    func Get_Template_List_DetailApi(strTemplateID:String)
    {
        //     self.tblTampleteList.isHidden = true
//        self.tblTampleteHeight.constant = 10
        self.tblTampleteList.isHidden = true

        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //        var strSet_Title = ""
        var api = ""
        showActivityIndicator()
        if strIsCompetitive == "1"
        {
            api = API.Get_Template_DetailApi
            params = ["TemplateID":strTemplateID]
        }
        else
        {
            //                        api = API.Get_ChapterListApi
            //                        params = ["BoardID":strtempBoardID, "StandardID":strtempStandardID, "SubjectID":strtempSubjectID]
        }
        //Get_ChapterList(string BoardID, string StandardID, string SubjectID)

        arrTempleteDetail.removeAll()

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
                    var FullTotal = 0.00
                    for value in arrData! {
                        let Marks = Double(value["Marks"].stringValue) ?? 0.00
                        let NoOfQue = Double(value["NoOfQue"].stringValue) ?? 0.00
                        let total = NoOfQue * Marks
                        FullTotal = FullTotal + total

                        let ChildModel:SectionTemplateListModal = SectionTemplateListModal.init(SubjectID: value["ID"].stringValue, SubjectName: value["SubjectName"].stringValue, Sectionname: value["Sectionname"].stringValue, QuestionTypeID: value["QuestionTypeID"].stringValue, QuestionTypeName: value["QuestionTypeName"].stringValue, NoOfQue: value["NoOfQue"].stringValue, Marks: value["Marks"].stringValue, NegativeMarks: value["NegativeMarks"].stringValue, SectionInstruction: value["SectionInstruction"].stringValue, TotalMarks: "\(total)")

                        //                            let ChildModel:SectionTemplateListModal = SectionTemplateListModal.init(SubjectID: value["SubjectID"].stringValue, Sectionname: value["Sectionname"].stringValue, QuestionTypeID: value["QuestionTypeID"].stringValue, QuestionTypeName: value["QuestionTypeName"].stringValue, NoOfQue: value["NoOfQue"].stringValue, Marks: value["Marks"].stringValue, NegativeMarks: value["NegativeMarks"].stringValue, SectionInstruction: value["SectionInstruction"].stringValue)

                        self.arrTempleteDetail.append(ChildModel)
                    }
                    let ChildModel:SectionTemplateListModal = SectionTemplateListModal.init(SubjectID: "", SubjectName: "", Sectionname: "Total", QuestionTypeID: "", QuestionTypeName: "", NoOfQue: "", Marks: "", NegativeMarks: "", SectionInstruction: "", TotalMarks: "\(FullTotal)")
                    self.arrTempleteDetail.append(ChildModel)

                    //                    self.Get_Sub_ListApi(strSub: "2")
                    if self.arrTempleteDetail.count > 0{
                        self.tblTampleteList.reloadData()
                        self.tblTampleteList.isHidden = false
                    }
//                    else
//                    {
//                    }
                }
                else
                {
                    //  self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                    //  self.collectionView.reloadData()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                print(error)
            }
            self.tblTampleteList.reloadData()
            self.tblTampleteHeight.constant = 50 + CGFloat(self.arrTempleteDetail.count * 50) //self.tblTampleteList.contentSize.height - CGFloat(self.arrTempleteDetail.count * 5)

            //                    self.tblTampleteList.isHidden = true
            //                    self.tblTampleteHeight.constant = 10
        }
    }


}

extension CreateTestCompetitveVC: UITableViewDataSource, UITableViewDelegate
{
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50//UITableView.automaticDimension

        }


//            func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//                let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
//                viewHeader.backgroundColor = UIColor.darkGray // Changing the header background color to gray
//                return viewHeader
//            }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
            {
                let headerView:TamplateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TamplateTableViewCell") as! TamplateTableViewCell //as! SwAnalysisTableViewCell
                headerView.topbgView1.backgroundColor = GetColor.blueHeaderText
                headerView.lblSectionname.text = "Section"//"\(arrTemplete[indexPath.row].Sectionname ?? "")"
                headerView.lblQuestionTypeName.text = "Q.Type" //"\(arrTemplete[indexPath.row].QuestionTypeName ?? "")"
                headerView.lblNoOfQue.text = "No."// "\(arrTemplete[indexPath.row].NoOfQue ?? "")"
                headerView.lblMarks.text = "Marks"// "\(arrTemplete[indexPath.row].Marks ?? "")"
                headerView.lblTotalMarks.text = "Total"// "\(arrTemplete[indexPath.row].Marks ?? "")"

                headerView.lblSectionname.textColor = GetColor.whiteColor
                headerView.lblQuestionTypeName.textColor = GetColor.whiteColor
                headerView.lblNoOfQue.textColor = GetColor.whiteColor
                headerView.lblSectionname.textColor = GetColor.whiteColor
                headerView.lblMarks.textColor = GetColor.whiteColor
                headerView.lblTotalMarks.textColor = GetColor.whiteColor

//                headerView.lblTitle.text = "\(arrStudentTestSWAnalysis[section].title ?? "")"
//                headerView.imgIcon.isHidden = true
//
//                if headerView.lblTitle.text == "Weakness"
//                {
//                    headerView.topbgView1.backgroundColor = GetColor.tomatoRed
//                    headerView.bottomBorderView.backgroundColor = GetColor.tomatoRed
//                }else
//                {
//                    headerView.topbgView1.backgroundColor = GetColor.darkGreen
//                    headerView.bottomBorderView.backgroundColor = GetColor.darkGreen
//                }
//                headerView.topbgView1.addShadowWithRadius(0,8,0,color: UIColor.darkGray)
//                //            headerView.topbgView1.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
//
//                //            headerView.topbgView1.backgroundColor = UIColor.clear
//                headerView.lblTitle.textColor = GetColor.whiteColor
//                headerView.imgDerctionIcon.isHidden = true
//                let Setected = "\(arrStudentTestSWAnalysis[section].isSelected ?? "")"
//                if Setected == "1"
//                {
//                    let image : UIImage = UIImage(named:"down-arrow-icon")!
//                    headerView.imgDerctionIcon.image = image
//                    //                userHeader.imgDerctionIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
//                }
//                else
//                {
//                    let image : UIImage = UIImage(named:"up-arrow-icon")!
//                    headerView.imgDerctionIcon.image = image//UIImageView(image: <#T##UIImage?#>)
//                    //                self.DashButton.imageView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
//                }

//                headerView.btnExpand.tag = section
                //            headerView.btnExpand.addTarget(self, action: #selector(ReadAgainClicked), for: .touchUpInside)



                return headerView//arrQueAns.count > 0 ? headerView.contentView : nil
            }

                func numberOfSections(in tableView: UITableView) -> Int {
                    if arrTemplete.count > 0
                    {
                        return 1//arrQueAns.count
                    }
                    else
                    {
                        return 0
                    }
                }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                tableView.backgroundView = nil;
        if self.arrTempleteDetail.count > 0 { return self.arrTempleteDetail.count}
        else
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = ""
            noDataLabel.textColor     = UIColor.red
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            return 0
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50//UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let identifier = "TamplateTableViewCell"
        var cell: TamplateTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TamplateTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "TamplateTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TamplateTableViewCell
        }
        cell.lblSectionname.text = "\(arrTempleteDetail[indexPath.row].Sectionname ?? "")"// (\(arrTempleteDetail[indexPath.row].SubjectName ?? ""))"
        cell.lblQuestionTypeName.text = "\(arrTempleteDetail[indexPath.row].QuestionTypeName ?? "")"
        cell.lblNoOfQue.text = "\(arrTempleteDetail[indexPath.row].NoOfQue ?? "")"
        cell.lblMarks.text = "\(arrTempleteDetail[indexPath.row].Marks ?? "")"
        cell.lblTotalMarks.text = "\(arrTempleteDetail[indexPath.row].TotalMarks ?? "")" //"\((Double(arrTempleteDetail[indexPath.row].Marks ?? "0")) * (Double(arrTempleteDetail[indexPath.row].NoOfQue ?? "") ?? 0.0))" // "\(arrTemplete[indexPath.row].Marks ?? "")"

//        cell.lblNegativeMarks.text = "\(arrTemplete[indexPath.row].NegativeMarks ?? "")"
//        cell.lblSectionInstruction.text = "\(arrTemplete[indexPath.row].SectionInstruction ?? "")"

        //        cell.lblPackageName.text = "" //arrList[indexPath.row]
        //        cell.lblPackageName.text = arrMyPackageList[indexPath.row].TestPackageName ?? ""
        //        cell.lblStartDate.text = arrMyPackageList[indexPath.row].packageStartDate ?? ""
        //        cell.lblEndDate.text = arrMyPackageList[indexPath.row].packageEndDate ?? ""
        //        cell.lblPrice.text = "₹" + "\(arrMyPackageList[indexPath.row].TestPackageSalePrice ?? "")"
        if indexPath.row == (arrTempleteDetail.count - 1) {
            cell.topbgView1.backgroundColor = GetColor.ColorGrayF5F5F5
            cell.lblSectionname.text = "\(arrTempleteDetail[indexPath.row].Sectionname ?? "")"
        }
        cell.topbgView1.addShadowWithRadius(0,0,0,color: UIColor.lightGray)
        return cell


    }


}
