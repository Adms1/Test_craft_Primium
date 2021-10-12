//
//  SubCategory1ListModal.swift
//  TestCraftLite
//
//  Created by ADMS on 05/04/21.
//

import Foundation

class SubCategory1ListModal {

    var title  :String?
    var subTitle:String?
    var id :String?
    var image  :String?
    var selected  :String?

    init(id:String, title:String, subTitle:String, image:String, selected:String) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.selected = selected
    }
}
