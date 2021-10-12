//
//  TutorModel.swift
//  TestCraftLite
//
//  Created by ADMS on 06/04/21.
//

import Foundation

class TutorModel{
    var Status:String
    var Msg:String
    var data:[arrTutorModel]

    init(Status:String, Msg:String, data:[arrTutorModel]) {
        self.Status = Status
        self.Msg = Msg
        self.data = data
    }
}

class arrTutorModel {
    var TutorID:Int
    var TutorName:String
    var TutorEmail:String
    var TutorPhoneNumber:String
    var InstituteName:String
    var Icon:String
    var TotalRateCount:String
    var TutorStars:String
    var TutorDescription:String

    init(TutorID:Int, TutorName:String, TutorEmail:String, TutorPhoneNumber:String, InstituteName:String, Icon:String, TotalRateCount:String, TutorStars:String, TutorDescription:String) {
        self.TutorID = TutorID
        self.TutorName = TutorName
        self.TutorEmail = TutorEmail
        self.TutorPhoneNumber = TutorPhoneNumber
        self.InstituteName = InstituteName
        self.Icon = Icon
        self.TotalRateCount = TotalRateCount
        self.TutorStars = TutorStars
        self.TutorDescription = TutorDescription
    }
}
