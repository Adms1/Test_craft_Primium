//
//  ExpiredCell.swift
//  TestCraftLite
//
//  Created by ADMS on 23/04/21.
//

import UIKit

class ExpiredCell: UITableViewCell {


    

    @IBOutlet var vwExpiredShadow:UIView!
    @IBOutlet var btnExpiredBuyClick:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
