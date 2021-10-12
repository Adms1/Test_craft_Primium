//
//  HeaderCollectionViewCell.swift
//  ExandableDemo
//
//  Created by ADMS on 23/03/21.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bgView:UIView!
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var imgIcon:UIImageView!
    @IBOutlet var imgDerctionIcon:UIImageView!

    func displayData(_ folderName:String, _ strImageName:String) {

        lblTitle.text = strImageName
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
