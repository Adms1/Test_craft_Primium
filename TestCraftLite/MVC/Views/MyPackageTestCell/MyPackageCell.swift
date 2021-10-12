//
//  MyPackageCell.swift
//  TestCraftLite
//
//  Created by ADMS on 04/04/21.
//

import UIKit

class MyPackageCell: UITableViewCell {

    @IBOutlet var lblTestName:UILabel!
    @IBOutlet var lblAttemptTotalTest:UILabel!
    @IBOutlet var lblTestSubjectName:UILabel!
    @IBOutlet var imgOfSubject:UIImageView!
    @IBOutlet var imgAnalysis:UIImageView!
    @IBOutlet var btnBuyClick:UIButton!
    @IBOutlet var lblPackagePrice:UILabel!
    @IBOutlet var lblTutorname:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
