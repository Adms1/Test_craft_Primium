//
//  TamplateTableViewCell.swift
//  TestCraftLite
//
//  Created by ADMS on 05/04/21.
//

import UIKit

class TamplateTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var topbgView1:UIView!
    @IBOutlet var lblSectionname:UILabel!
    @IBOutlet var lblQuestionTypeName:UILabel!
    @IBOutlet var lblNoOfQue:UILabel!
    @IBOutlet var lblMarks:UILabel!
    @IBOutlet var lblTotalMarks:UILabel!
    @IBOutlet var lblSectionInstruction:UILabel!

    @IBOutlet var headerHeight:NSLayoutConstraint!
//    @IBOutlet var btnTryAgain:UIButton!
//    @IBOutlet var btnInvoice:UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
