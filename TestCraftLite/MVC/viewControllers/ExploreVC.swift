//
//  ExploreVC.swift
//  TestCraft
//
//  Created by ADMS on 09/08/19.
//  Copyright © 2019 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController

class ExploreVC: UIViewController, ModernSearchBarDelegate, ActivityIndicatorPresenter,UISearchBarDelegate{
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()
//    //MARK:- Outlets
//    //MARK:-
    @IBOutlet var tblRecentSearch: UITableView!
//
//    //MARK:- Properties
//    //MARK:-
//    var shouldShowSearchResults = false
//    var searchController: ModernSearchBar!
    @IBOutlet weak var modernSearchBar: ModernSearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        loadListOfCountries() // get the data from file
//        configureSearchController() // Config Controller in VC
        self.makingSearchBarAwesome()
        self.modernSearchBar.delegateModernSearchBar = self

        ///Uncomment this one...
        self.configureSearchBar()
        ///... or uncomment this one ! (but you can't uncomment both)
//        self.configureSearchBarWithUrl()
        self.Get_Sub_ListApi(strSub: "")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        lblTitle.text = "" + arrPath.joined(separator:",")
        self.tabBarController?.tabBar.isHidden = false
                let allTextField = getTextfield(view: self.view)
                for txtField in allTextField
                {
                            txtField.layer.cornerRadius = 0
                            txtField.textAlignment = NSTextAlignment.left
//                                    let image:UIImage = UIImage(named: "search-iocn@2x.png")!
//                                    let imageView:UIImageView = UIImageView.init(image: image)
                            txtField.placeholder = "Search by subject, course or tutor"//"Search by subject or course"
//                            txtField.rightView = imageView//searchTextField.leftView//imageView
//                            txtField.leftView = nil
                    txtField.textColor = GetColor.blackColor
                            txtField.rightViewMode = UITextField.ViewMode.always

                }
                modernSearchBar.barTintColor = UIColor.lightGray
                modernSearchBar.tintColor = UIColor.lightGray
                Get_HistoryApi()
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "811", comment: "Explore", isFirstTime: "0")

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        //Bhargav Hide
////print(self.modernSearchBar.subviews[0])
        //        //Bhargav Hide
////print(self.modernSearchBar.subviews[0].subviews[2])

//        let searchTextField = getAllTextFields(fromView : self.modernSearchBar).map{($0.text = "Hey dude!")}
//self.modernSearchBar.subviews[0].subviews[3] as! UITextField
//        searchTextField.layer.cornerRadius = 15
//        searchTextField.textAlignment = NSTextAlignment.left
////                let image:UIImage = UIImage(named: "search-iocn@2x.png")!
////                let imageView:UIImageView = UIImageView.init(image: image)
//        searchTextField.placeholder = "Search by subject or course"
////        searchTextField.rightView = imageView//searchTextField.leftView//imageView
////        searchTextField.leftView = nil
//        searchTextField.rightViewMode = UITextField.ViewMode.always

//        let allTextField = getTextfield(view: self.view)
//        for txtField in allTextField
//        {
//            txtField.x = 0
//                    txtField.layer.cornerRadius = 0
//                    txtField.textAlignment = NSTextAlignment.left
//                            let image:UIImage = UIImage(named: "search-iocn@2x.png")!
//                            let imageView:UIImageView = UIImageView.init(image: image)
//                    txtField.placeholder = "Search by subject or course"
//                    txtField.rightView = imageView//searchTextField.leftView//imageView
//                    txtField.leftView = nil
//                    txtField.rightViewMode = UITextField.ViewMode.always
//
//        }
////        modernSearchBar.barTintColor = UIColor.lightGray
////        modernSearchBar.tintColor = UIColor.lightGray


    }
    func getTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                results += [textField]
            } else {
                results += getTextfield(view: subview)
            }
        }
        return results
    }
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                //Bhargav Hide
                ////print(view)
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
        }.flatMap({$0})
    }

    //----------------------------------------
    // OPTIONNAL DELEGATE METHODS
    //----------------------------------------
    
    
    ///Called if you use String suggestion list
    func onClickItemSuggestionsView(item: String) {
        //Bhargav Hide
////print("User touched this item: "+item)
        addDataRecentSerach(strTitle: item)
    }
    
    ///Called if you use Custom Item suggestion list
    func onClickItemWithUrlSuggestionsView(item: ModernSearchBarModel) {
        //Bhargav Hide
////print("User touched this item: "+item.title+" with this url: "+item.url.description)
        addDataRecentSerach(strTitle: item.title)
    }
    
    ///Called when user touched shadowView
    func onClickShadowView(shadowView: UIView) {
        //Bhargav Hide
////print("User touched shadowView")
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let result = true
//
////        if txtMobile == textField {
////            if (string).count > 0 {
////                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789.-").inverted
////                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
////                if textField.text!.count > 9
////                {
////                    result = false
////                }
////                else
////                {
////                    result = replacementStringIsLegal
////                }
////            }
////        }
////        else
////        {
//            guard range.location == 0 else {
//                return true
//            }
//
//            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
//            return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
////        }
//
//        return result
//    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
                let result = true

        //        if txtMobile == textField {
        //            if (string).count > 0 {
        //                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789.-").inverted
        //                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
        //                if textField.text!.count > 9
        //                {
        //                    result = false
        //                }
        //                else
        //                {
        //                    result = replacementStringIsLegal
        //                }
        //            }
        //        }
        //        else
        //        {
                    guard range.location == 0 else {
                        return true
                    }

                    let newString = (searchBar.text! as NSString).replacingCharacters(in: range, with: text) as NSString
                    return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
        //        }

//                return result
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Bhargav Hide
print("Text did change, what i'm suppose to do ? \(searchText)")
       
//        SetApiWithData(related_txt: searchText)

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        addDataRecentSerach(strTitle: searchBar.text ?? "")
    }
    

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.modernSearchBar.endEditing(true)
//        tblRecentSearch.reloadData()
    }
    func addDataRecentSerach(strTitle: String) {
        self.modernSearchBar.endEditing(true)
        if strTitle == ""
        {
            
        }
        else
        {
            showActivityIndicator()

            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            //Bhargav Hide
////print(result)

            let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")", "SearchText":strTitle]

//            let params = ["StudentID":"","Email":strTitle]
            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            //Bhargav Hide
print("API, Params: \n",API.Add_Seach_HistoryApi,params)
                           if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                               // show Alert
                               self.hideActivityIndicator()
                               print("The network is not reachable")
                               // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
                               return
                           }

            Alamofire.request(API.Add_Seach_HistoryApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
                self.hideActivityIndicator()

                switch response.result {
                case .success(let value):

                    let json = JSON(value)
                    //Bhargav Hide
////print(json)

                    if(json["Status"] == "true" || json["Status"] == "1") {
//                        let jsonArray = json["data"][0].dictionaryObject!
//                        arrRecentSearches.append(strTitle)
//                        //        arrRecentSearches.reversed()
//                        arrRecentSearches.reversed().forEach {//Bhargav Hide
////print($0)}
//                        let totalIndices = arrRecentSearches.count - 1 // We get this value one time instead of once per iteration.
//
//                        var reversedNames = [String]()
//
//                        for arrayIndex in 0...totalIndices {
//                            reversedNames.append(arrRecentSearches[totalIndices - arrayIndex])
//                        }
//                        arrRecentSearches.removeAll()
//                        arrRecentSearches = reversedNames
//                        self.tblRecentSearch.reloadData()
                        self.api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3101", comment: "Search", isFirstTime: "0")

//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MarketPlaceBoxVC") as? MarketPlaceBoxVC
//                        vc!.strPackageType = "-1"
//                        vc!.strPackagePackageName = strTitle

                        //self.navigationController?.pushViewController(vc!, animated: true)
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
        func Get_HistoryApi()
        {
            showActivityIndicator()
            arrRecentSearches.removeAll()
            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
            //Bhargav Hide
////print(result)

            let params = ["StudentID":"\(result.value(forKey: "StudentID") ?? "")"]

            let headers = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
           let api = API.Get_Seach_HistoryApi
            //Bhargav Hide
////print(api,params)
                           if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                               // show Alert
                               self.hideActivityIndicator()
                               print("The network is not reachable")
                               self.tblRecentSearch.reloadData()
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
////print(json)

                    if(json["Status"] == "true" || json["Status"] == "1") {
                        let arrData = json["data"].array
//                        //                    var arrChild = [YourPreferencesModal]()
//                        var suggestionList = Array<String>()
                        for value in arrData! {
//                            suggestionList.append("\(value["Name"].stringValue)")
//                            self.strID.append("\(value["ID"].stringValue)")
                            arrRecentSearches.append("\(value["SearchText"].stringValue)")
                        }
//                        ///Adding delegate
//                        self.modernSearchBar.delegateModernSearchBar = self
//
//                        ///Set datas to search bar
//                        self.modernSearchBar.setDatas(datas: suggestionList)
//                        //        self.modernSearchBar.suggestionsView_searchIcon_width = 0
//
//                        ///Custom design with all paramaters if you want to
//                        self.customDesign()
                    }
                    else
                    {
                        self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                        //                    self.collectionView.reloadData()
                    }
                case .failure(let error):
                    self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
                }
                if(arrRecentSearches.count > 0)
                {
                    self.tblRecentSearch.reloadData()
                }
            }
        }


    var strID = [String]()
    func Get_Sub_ListApi(strSub: String)
    {
        showActivityIndicator()
        var params = ["":""]
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        var strSet_Title = ""
        var api = ""
        //        if strStd_Sub == "1"
        //        {
        //            api = API.Get_StandardApi
        //            strSet_Title = "Step 2 - Select Standard"
        //            arrStandardFilter.removeAll()
        //        }
        //        else
        //        {
        api = API.Get_TestPackageName_AutoCompleteApi
//        strSet_Title = "Step 3 - Select Subject"
//        arrSubjectFilter.removeAll()
//        //        }
//        //Bhargav Hide
print("API, Params: \n",api,params)
//        self.tblDashbord.reloadData()
                       if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

                           // show Alert
                           self.hideActivityIndicator()
                           print("The network is not reachable")
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
////print(json)
                
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"].array
                    //                    var arrChild = [YourPreferencesModal]()
                    var suggestionList = Array<String>()
//                    suggestionList.append("Celery")
//                    suggestionList.append("Very long vegetable to show you that cell is updated and fit all the row")
//                    suggestionList.append("Potatoes")
//                    suggestionList.append("Carrots")
//                    suggestionList.append("Broccoli")
//                    suggestionList.append("Asparagus")
//                    suggestionList.append("Apples")
//                    suggestionList.append("Berries")
//                    suggestionList.append("Kiwis")
//                    suggestionList.append("Raymond")
                    
                   
                    for value in arrData! {
                        suggestionList.append("\(value["Name"].stringValue)")
                        self.strID.append("\(value["ID"].stringValue)")
                        //                        if strStd_Sub == "1"
                        //                        {
                        ////                            //Bhargav Hide
////print(strCategoryTitle2)
                        //                            var preSelectedValues = [String]()
                        //                            preSelectedValues = strCategoryID2.components(separatedBy: ",")
                        //                            let filtered = preSelectedValues.filter { $0.contains("\(value["StandardID"].stringValue)") }
                        //                            var strSelectedTemp = "0"
                        //                              if filtered.count > 0{if self.strClearAll == "" {strSelectedTemp = "1"}}
                        
                        //
                        //                            let ChildModel:SubCategory1ListModal = SubCategory1ListModal.init(id: value["StandardID"].stringValue, title: value["StandardName"].stringValue, subTitle: "", image: "\(API.imageUrl)\(value["Icon"].stringValue)", selected: strSelectedTemp)
                        //
                        //                            self.arrStandardFilter.append(ChildModel)
                        //                        }
                        //                        else
                        //                        {
                        //                            //Bhargav Hide
////print(strCategoryTitle3)
//                        var preSelectedValues = [String]()
//                        preSelectedValues = strCategoryID3.components(separatedBy: ",")
//                        let filtered = preSelectedValues.filter { $0 == "\(value["SubjectID"].stringValue)" }
//                        var strSelectedTemp = "0"
//                        if filtered.count > 0{if self.strClearAll == "" {strSelectedTemp = "1"}}
//
//                        let ChildModel:SubCategory1ListModal = SubCategory1ListModal.init(id: value["SubjectID"].stringValue, title: value["SubjectName"].stringValue, subTitle: "", image: "\(API.imageUrl)\(value["Icon"].stringValue)", selected: strSelectedTemp)
//
//                        self.arrSubjectFilter.append(ChildModel)
                        //                        }
                    }
                    ///Adding delegate
                    self.modernSearchBar.delegateModernSearchBar = self
                    
                    ///Set datas to search bar
                    self.modernSearchBar.setDatas(datas: suggestionList)
                    //        self.modernSearchBar.suggestionsView_searchIcon_width = 0
                    
                    ///Custom design with all paramaters if you want to
                    self.customDesign()
                }
                else
                {
                    self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                    //                    self.collectionView.reloadData()
                }
            case .failure(let error):
                self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
//            self.tblDashbord.reloadData()
        }
    }
    private func SetApiWithData(related_txt: String){
        ///Create array of string
        var suggestionList = Array<String>()
        suggestionList.append("Onions")
        suggestionList.append("Celery")
        suggestionList.append("Very long vegetable to show you that cell is updated and fit all the row")
        suggestionList.append("Potatoes")
        suggestionList.append("Carrots")
        suggestionList.append("Broccoli")
        suggestionList.append("Asparagus")
        suggestionList.append("Apples")
        suggestionList.append("Berries")
        suggestionList.append("Kiwis")
        suggestionList.append("Raymond")
        
        ///Adding delegate
        //        self.modernSearchBar.delegateModernSearchBar = self
        
        ///Set datas to search bar
        self.modernSearchBar.setDatas(datas: suggestionList)
        //        self.modernSearchBar.suggestionsView_searchIcon_width = 0
    }
    //----------------------------------------
    // CONFIGURE SEARCH BAR (TWO WAYS)
    //----------------------------------------
    
    // 1 - Configure search bar with a simple list of string
    
    private func configureSearchBar(){
        
        ///Create array of string
//        var suggestionList = Array<String>()
//        suggestionList.append("Onions")
//        suggestionList.append("Celery")
//        suggestionList.append("Very long vegetable to show you that cell is updated and fit all the row")
//        suggestionList.append("Potatoes")
//        suggestionList.append("Carrots")
//        suggestionList.append("Broccoli")
//        suggestionList.append("Asparagus")
//        suggestionList.append("Apples")
//        suggestionList.append("Berries")
//        suggestionList.append("Kiwis")
//        suggestionList.append("Raymond")
//
//        ///Adding delegate
//        self.modernSearchBar.delegateModernSearchBar = self
//
//        ///Set datas to search bar
//        self.modernSearchBar.setDatas(datas: suggestionList)
////        self.modernSearchBar.suggestionsView_searchIcon_width = 0
//
//        ///Custom design with all paramaters if you want to
//        self.customDesign()
        
    }
    
//    // 2 - Configure search bar with a list of ModernSearchBarModel (If you want to show also an image from an url)
//
//    private func configureSearchBarWithUrl(){
//
//        ///Create array of ModernSearchBarModel containing a title and a url
//        var suggestionListWithUrl = Array<ModernSearchBarModel>()
////        suggestionListWithUrl.append(ModernSearchBarModel(title: "Alpha", url: "https://github.com/PhilippeBoisney/ModernSearchBar/raw/master/Examples%20Url/exampleA.png"))
////        suggestionListWithUrl.append(ModernSearchBarModel(title: "Bravo", url: "https://github.com/PhilippeBoisney/ModernSearchBar/raw/master/Examples%20Url/exampleB.png"))
////        suggestionListWithUrl.append(ModernSearchBarModel(title: "Charlie ? Well, just a long sentence to show you how powerful is this lib...", url: "https://github.com/PhilippeBoisney/ModernSearchBar/raw/master/Examples%20Url/exampleC.png"))
////        suggestionListWithUrl.append(ModernSearchBarModel(title: "Delta", url: "https://github.com/PhilippeBoisney/ModernSearchBar/raw/master/Examples%20Url/exampleD.png"))
//        suggestionListWithUrl.append(ModernSearchBarModel(title: "Echo", url: "https://github.com/PhilippeBoisney/ModernSearchBar/raw/master/Examples%20Url/exampleE.png"))
////        suggestionListWithUrl.append(ModernSearchBarModel(title: "Golf", url: "https://github.com/PhilippeBoisney/ModernSearchBar/raw/master/Examples%20Url/exampleG.png"))
////
//
//        ///Adding delegate
//        self.modernSearchBar.delegateModernSearchBar = self
//
//        ///Set datas to search bar
//        self.modernSearchBar.setDatasWithUrl(datas: suggestionListWithUrl)
//
//        ///Increase size of suggestionsView icon
//        self.modernSearchBar.suggestionsView_searchIcon_height = 40
//        self.modernSearchBar.suggestionsView_searchIcon_width = 40
//
//        ///Custom design with all paramaters
//        //self.customDesign()
//
//    }
    
    //----------------------------------------
    // CUSTOM DESIGN (WITH ALL OPTIONS)
    //----------------------------------------
    
    private func customDesign(){
        
        // --------------------------
        // Enjoy this beautiful customizations (It's a joke...)
        // --------------------------
        
        
        //Modify shadows alpha
        self.modernSearchBar.shadowView_alpha = 0.0
        
        //Modify the default icon of suggestionsView's rows
//        self.modernSearchBar.searchImage = ModernSearchBarIcon.Icon.none.image
        
        //Modify properties of the searchLabel
//        self.modernSearchBar.searchLabel_font = UIFont(name: "Avenir-Light", size: 15)
//        self.modernSearchBar.searchLabel_textColor = UIColor.red
//        self.modernSearchBar.searchLabel_backgroundColor = UIColor.black
        
        //Modify properties of the searchIcon
        self.modernSearchBar.suggestionsView_searchIcon_height = 40
        self.modernSearchBar.suggestionsView_searchIcon_width = 0//40
        self.modernSearchBar.suggestionsView_searchIcon_isRound = false
        
        //Modify properties of suggestionsView
        ///Modify the max height of the suggestionsView
//        self.modernSearchBar.suggestionsView_maxHeight = 1000
        ///Modify properties of the suggestionsView
        self.modernSearchBar.suggestionsView_backgroundColor = GetColor.whiteColor
        self.modernSearchBar.suggestionsView_contentViewColor = GetColor.whiteColor
        self.modernSearchBar.searchLabel_backgroundColor = GetColor.whiteColor
        self.modernSearchBar.searchLabel_textColor = GetColor.blackColor
        self.modernSearchBar.suggestionsView_separatorStyle = .singleLine
//        self.modernSearchBar.suggestionsView_selectionStyle = UITableViewCell.SelectionStyle.gray
        self.modernSearchBar.suggestionsView_verticalSpaceWithSearchBar = 0
        self.modernSearchBar.suggestionsView_spaceWithKeyboard = 20
//        self.modernSearchBar.searchLabel_font
//        self.modernSearchBar.searchLabel_textColor: UIColor?
//        self.modernSearchBar.searchLabel_backgroundColor: UIColor?

        
    }
    
    private func makingSearchBarAwesome(){
        self.modernSearchBar.backgroundImage = UIImage()
        self.modernSearchBar.layer.borderWidth = 0
        self.modernSearchBar.layer.borderColor = UIColor(red: 181, green: 240, blue: 210, alpha: 1).cgColor
        self.modernSearchBar.addShadowWithRadius(0,5,1.1,color: UIColor(rgb: 0xA3A5AC))
    }
    
    
    // List of product
    
}

extension ExploreVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = nil;
                if arrRecentSearches.count > 0 { return arrRecentSearches.count }
                else
                {
                    let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                    noDataLabel.text          = ""
                    noDataLabel.textColor     = UIColor.red
                    noDataLabel.textAlignment = .center
                    tableView.backgroundView  = noDataLabel
                    noDataLabel.font = UIFont(name: "System-Regular", size: 25)
                    tableView.separatorStyle  = .none
                    return 0
                }
        
    }
    //My heightForRowAtIndexPath method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//indexPath.section == selectedIndex ? UITableViewAutomaticDimension : 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "CartTableViewCell"
        //        if arrPaymentList[indexPath.row].ExternalTransactionStatus ?? "" == "success"
        //        {
        //            identifier = "PaymentTableViewCell1"
        //        }
        var cell: CartTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CartTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CartTableViewCell
        }
        if(arrRecentSearches.count > 0)
        {
            cell.lbl_Title.text = arrRecentSearches[indexPath.row]//\(arrCartList[indexPath.row].title ?? "")"
        }
//        cell.lbl_SubTitle.text = "Chapter 13 Test"//arrCartList[indexPath.row].subTitle ?? ""
//        cell.lbl_Price.text = "₹ 100.00"// + "\(arrCartList[indexPath.row].price ?? "")"
        
//        cell.topbgView1.addShadowWithRadius(1,1,0,color: UIColor.darkGray)
        //        cell.topbgView1.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.black, thickness: 1.0)
        //            cell.btnTryAgain.tag = indexPath.row
        //            cell.btnTryAgain.addTarget(self, action: #selector(btnTryAgainClikedAction(sender:)), for: .touchUpInside)
        //            cell.btnTryAgain.addShadowWithRadius(0,cell.btnTryAgain.frame.width/9,0,color: GetColor.blueHeaderText)
        
        //        cell.contentView.addShadowWithRadius(5,5,0,color: UIColor.darkGray)
        
//        cell.imgIcon.sd_setShowActivityIndicatorView(true)
//        cell.imgIcon.sd_setIndicatorStyle(.gray)
//
//        let url = URL.init(string: "https://content.testcraft.co.in/question/" + ("").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
//        cell.imgIcon.addShadowWithRadius(0,cell.imgIcon.frame.width/2,0,color: UIColor.darkGray)
//        cell.imgIcon.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
//            if error != nil {
//                //Bhargav Hide
////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
//                cell.imgIcon.setImageForName(cell.lbl_SubTitle.text ?? "", backgroundColor: nil, circular: false, textAttributes: nil, gradient: true)
//                //(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
//                //fetchedImage
//                return
//            }
//            //                let aspectRatio = (cell.imgIcon.image! as UIImage).size.height/(cell.imgIcon.image! as UIImage).size.width
//            cell.imgIcon.image = fetchedImage
//        }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedvalue = arrRecentSearches[indexPath.row]
//        addDataRecentSerach(strTitle: selectedvalue)
        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "3101", comment: "Search", isFirstTime: "0")

//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MarketPlaceBoxVC") as? MarketPlaceBoxVC
//        vc!.strPackageType = "-1"
//        vc!.strPackagePackageName = selectedvalue//arrTestPackages[buttonRow].TestPackageName ?? ""
//        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    //
    //        let editAction = UITableViewRowAction(style: .normal, title: "Try Again") { (rowAction, indexPath) in
    //            //TODO: edit the row at indexPath here
    //            let result = UserDefaults.standard.value(forKey: "logindata")! as! NSDictionary
    //            //Bhargav Hide
////print(result)
    //            self.Resend_Payment_Api(StudentID: "\(result.value(forKey: "StudentID") ?? "")", PaymentAmount: "\(self.arrPaymentList[indexPath.row].PaymentAmount ?? "")", PaymentTransactionID: "\(self.arrPaymentList[indexPath.row].PaymentTransactionID ?? "")")
    //        }
    //        editAction.backgroundColor = GetColor.themeBlueColor
    //
    //        //        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
    //        //            //TODO: Delete the row at indexPath here
    //        //        }
    //        //        deleteAction.backgroundColor = .red
    //        if arrPaymentList[indexPath.row].ExternalTransactionStatus ?? "" == "success"
    //        {
    //            return []
    //        }
    //        else
    //        {
    //            return [editAction]//,deleteAction]
    //        }
    //    }
}
