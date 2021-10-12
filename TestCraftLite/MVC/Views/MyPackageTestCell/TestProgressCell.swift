//
//  TestProgressCell.swift
//  TestCraftLite
//
//  Created by ADMS on 04/04/21.
//

import UIKit

class TestProgressCell: UITableViewCell {

    var progressRing: CircularProgressBar!
    @IBOutlet var viewProgressTestReport : UIView!
    @IBOutlet var lblAvilableTests:UILabel!
    @IBOutlet var lblGivenTest:UILabel!
    @IBOutlet var lblPercentage:UILabel!
    @IBOutlet var btnSummaryReport:UIButton!
    @IBOutlet var btnKnowlageGapReport:UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
