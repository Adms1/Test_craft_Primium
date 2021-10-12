//
//  TestCraftTblCell.swift
//  TestCraftLite
//
//  Created by ADMS on 02/04/21.
//

//import UIKit
//
//class TestCraftTblCell: UITableViewCell {
//
//    @IBOutlet var lblHeaderTitle:UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}

//
//  DashboardTblCell.swift
//  TestCraftLite
//
//  Created by ADMS on 31/03/21.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder
import Alamofire
import SwiftyJSON


protocol popupDelegate: class {
    func passDataDict(dictResponce:JSON,Board:String,Standard:String,CourseTypeID:Int,BoardId:Int,StandardId:Int,sectionSelected:Int,indexPathSelected:Int,selectedProductId:String)

  //  func isUserLoggedIn(isUserLogin:Bool)
}

class TestCraftTblCell: UITableViewCell
{
    @IBOutlet weak var myCollView: UICollectionView!
    var arrPreferenceList  = [subPreferenceList]()
    weak var delegatePopUp: popupDelegate?

    var selectedSection:Int = -1
    var selectedIndexpath:Int = -1
    //    var arrImages:[Image]? {
    //
    //        didSet{
    //            myCollView.reloadData()
    //        }
    //        willSet(newVaaue){
    //            arrImages?.removeAll()
    //            arrImages=newVaaue
    //        }

    // }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.myCollView.showsHorizontalScrollIndicator = false
        self.myCollView.showsVerticalScrollIndicator = false

    }
    func fillCollectionView(with array: [subPreferenceList],sectionSet:Int) {
        self.arrPreferenceList.removeAll()
        self.arrPreferenceList = array
        selectedSection = sectionSet
        print("index",selectedSection)
        print("arrStandard.count",self.arrPreferenceList[selectedSection].arrStandard.count)
        self.myCollView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
extension TestCraftTblCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        if (selectedSection == 0){
//            let width = (collectionView.frame.size.width)  //some width
//            let height = (collectionView.frame.size.width - 40) / 3 * 1.5 //ratio
//            return CGSize(width: width, height: height)
//        }else{
            let width = (collectionView.frame.size.width)  //some width
            let height = (collectionView.frame.size.width - 40) / 3 * 1.5 //ratio
            return CGSize(width: width/2 + 100, height: height)
      //  }

    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            // `collectionView.contentSize` has a wrong width because in this nested example, the sizing pass occurs before the layout pass,
            // so we need to force a layout pass with the correct width.
            self.contentView.frame = self.bounds
            self.contentView.layoutIfNeeded()
            // Returns `collectionView.contentSize` in order to set the UITableVieweCell height a value greater than 0.
            return self.myCollView.contentSize
        }

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


//        print("arrecount",arrPreferenceList[selectedSection].arrStandard.count)
        return arrPreferenceList[selectedSection].arrStandard.count
    }



    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ContentCollectionViewCell
        //            cell.backgroundColor =  UIColor.green
        //            return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCraftCollectionVWCell", for: indexPath) as! TestCraftCollectionVWCell
//        if (selectedSection == 0) {
////            cell.standardImage.sd_setImage(with: URL(string: arrPreferenceList[selectedSection].Icon), completed: nil)
//            cell.standardImage.image = UIImage(named: "\(arrPreferenceList[selectedSection].arrStandard[indexPath.row].Icon)")
//            print("fiximage",arrPreferenceList[selectedSection].arrStandard[indexPath.row].Icon)
//        }else{
//            let SVGCoder = SDImageSVGCoder.shared
//            SDImageCodersManager.shared.addCoder(SVGCoder)
            cell.standardImage.sd_setImage(with: URL(string: API.boardImageBannerUrl + arrPreferenceList[selectedSection].arrStandard[indexPath.row].Icon))
      //  }

        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedIndexpath = indexPath.row

        var productId:String = ""


        if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "JEE Main"{
            productId = "com.testcraft.tcprimium.JEEMAIN"
        }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "JEE Advance"{
            productId = "com.testcraft.tcprimium.JEEADVANCE"
        }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "GUJCET - English"{
            productId = "com.testcraft.tcprimium.GUJCETENGLISH"
        }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "GUJCET - Gujarati"{
            productId = "com.testcraft.tcprimium.GUJCETGUJARATI"
        }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "NEET"{
            productId = "com.testcraft.tcprimium.NEET"
        }else if arrPreferenceList[selectedSection].Name == "CBSE"
        {
            if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "12th (Science)"{
                productId = "com.testcraft.tcprimium.CBSC12SCIENCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "11th (Science)"{
                productId = "com.testcraft.tcprimium.CBSC11SCEINCE"
            }
            else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "12th (Commerce)"{
                productId = "com.testcraft.tcprimium.CBSC12COMMERCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "11th (Commerce)"{
                productId = "com.testcraft.tcprimium.CBSC11COMMERCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "10th"{
                productId = "com.testcraft.tcprimium.CBSC10STD"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "9th"{
                productId = "com.testcraft.tcprimium.CBSC9STD"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "8th"{
                productId = "com.testcraft.tcprimium.CBSC8STD"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "7th"{
                productId = "com.testcraft.tcprimium.CBSC7STD"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "6th"{
                productId = "com.testcraft.tcprimium.CBSC6STD"
            }
        }


        else if arrPreferenceList[selectedSection].Name == "GSEB (English Medium)"
        {
            if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "12th (Science)"{
                productId = "com.testcraft.tcprimium.GSEBENGLISH12SCEINCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "11th (Science)"{
                productId = "com.testcraft.tcprimium.GSEBENGLISH11SCIENCE"
            }
            else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "12th (Commerce)"{
                productId = "com.testcraft.tcprimium.GSEBENGLISH12COMMERCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "11th (Commerce)"{
                productId = "com.testcraft.tcprimium.GSEBENGLISH11COMMERCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "10th"{
                productId = "com.testcraft.tcprimium.GSEBENGLISH10STD"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "9th"{
                productId = "com.testcraft.tcprimium.GSEBENGLISH9STD"
            }
        }


        else if arrPreferenceList[selectedSection].Name == "GSEB (Gujarati Medium)"
        {
            if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "12th (Science)"{
                productId = "com.testcraft.tcprimium.GSEB12SCIENCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "11th (Science)"{
                productId = "com.testcraft.tcprimium.GSEB11SCIENCE"
            }
            else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "12th (Commerce)"{
                productId = "com.testcraft.tcprimium.GSEB12COMMERCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "11th (Commerce)"{
                productId = "com.testcraft.tcprimium.GSEB11COMMERCE"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "10th"{
                productId = "com.testcraft.tcprimium.GSEB10STD"
            }else if arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name == "9th"{
                productId = "com.testcraft.tcprimium.GSEB9STD"
            }
        }




//        if UserDefaults.standard.object(forKey: "isLogin") != nil{
//            let result = UserDefaults.standard.value(forKey: "isLogin")! as! NSString
//            if(result == "1")
//            {
        self.api_Call_Get_CourseDetail_Lite(CourseTypeID: "\(arrPreferenceList[selectedSection].CourseTypeID)", CourseID: "\(arrPreferenceList[selectedSection].arrStandard[indexPath.row].ID)", BoardID: "\(arrPreferenceList[selectedSection].ID)", StandardID: "\(arrPreferenceList[selectedSection].arrStandard[indexPath.row].ID)", Standard: arrPreferenceList[selectedSection].arrStandard[indexPath.row].Name, Board: arrPreferenceList[selectedSection].Name, productId: productId)
//            }
//        }else{
//            delegatePopUp?.isUserLoggedIn(isUserLogin: false)
//        }
    }
}

extension TestCraftTblCell{
    func api_Call_Get_CourseDetail_Lite(CourseTypeID:String,CourseID:String,BoardID:String,StandardID:String,Standard:String,Board:String,productId:String)
    {
        //        showActivityIndicator()
        //        self.arrHeaderSubTitle.removeAll()
         let params = ["CourseTypeID":CourseTypeID,"CourseID":CourseID,"BoardID":BoardID,"StandardID":StandardID]

        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        //        print("API, Params: \n",API.Get_Course_ListApi,params)
        if !Connectivity.isConnectedToInternet() {
                    //    self.AlertPopupInternet()

            // show Alert
             //                          self.hideActivityIndicator()
            print("The network is not reachable")
          //  self.myTableView.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }

        Alamofire.request("https://webservice.testcraft.in/WebService.asmx/Get_CourseDetail_Lite", method: .get, parameters: params, headers: headers).validate().responseJSON { [self] response in
          //  self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
               // self.arrPreferenceList.removeAll()
                if(json["Status"] == "true" || json["Status"] == "1") {
                   // print(json["data"].dictionary)
                   // if let dict = json["data"].dictionary{
                    delegatePopUp?.passDataDict(dictResponce: json, Board: Board, Standard: Standard, CourseTypeID: Int(CourseTypeID) ?? 0, BoardId: Int(BoardID) ?? 0, StandardId: Int(StandardID) ??  0, sectionSelected: selectedSection, indexPathSelected: selectedIndexpath, selectedProductId: productId)
                  //  }
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
                   // self.view.makeToast("\(json["Msg"].stringValue)", duration: 3.0, position: .bottom)
                }
            case .failure(let _): break
              //  self.view.makeToast("Somthing wrong...", duration: 3.0, position: .bottom)
            }
        }
    }
}
