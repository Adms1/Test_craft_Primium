//
//  TutorCell.swift
//  TestCraftLite
//
//  Created by ADMS on 06/04/21.
//

import UIKit

class TutorCell: UITableViewCell {

    @IBOutlet var lblBoard:UILabel!
    @IBOutlet var lblTutorNAme:UILabel!
    @IBOutlet var lblSubject:UILabel!
    @IBOutlet var vwStarRating:UIView!
    @IBOutlet var imgTutor:UIImageView!
    @IBOutlet var cellVw:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
