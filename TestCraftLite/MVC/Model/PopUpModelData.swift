//
//  PopUpModelData.swift
//  TestCraftLite
//
//  Created by ADMS on 05/04/21.
//

import Foundation
class popUpMdelData{
    var Status:String
    var Msg:String
    var data:dictPopUpData

    init(Status:String, Msg:String, data:dictPopUpData) {
        self.Status = Status
        self.Msg = Msg
        self.data = data
    }
}
class dictPopUpData{
    var Name:String
    var Icon:String
    var TestCount:String
    var QuestionCount:String
    var arrStandard:[arrSubjectList]

    init(Name:String,Icon:String, TestCount:String, QuestionCount:String,arrStandard:[arrSubjectList]) {
        self.Name = Name
        self.TestCount = TestCount
        self.Icon = Icon
        self.QuestionCount = QuestionCount
        self.arrStandard = arrStandard
    }
}
class arrSubjectList{
    var SubjectName:String
    var Icon:String
    var SubjectID:Int

    init(SubjectName:String,Icon:String, SubjectID:Int) {
        self.SubjectName = SubjectName
        self.Icon = Icon
        self.SubjectID = SubjectID

    }
}
