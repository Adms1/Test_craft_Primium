//
//  StudentTestSWAnalysisVC.swift
//  TestCraft
//
//  Created by ADMS on 12/02/20.
//  Copyright © 2020 ADMS. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON
//import SJSwiftSideMenuController
import SDWebImage

class StudentTestSWAnalysisVC: UIViewController, ActivityIndicatorPresenter {
    var activityIndicatorView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var imgView = UIImageView()

    var strTestID = ""
    var strStudentTestID = ""
    var strPass = ""
    var strTitle = ""
    var strTestType = ""
    var TotalQue = ""
    var isSelected = -1
    var arrStudentTestSWAnalysis = [StudentTestSWAnalysisListModal]()
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tblSWAnalysis:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Pre_Submit_Test_Api()
    }
    
    
    @IBAction func Back_Clicked(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: false)
        //            for controller in self.navigationController!.viewControllers as Array {
        //                //Bhargav Hide
        //    ////print(controller)
        //                if controller.isKind(of: TestListVC.self) {
        //                    self.navigationController!.popToViewController(controller, animated: true)
        //                    break
        //                }else if controller.isKind(of: MarketPlaceMultiBoxVC.self) {
        //                    //                            self
        //                    controller.tabBarController!.selectedIndex = 0
        //                    //                                controller.tabBarController?.tabBarItem
        //                    self.navigationController!.popToViewController(controller, animated: false)
        //                    break
        //                }
        //            }
    }
    func Pre_Submit_Test_Api()
    {
        //                api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2003", comment: "Submit Icon", isFirstTime: "0")
        //                self.viewSubmitPopup.isHidden = false
        showActivityIndicator()
        let params = ["StudentTestID":strStudentTestID]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //Bhargav Hide
        print("API, Params: \n",API.Get_StudentTest_SW_AnalysisApi,params)
        if !Connectivity.isConnectedToInternet() {
                    self.AlertPopupInternet()

            // show Alert
            self.hideActivityIndicator()
            print("The network is not reachable")
            self.tblSWAnalysis.reloadData()
            // self.view.makeToast("The network is not reachable", duration: 3.0, position: .bottom)
            return
        }
        
        Alamofire.request(API.Get_StudentTest_SW_AnalysisApi, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
            self.hideActivityIndicator()
            self.arrStudentTestSWAnalysis.removeAll()
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                //Bhargav Hide
                print(json)
                if(json["Status"] == "true" || json["Status"] == "1") {
                    let arrData = json["data"]//.array
                    //                            for value in arrData! {
                    var arrWeaknessModal = [StudentTestSWAnalysisListModal]()
                    var arrStrengthModal = [StudentTestSWAnalysisListModal]()
                    
                    let arrWeakness = arrData["Weakness"].array
                    let arrStrength = arrData["Strength"].array
                    
                    for values in arrWeakness! {
                        let subListModel:StudentTestSWAnalysisListModal = StudentTestSWAnalysisListModal.init(id: "", subtitle: "\(values)")
                        arrWeaknessModal.append(subListModel)
                    }
                    for values in arrStrength! {
                        let subListModel:StudentTestSWAnalysisListModal = StudentTestSWAnalysisListModal.init(id: "", subtitle: "\(values)")
                        arrStrengthModal.append(subListModel)
                    }
                    
                    let tempWeaknessModel:StudentTestSWAnalysisListModal = StudentTestSWAnalysisListModal.init(id: "", title: "Weakness", isSelected: "1",arrSubList: arrWeaknessModal)
                    let tempStrengthModel:StudentTestSWAnalysisListModal = StudentTestSWAnalysisListModal.init(id: "", title: "Strengths", isSelected: "1",arrSubList: arrStrengthModal)
                    
                    self.arrStudentTestSWAnalysis.append(tempStrengthModel)
                    self.arrStudentTestSWAnalysis.append(tempWeaknessModel)
                    
                    // }
                    
                    self.tblSWAnalysis.reloadData()
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
        self.tblSWAnalysis.reloadData()
        
    }
    
}
extension StudentTestSWAnalysisVC: UITableViewDataSource, UITableViewDelegate {
    @objc func ReadAgainClicked(sender: UIButton) {
        let buttonTag = sender.tag
        let Setected = "\(arrStudentTestSWAnalysis[buttonTag].isSelected ?? "")"
        
        if Setected == "1" {
            //        if isSelected == buttonTag{
            //            isSelected = -1
            arrStudentTestSWAnalysis[buttonTag].isSelected = "0"
            self.tblSWAnalysis.reloadData()
        }else{
            //        isSelected = buttonTag
            arrStudentTestSWAnalysis[buttonTag].isSelected = "1"
            self.tblSWAnalysis.reloadData()
        }
        // Do any additional setup
        //        if arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review == "1"
        //        {
        //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review = "0"
        //        }
        //        else
        //        {
        //            arrQueAns[self.strSectionSelectedIndex].arr_section_que[strSelectedIndex].mark_as_review = "1"
        //        }
        //        api_Activity_Action(Type: "1", gameid: "", gamesessionid: "\(UserDefaults.standard.value(forKey: "TrackTokenID") ?? "")", actionid: "2004", comment: "Flag", isFirstTime: "0")
        //
        //        Continue_Send_Request_Que_wish_ans_Api()
        //        //        self.quecollectionView.reloadData()
        //        self.tblSWAnalysis.reloadData()
        //        self.reloadView()
        
        //        UIView.transition(with: self.tblSWAnalysis,
        //                          duration: 0.35,
        //                          options: .curveEaseInOut,
        //                          animations: { self.tblSWAnalysis.reloadData() })
        //
        //        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50//UITableView.automaticDimension
        
    }
    
    // 4
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
    //        viewHeader.backgroundColor = UIColor.darkGray // Changing the header background color to gray
    //        return viewHeader
    //    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView:SwAnalysisHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SwAnalysisHeaderTableViewCell") as! SwAnalysisHeaderTableViewCell //as! SwAnalysisTableViewCell
        headerView.lblTitle.text = "\(arrStudentTestSWAnalysis[section].title ?? "")"
        headerView.imgIcon.isHidden = true
        
        if headerView.lblTitle.text == "Weakness"
        {
            headerView.topbgView1.backgroundColor = GetColor.tomatoRed
            headerView.bottomBorderView.backgroundColor = GetColor.tomatoRed
        }else
        {
            headerView.topbgView1.backgroundColor = GetColor.darkGreen
            headerView.bottomBorderView.backgroundColor = GetColor.darkGreen
        }
        headerView.topbgView1.addShadowWithRadius(0,8,0,color: UIColor.darkGray)
        //            headerView.topbgView1.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
        
        //            headerView.topbgView1.backgroundColor = UIColor.clear
        headerView.lblTitle.textColor = GetColor.whiteColor
        headerView.imgDerctionIcon.isHidden = true
        let Setected = "\(arrStudentTestSWAnalysis[section].isSelected ?? "")"
        if Setected == "1"
        {
            let image : UIImage = UIImage(named:"down-arrow-icon")!
            headerView.imgDerctionIcon.image = image
            //                userHeader.imgDerctionIcon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI));
        }
        else
        {
            let image : UIImage = UIImage(named:"up-arrow-icon")!
            headerView.imgDerctionIcon.image = image//UIImageView(image: <#T##UIImage?#>)
            //                self.DashButton.imageView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
        }
        
        headerView.btnExpand.tag = section
        //            headerView.btnExpand.addTarget(self, action: #selector(ReadAgainClicked), for: .touchUpInside)
        
        //        //        headerView.headerHeight.constant = section == 0 ? 50 : 0
        //        //        headerView.lblView.superview?.addShadowWithRadius(2.0, 0, 0)
        //
        //        //        if section == selectedIndex {
        //        //            headerView.lblView.textColor = GetColor.green
        //        //        }else{
        //        //            headerView.lblView.textColor = .red
        //        //        }
        //        //        headerView.imgQueAns.setImageWithFadeFromURL(url: URL.init(string: "https://content.testcraft.co.in/question/" + (arrQueAns[section].QueImgLink).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!, placeholderImage: Constants.studentPlaceholder, animationDuration: 0.5, finish: {
        //        //            let aspectRatio = (headerView.imgQueAns.image! as UIImage).size.height/(headerView.imgQueAns.image! as UIImage).size.width
        //        //            //            cell.articleImage.image = image
        //        //            let imageHeight = self.view.frame.width*aspectRatio
        //        //            tableView.beginUpdates()
        //        //            self.rowHeaderHeights[section] = imageHeight
        //        //            tableView.endUpdates()
        //        //
        //        //        })
        //        //        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(expandCollapseSection(_:)))
        //        //        headerView.lblView.tag = section
        //        //        headerView.lblView.addGestureRecognizer(tapGesture)
        //        //        headerView.displayHeaderData(arrViewLessonPlanData[section])
        //        //        headerView.btnWord.addTarget(self, action: #selector(btnWordClikedAction(_:)), for: .touchUpInside)
        
        return headerView//arrQueAns.count > 0 ? headerView.contentView : nil
    }
    
    //        func numberOfSections(in tableView: UITableView) -> Int {
    //            if arrQueAns.count > 0
    //            {
    //                return 1//arrQueAns.count
    //            }
    //            else
    //            {
    //                return 0
    //            }
    //        }
    //
    //        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //            //        tableView.estimatedSectionHeaderHeight = 110
    //            //        return 50//UITableView.automaticDimension
    //            //        if let height = self.rowHeaderHeights[section]{
    //            //            return height
    //            //        }else{
    //            return 40
    //            //        }
    //        }
    
    // 5
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrStudentTestSWAnalysis.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 6 Change the number of row in section as per your uses
        let Setected = "\(arrStudentTestSWAnalysis[section].isSelected ?? "")"
        
        if Setected == "1" {
            return arrStudentTestSWAnalysis[section].arrSubList.count
        }else
        {
            return 0
        }
    }
    // 7
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        cell.textLabel?.text = "section: \(indexPath.section)  row: \(indexPath.row)"
        let identifier = "SwAnalysisTableViewCell"
        var cell: SwAnalysisTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? SwAnalysisTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "SwAnalysisTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SwAnalysisTableViewCell
        }
        cell.lblTitle.text = "\u{2022} \(arrStudentTestSWAnalysis[indexPath.section].arrSubList[indexPath.row].subtitle ?? "")"
        cell.imgIcon.isHidden = true
        cell.imgDerctionIcon.isHidden = true
        let strTitle = "\(arrStudentTestSWAnalysis[indexPath.section].title ?? "")"
        
        if strTitle == "Weakness"
        {
            cell.contentView.backgroundColor = GetColor.tomatoRed
            cell.bottomBorderView.backgroundColor = GetColor.tomatoRed
        }else
        {
            cell.contentView.backgroundColor = GetColor.darkGreen
            cell.bottomBorderView.backgroundColor = GetColor.darkGreen
        }
        
        //        headerView.contentView.addShadowWithRadius(3,8,0,color: UIColor.darkGray)
        
        cell.topbgView1.backgroundColor = GetColor.whiteColor
        cell.lblTitle.textColor = GetColor.blackColor
        cell.bottomBorderView.isHidden = true
        print(arrStudentTestSWAnalysis[indexPath.section].arrSubList.count - 1,indexPath.row)
        if arrStudentTestSWAnalysis[indexPath.section].arrSubList.count - 1 == indexPath.row
        {
            print("same index........")
            //            cell.contentView.addShadowWithRadius(0,8,0,color: UIColor.darkGray)
            //            cell.bottomBorderView.addShadowWithRadius(0,8,0,color: UIColor.darkGray)
            //            var border = UIView(frame: CGRect(x: cell.contentView.bounds,y: 39,width: self.view.bounds.width,height: 1))
            //            border.backgroundColor = getColor
            //            cell.contentView.addSubview(border)
            cell.bottomBorderView.isHidden = false
            
        }else
        {
            cell.bottomBorderView.backgroundColor = GetColor.whiteColor
        }
        
        //        cell.lbl_Title.text = "\(self.arrSubmitSummary[indexPath.row].title ?? "")"
        //        cell.lbl_Attempted.text = "\(self.arrSubmitSummary[indexPath.row].Attempted ?? "")"
        //        cell.lbl_NotAttempted.text = "\(self.arrSubmitSummary[indexPath.row].NotAttempted ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //        if (cell.responds(to: #selector(getter: UIView.tintColor))){
        if tableView == self.tblSWAnalysis {
            let cornerRadius: CGFloat = 12.0
            cell.backgroundColor = .clear
            let layer: CAShapeLayer = CAShapeLayer()
            let path: CGMutablePath = CGMutablePath()
            let bounds: CGRect = cell.bounds
            bounds.insetBy(dx: 25.0, dy: 0.0)
            var addLine: Bool = false
            
            if indexPath.row == 0 && indexPath.row == ( tableView.numberOfRows(inSection: indexPath.section) - 1) {
                path.addRoundedRect(in: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
                
            } else if indexPath.row == 0 {
                path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
                path.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
                path.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
                path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
                
            } else if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
                path.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
                path.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
                path.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
                path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
                
            } else {
                path.addRect(bounds)
                addLine = true
            }
            
            layer.path = path
            layer.fillColor = UIColor.white.withAlphaComponent(0.8).cgColor
            
            if addLine {
                let lineLayer: CALayer = CALayer()
                let lineHeight: CGFloat = 1.0 / UIScreen.main.scale
                lineLayer.frame = CGRect(x: bounds.minX + 10.0, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight)
                lineLayer.backgroundColor = tableView.separatorColor?.cgColor
                layer.addSublayer(lineLayer)
            }
            
            let testView: UIView = UIView(frame: bounds)
            testView.layer.insertSublayer(layer, at: 0)
            testView.backgroundColor = .clear
            cell.backgroundView = testView
        }
    }
    //    }
    
}
