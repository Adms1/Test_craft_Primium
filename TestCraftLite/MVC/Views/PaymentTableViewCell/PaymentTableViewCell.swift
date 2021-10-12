//
//  PaymentTableViewCell.swift
//  TestCraftLite
//
//  Created by ADMS on 02/04/21.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var lbl_ET_ID:UILabel!
    @IBOutlet var lbl_P_Date:UILabel!
    @IBOutlet var lbl_P_Amount:UILabel!
    @IBOutlet var lblMsg:UILabel!
    @IBOutlet var headerHeight:NSLayoutConstraint!
    @IBOutlet var btnTryAgain:UIButton!
    @IBOutlet var btnInvoice:UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
