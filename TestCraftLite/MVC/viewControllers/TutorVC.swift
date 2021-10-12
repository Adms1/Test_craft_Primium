//
//  TutorVC.swift
//  TestCraftLite
//
//  Created by ADMS on 06/04/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift
import SDWebImage

class TutorVC: UIViewController ,ActivityIndicatorPresenter{
    
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var arrTutorList = [arrTutorModel]()

    @IBOutlet weak var tblTutorList:UITableView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var btnFilter:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = "Curator"

        tblTutorList.delegate = self
        tblTutorList.dataSource = self


        btnFilter.layer.cornerRadius = 6.0
        btnFilter.layer.masksToBounds = true

        btnFilter.layer.borderWidth = 0.5
        btnFilter.layer.borderColor = UIColor.lightGray.cgColor


    }
    override func viewWillAppear(_ animated: Bool) {
        api_Call_Get_Tutor()
    }

    @IBAction func btnClickBack(){
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension TutorVC:UITableViewDelegate,UITableViewDataSource{
    //MARK:Tableview Delegates and Datasource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTutorList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->  CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TutorCell", for: indexPath) as! TutorCell

      //  cell.imgTutor.sd_setImage(with: URL(string: API.imageUrl + arrTutorList[indexPath.row].Icon))

        
        cell.imgTutor.layer.cornerRadius = cell.imgTutor.layer.frame.width/2.0
        cell.imgTutor.layer.masksToBounds = true

        cell.lblBoard.text = arrTutorList[indexPath.row].InstituteName
        cell.lblTutorNAme.text = arrTutorList[indexPath.row].TutorName
        cell.lblSubject.text = arrTutorList[indexPath.row].TutorPhoneNumber

        cell.vwStarRating.isHidden = true
        cell.selectionStyle = .none
        
        cell.cellVw.layer.cornerRadius = 6.0
        cell.cellVw.layer.masksToBounds = true
        //cell.myCollView.reloadData()
        return cell
    }
}
extension TutorVC{
    func api_Call_Get_Tutor()
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
            self.tblTutorList.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
//        Get_TutorNameBy_Criteria_Lite(string CourseTypeID, string BoardID, string CourseID, string StandardID, string SubjectID)
        Alamofire.request("https://webservice.testcraft.in/WebService.asmx/Get_TutorNameBy_Criteria_Lite", method: .post, parameters: nil, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()

            switch response.result {
            case .success(let value):

                let json = JSON(value)
                //Bhargav Hide
                print(json)
             //   self.arrPreferenceList.removeAll()
                if(json["Status"] == "true" || json["Status"] == "1") {
                    if let arrData = json["data"].array{
                        for (_,value) in arrData.enumerated() {

                            let objdict = arrTutorModel(
                                TutorID: value["TutorID"].intValue, TutorName: value["TutorName"].stringValue, TutorEmail: value["TutorEmail"].stringValue, TutorPhoneNumber: value["TutorPhoneNumber"].stringValue, InstituteName: value["InstituteName"].stringValue, Icon: value["Icon"].stringValue, TotalRateCount: value["TutorStars"].stringValue, TutorStars: value["TutorStars"].stringValue, TutorDescription: value["TutorDescription"].stringValue)
                            self.arrTutorList.append(objdict)
                        }
                    }
                    self.tblTutorList.reloadData()
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
}
