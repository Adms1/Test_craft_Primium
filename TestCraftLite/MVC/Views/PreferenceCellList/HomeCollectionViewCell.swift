//
//  HomeCollectionViewCell.swift
//  TestCraftLite
//
//  Created by ADMS on 24/03/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bgView:UIView!
    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var lblSubTitle:UILabel!
    @IBOutlet var lblListPriceTitle:UILabel!
    @IBOutlet var lblAlertDot:UILabel!
    @IBOutlet var imgRightSelection:UIImageView!

    @IBOutlet var btnRemove:UIButton!

    func displayData(_ folderName:String, _ strImageName:String) {

        lblTitle.text = strImageName

//        if folderName == "Main" {
//            lblTitle.font = FontHelper.lato_bold(size: DeviceType.isIphone5 ? 15 : DeviceType.isIpad ? 24 : 18)
//        }else {
//            lblTitle.font = FontHelper.lato_bold(size: DeviceType.isIphone5 ? 13 : DeviceType.isIpad ? 22 : 16)
//        }
//        imgIcon.getImagesfromLocal(folderName, strImageName)
    }

}
