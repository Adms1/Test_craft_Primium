//
//  MyTestListCell.swift
//  TestCraftLite
//
//  Created by ADMS on 04/04/21.
//

import UIKit

class MyTestListCell: UITableViewCell {

    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblTestNAme:UILabel!
    @IBOutlet var lblMarks:UILabel!

    @IBOutlet var imgOfCreateTestSubject:UIImageView!
    @IBOutlet var imgCreateTestAnalysis:UIImageView!
    @IBOutlet var vwCreateList:UIView!
    @IBOutlet var vwCreateLine:UIView!

    @IBOutlet var lblMyTestHeight:NSLayoutConstraint!
    @IBOutlet var vwTotalHeight:NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
