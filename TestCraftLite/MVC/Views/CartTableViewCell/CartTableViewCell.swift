//
//  CartTableViewCell.swift
//  TestCraftLite
//
//  Created by ADMS on 02/04/21.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var lbl_Title:UILabel!
    @IBOutlet var lbl_SubTitle:UILabel!
    @IBOutlet var lbl_Price:UILabel!
    @IBOutlet var lblMsg:UILabel!
    @IBOutlet var headerHeight:NSLayoutConstraint!
    @IBOutlet var btnTryAgain:UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
