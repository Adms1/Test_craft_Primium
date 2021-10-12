//
//  SectionTemplateListModal.swift
//  TestCraftLite
//
//  Created by ADMS on 05/04/21.
//

import Foundation

class SectionTemplateListModal {
//    SubjectName: "Physics",
//    SubjectID: "12",
//    Sectionname: "Physics",
//    QuestionTypeID: "1",
//    QuestionTypeName: "MCQ",
//    NoOfQue: "45",
//    Marks: "4.00",
//    NegativeMarks: "1.00",
//    SectionInstruction:

    var SubjectID             :String?
    var SubjectName           :String?
    var Sectionname           :String?
    var QuestionTypeID        :String?
    var QuestionTypeName      :String?
    var NoOfQue               :String?
    var Marks                 :String?
    var NegativeMarks         :String?
    var SectionInstruction    :String?
    var TotalMarks            :String?

    init(SubjectID:String, SubjectName:String, Sectionname:String, QuestionTypeID:String, QuestionTypeName:String, NoOfQue:String, Marks:String, NegativeMarks:String, SectionInstruction:String, TotalMarks:String) {
        self.SubjectID = SubjectID
        self.SubjectName = SubjectName
        self.Sectionname = Sectionname
        self.QuestionTypeID = QuestionTypeID
        self.QuestionTypeName = QuestionTypeName
        self.NoOfQue = NoOfQue
        self.Marks = Marks
        self.NegativeMarks = NegativeMarks
        self.SectionInstruction = SectionInstruction
        self.TotalMarks = TotalMarks
    }
}
