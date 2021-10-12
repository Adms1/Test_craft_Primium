//
//  YourPreferenceVC.swift
//  TestCraftLite
//
//  Created by ADMS on 24/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import SDWebImage



class YourPreferenceVC: UIViewController {

    // MARK: - IBOUTLET
    @IBOutlet weak var prefernceCollVw:UICollectionView!

    // MARK: - Array Defined
    var arrPreferenceList = [subPreferenceList]()

    override func viewDidLoad() {
        super.viewDidLoad()

        prefernceCollVw.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionViewCell")
        api_Call_Get_Board_Course_List()
        Get_Coin_API()
    }
}
extension YourPreferenceVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    // MARK: - UICollectionViewDataSource protocol

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let homeHeaderReuseIdentifier = "HeaderCollectionViewCell"
//        let homeFooterReuseIdentifier = "HeaderCollectionViewCell"

        switch kind {
        case UICollectionView.elementKindSectionHeader:

            let userHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeHeaderReuseIdentifier, for: indexPath) as! HeaderCollectionViewCell
            userHeader.lblTitle.text = arrPreferenceList[indexPath.section].Name
            userHeader.lblTitle.textColor = GetColor.blueHeaderText
            userHeader.bgView.backgroundColor = GetColor.blueHeaderBg
            //            bgImage = UIImageView(image: image)
            if arrPreferenceList[indexPath.section].selected == "0"
            {
                let image : UIImage = UIImage(named:"down-arrow-icon")!
                userHeader.imgDerctionIcon.image = image
                //                userHeader.imgDerctionIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));

            }
            else
            {
                let image : UIImage = UIImage(named:"up-arrow-icon")!
                userHeader.imgDerctionIcon.image = image//UIImageView(image: <#T##UIImage?#>)
                //                self.DashButton.imageView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);

            }

            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(expandCollapseSection(_:)))
            userHeader.contentView.tag = indexPath.section
            userHeader.contentView.addGestureRecognizer(tapGesture)

            return userHeader

//        case UICollectionView.elementKindSectionFooter:
//            let userFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeFooterReuseIdentifier, for: indexPath) as! HomeCollectionViewCell
//            return userFooter
        default:
            return UICollectionReusableView()
        }
    }
    @objc func expandCollapseSection(_ gesture:UIGestureRecognizer)
    {
        let Index:Int = (gesture.view?.tag)!

        for var i in (0..<arrPreferenceList.count)
        {
            arrPreferenceList[i].selected = "0"
            i += 1
        }
        arrPreferenceList[Index].selected = "1"

        for (index,_) in arrPreferenceList.enumerated(){
            arrPreferenceList[index].selected = "0"
            for (index1,_) in arrPreferenceList[index].arrStandard.enumerated(){
                arrPreferenceList[index].arrStandard[index1].selected = "0"
            }
        }
        arrPreferenceList[Index].selected = "1"

//        if arrHeaderSubTitle[Index].selected == "0"
//        {
//            arrHeaderSubTitle[Index].selected = "1"
//        }
//        else
//        {
//            arrHeaderSubTitle[Index].selected = "0"
//        }
        //        if(selectedIndex == Index) {
        //            selectedIndex = -1
        //        }
        //        else {
        //            selectedIndex = Index
        //        }
        //
        prefernceCollVw.reloadData()
//        collectionView.reloadSections(NSIndexSet.init(index: Index) as IndexSet)
        //        if(selectedIndex != -1){
//        if arrHeaderSubTitle[Index].selected == "1"
//        {
//            self.collectionView.scrollToItem(at: NSIndexPath.init(row: 0, section: Index) as IndexPath, at: .right, animated: true)
//        }
        ////            self.tableView.scrollToRow(at: NSIndexPath.init(row: 0, section: selectedIndex) as IndexPath, at: .none, animated: true)
        //        }

        //        collectionView.scrollToRow(at: NSIndexPath.init(row: 0, section: Index) as IndexPath, at: .none, animated: true)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrPreferenceList.count//5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        //        if(section==0) {
        //            return CGSize.zero
        //        } else if (section==1) {
        //            return CGSize(width:collectionView.frame.size.width, height:133)
        //        } else {
        return CGSize(width:collectionView.frame.size.width, height:50)
        //        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if UIDevice.current.userInterfaceIdiom == .pad {
            //Bhargav Hide
////print("iPad")
            return CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.width/3);

        }else{
            //Bhargav Hide
////print("not iPad")
            print("width==\(((collectionView.frame.size.width)/3))")
            print("height==\(((collectionView.frame.size.width/3)))")

            return CGSize(width: ((collectionView.frame.size.width)/3), height: ((collectionView.frame.size.width/2.5)));

        }

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if (arrList[section].arrType.count == 0) {
//            self.collvw.setEmptyMessage("No records are found.")
//        } else {
//            self.collectionView.restore()
//        }
        //        if(section == selectedIndex){
        if arrPreferenceList[section].selected == "1"
        {
            return arrPreferenceList[section].arrStandard.count//arrHeaderSubTitle.count
        }
        else
        {
            return 0

        }
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.bgView.backgroundColor = UIColor.clear//GetColor.themeBlueColor
        cell.bgView.addShadowWithRadius(0,0,0,color: UIColor.clear)
//        cell.displayData("Main",arrHeaderSubTitle[indexPath.section].arrType[indexPath.row].title ?? "")
//        cell.imgIcon.image = nil
        cell.displayData("Main",arrPreferenceList[indexPath.section].arrStandard[indexPath.row].Name )
        cell.imgIcon.image = nil
//
//        cell.mImage.layer.cornerRadius = cell.mImage.frame.height/2
        cell.layoutIfNeeded()
        cell.imgIcon.layer.cornerRadius = cell.imgIcon.frame.size.height / 2.0
        cell.imgIcon.layer.masksToBounds = true
//        cell.imgIcon.layer.borderColor = UIColor.red.cgColor
//        cell.imgIcon.layer.borderWidth = 1
       //
//        cell.imgIcon.layer.cornerRadius = cell.imgIcon.layer.frame.width/2

//                cell.imgIcon.setImageForName(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil, gradient: true)

//        var strDisplayText = ""
//        if self.arrHeaderSubTitle[indexPath.section].title == "Step 2 - Select Standard"
//        {
//            var fullNameArr = cell.lblTitle.text!.components(separatedBy: " ")
//            //                    var firstName: String = fullNameArr[0]
//            strDisplayText = fullNameArr[0]
//
//        }
//        else
//        {
//            strDisplayText = cell.lblTitle.text ?? ""
//        }
//        cell.imgRightSelection.image = UIImage(named: "forgot_true_icon.png")
        if self.arrPreferenceList[indexPath.section].arrStandard[indexPath.row].selected == "0"
        {
            cell.lblTitle.textColor = UIColor.black
//            cell.imgIcon.setImageForName(strDisplayText, backgroundColor: UIColor.lightGray, circular: true, textAttributes: nil, gradient: false)//(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
            //cell.imgIcon.image = UIImage(named: "gray-circle")

            cell.lblAlertDot.isHidden = true
            cell.lblAlertDot.backgroundColor  = UIColor.clear
            cell.imgRightSelection.isHidden = true
        }
        else
        {
            cell.lblTitle.textColor = UIColor.black
//            cell.imgIcon.setImageForName(strDisplayText, backgroundColor: GetColor.themeBlueColor, circular: true, textAttributes: nil, gradient: false)//(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
           // cell.imgIcon.image = UIImage(named: "pink-circle")
            cell.lblAlertDot.isHidden = true
            cell.lblAlertDot.backgroundColor  = GetColor.blueHeaderText
            cell.imgRightSelection.isHidden = false

        }
//        cell.imgIcon.layer.cornerRadius = cell.imgIcon.layer.frame.width/2.0
//        cell.imgIcon.clipsToBounds = true
        cell.lblAlertDot.layer.cornerRadius = 2.0
        cell.lblAlertDot.clipsToBounds = true
//        cell.imgIcon.sd_setShowActivityIndicatorView(true)
//        cell.imgIcon.sd_setIndicatorStyle(.gray)
//        cell.imgIcon.addShadowWithRadius(0,0,0,color: UIColor.clear)

        print("\(arrPreferenceList[indexPath.section].arrStandard[indexPath.row].Icon )")
        let url = URL.init(string: "\(arrPreferenceList[indexPath.section].arrStandard[indexPath.row].Icon )".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        //        let url = URL.init(string: "https://content.testcraft.co.in/question/" + (arrHeaderSub3Title[indexPath.row].image ?? "").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        cell.imgIcon.sd_setImage(with: url, placeholderImage: nil, options: .transformAnimatedImage){ (fetchedImage, error, cacheType, url) in
            if error != nil {
                //Bhargav Hide
////print("Error loading Image from URL: \(String(describing: url))\n(error?.localizedDescription)")
                //                self.image = placeholder
                //                cell.imgIcon.setImageForName(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
                var strDisplayText = ""
                if self.arrPreferenceList[indexPath.section].Name == "Step 2 - Select Standard"
                {
                    let fullNameArr = cell.lblTitle.text!.components(separatedBy: " ")
//                    var firstName: String = fullNameArr[0]
                    strDisplayText = fullNameArr[0]

                }
                else
                {
                    strDisplayText = cell.lblTitle.text ?? ""
                }

                if self.arrPreferenceList[indexPath.section].arrStandard[indexPath.row].selected == "0"
                {
//                    cell.lblTitle.textColor = UIColor.black
                    cell.imgIcon.setImageForName(strDisplayText, backgroundColor: UIColor.lightGray, circular: true, textAttributes: nil, gradient: false)//(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
                    //                    cell.imgIcon.image = UIImage(named: "gray-circle")

//                    cell.lblAlertDot.isHidden = true
//                    cell.lblAlertDot.backgroundColor  = UIColor.clear
                }
                else
                {
//                    cell.lblTitle.textColor = GetColor.blueHeaderText
                    cell.imgIcon.setImageForName(strDisplayText, backgroundColor: GetColor.themeBlueColor, circular: true, textAttributes: nil, gradient: false)//(cell.lblTitle.text ?? "", backgroundColor: nil, circular: true, textAttributes: nil)
//                    cell.imgIcon.image = UIImage(named: "pink-circle")
//                    cell.lblAlertDot.isHidden = false
//                    cell.lblAlertDot.backgroundColor  = GetColor.blueHeaderText
                }
//                cell.lblAlertDot.layer.cornerRadius = 2.0
//                cell.lblAlertDot.clipsToBounds = true

                //fetchedImage
                return
            }
            //            let aspectRatio = (cell.imgIcon.image! as UIImage).size.height/(cell.imgIcon.image! as UIImage).size.width
            //            cell.imgIcon.image = fetchedImage
        }

//        cell.imgIcon.layer.cornerRadius = 
//        cell.imgIcon.addShadowWithRadius(0,cell.imgIcon.frame.width/3.5,0,color: UIColor.clear)
//        print(cell.imgIcon.frame.width/3.5, cell.imgIcon.frame.width)
//        imgProfile.addShadowWithRadius(0,imgProfile.frame.width/2,0,color: UIColor.darkGray)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

            if arrPreferenceList[indexPath.section].selected == "1"
            {
                for (index,_) in arrPreferenceList[indexPath.section].arrStandard.enumerated()
                {
                        arrPreferenceList[indexPath.section].arrStandard[index].selected = "0"
                }

            }
        arrPreferenceList[indexPath.section].arrStandard[indexPath.row].selected = "1"
        self.prefernceCollVw.reloadData()

        print("CourseTypeID",arrPreferenceList[indexPath.section].CourseTypeID)
        print("IDBoard",arrPreferenceList[indexPath.section].ID)
        print("IDBoard",arrPreferenceList[indexPath.section].arrStandard[indexPath.row].ID)
        print("IDBoard",arrPreferenceList[indexPath.section].Name)
        print("Name",arrPreferenceList[indexPath.section].arrStandard[indexPath.row].Name)

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubscriptionPopupVC") as? SubscriptionPopupVC
//        self.tabBarController?.tabBar.isHidden = true
        vc?.PopCategoryID = "\(arrPreferenceList[indexPath.section].CourseTypeID)"
        vc?.PopCategoryID1 = arrPreferenceList[indexPath.section].ID
        vc?.PopCategoryID2 = arrPreferenceList[indexPath.section].arrStandard[indexPath.row].ID
        vc?.arrTitle = ["\(arrPreferenceList[indexPath.section].Name)","\(arrPreferenceList[indexPath.section].arrStandard[indexPath.row].Name)"]
        self.navigationController?.pushViewController(vc!, animated: false)

    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        //                let animation = CABasicAnimation(keyPath: "cornerRadius")
        //                animation.fromValue = cell.frame.size.width
        //                cell.layer.cornerRadius = 0
        //                animation.toValue = 0
        //                animation.duration = 1
        //                cell.layer.add(animation, forKey: animation.keyPath)
    }
}

// MARK: - API CALLING
extension YourPreferenceVC{
    func api_Call_Get_Board_Course_List()
    {
        //        showActivityIndicator()
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
            //                           self.hideActivityIndicator()
            print("The network is not reachable")
            self.prefernceCollVw.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request("https://webservice.testcraft.in/WebService.asmx/Get_Board_Course_List", method: .post, parameters: nil, headers: headers).validate().responseJSON { response in
            //self.hideActivityIndicator()

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
                        for (index,value) in arrData.enumerated() {

                            if let arrStandard1 = json["data"][index]["Standard"].array{
                                arrStandard.removeAll()
                                for (_,value) in arrStandard1.enumerated(){
                                    let ChildModelStandard:StandardList = StandardList.init(ID: value["ID"].stringValue, Name: value["Name"].stringValue, Icon: "\(API.imageUrl)\(value["Icon"].stringValue)", selected: "0")
                                    arrStandard.append(ChildModelStandard)
                                }

                                if(index == 0){
                                    ChildModel = subPreferenceList.init(courseTypeID: value["CourseTypeID"].intValue, id: value["ID"].stringValue, Headertitle: value["Name"].stringValue, icon: value["Icon"].stringValue, selected: "1", arrStandard: arrStandard)
                                }else{
                                    ChildModel = subPreferenceList.init(courseTypeID: value["CourseTypeID"].intValue, id: value["ID"].stringValue, Headertitle: value["Name"].stringValue, icon: value["Icon"].stringValue, selected: "0", arrStandard: arrStandard)
                                }

                                self.arrPreferenceList.append(ChildModel)
                            }

                        }
                    }
                    self.prefernceCollVw.reloadData()
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
    
}
