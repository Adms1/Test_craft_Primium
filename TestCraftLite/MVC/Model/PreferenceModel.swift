//
//  PreferenceModel.swift
//  TestCraftLite
//
//  Created by ADMS on 24/03/21.
//

import Foundation

class MainPreference{
    var Status:String
    var Msg:String
    var data:[subPreferenceList]

    init(Status:String, Msg:String, data:[subPreferenceList]) {
        self.Status = Status
        self.Msg = Msg
        self.data = data
    }
}

class subPreferenceList{
    var CourseTypeID:Int
    var ID:String
    var Name:String
    var Icon:String
    var selected:String
    var arrStandard:[StandardList]

    init(courseTypeID:Int,id:String, Headertitle:String, icon:String, selected:String, arrStandard:[StandardList]) {
        self.CourseTypeID = courseTypeID
        self.ID = id
        self.Name = Headertitle
        self.Icon = icon
        self.selected = selected
        self.arrStandard = arrStandard

    }
}
class StandardList{
    var ID:String
    var Name:String
    var Icon:String
    var selected:String
    
    init(ID:String, Name:String, Icon:String,selected:String) {
        self.ID = ID
        self.Name = Name
        self.Icon = Icon
        self.selected = selected
    }
}

class Que_Ans_Model {

    var title:String = ""
    var que_no:String = ""
    var que_id:String = ""
    var que_type:String = ""
    var total_timer:String = ""
    var current_time:String = "" //my ans time
    var isVisited:String = ""
    var isCorrectAnswer:String = ""
    var isAnsTrue:String = ""
    var report_issue:String = ""
    var mark_as_review:String = ""
    var que_ans:[Que_Ans_Model] = []
    var test_que_id:String = ""
    var str_marks:String = ""
    var str_answered:String = ""
    var str_ans:String = ""
    var str_Hint:String = ""
    var str_HintUsed:String = ""
    var str_Explanation:String = ""
    var str_SystemAnswer:String = ""
    var str_YourAnswer:String = ""


    var id:String = ""
    var display_no:String = ""
    var name:String = ""
    var type:String = "" // Q or A
    var img_link:String = ""
    var selected:String = ""

    var section_id = ""
    var section_name = ""
    var section_selected = ""
    var section_type = ""
    var section_description = ""
    var arr_section_que:[Que_Ans_Model] = []

//    var section_
    init(section_id:String, section_name:String, section_type:String, section_description:String, section_selected:String, arr_section_que:[Que_Ans_Model])
    {
        self.id = section_id
        self.section_name = section_name
        self.section_selected = section_selected
        self.section_type = section_type
        self.section_description = section_description
        self.arr_section_que = arr_section_que
        //        self.mark_as_review = mark_as_review
        //        self.selected = selected
    }

    init(title:String, que_no:String, que_id:String, que_type:String, total_timer:String, current_time:String, report_issue:String, mark_as_review:String, isVisited:String, isAnsTrue:String, que_ans:[Que_Ans_Model], test_que_id:String, str_marks:String, str_answered:String, str_ans:String, str_Hint:String, str_HintUsed:String, str_Explanation:String, str_system_answer:String, str_your_answer:String) {
        self.title = title
        self.que_no = que_no
        self.que_id = que_id
        self.que_type = que_type
        self.total_timer = total_timer
        self.current_time = current_time
        self.report_issue = report_issue
        self.mark_as_review = mark_as_review
        self.isVisited = isVisited
        self.isAnsTrue = isAnsTrue
        self.que_ans = que_ans //Array Struct
        self.test_que_id = test_que_id
        self.str_marks = str_marks
        self.str_answered = str_answered
        self.str_ans = str_ans
        self.str_Hint = str_Hint
        self.str_HintUsed = str_HintUsed
        self.str_Explanation = str_Explanation
        self.str_SystemAnswer = str_system_answer
        self.str_YourAnswer = str_your_answer
    }

    init(id:String, display_no:String, name:String, type:String, img_link:String, isCorrectAnswer:String, selected:String) {
        self.id = id
        self.display_no = display_no
        self.name = name
        self.type = type
        self.img_link = img_link
        self.isCorrectAnswer = isCorrectAnswer
//        self.report_issue = report_issue
//        self.mark_as_review = mark_as_review
        self.selected = selected
    }

}

class SubmitSummaryListModal {

    var id :String?
    var title  :String?
    var Attempted:String?
    var NotAttempted  :String?
    var SubjectName  :String?
    var TotalQue  :String?
    var ObtainMark  :String?

//    cell.lbl_Title.text = "section"
//    cell.lbl_Attempted.text = ""
//  /  cell.lbl_NotAttempted.text = ""

    init(id:String, title:String, Attempted:String, NotAttempted:String, SubjectName:String, TotalQue:String, ObtainMark:String) {
        self.id = id
        self.title = title
        self.Attempted = Attempted
        self.NotAttempted = NotAttempted
        self.SubjectName = SubjectName
        self.TotalQue = TotalQue
        self.ObtainMark = ObtainMark
    }
}
class StudentTestSWAnalysisListModal {

    var id :String?
    var title  :String?
    var subtitle  :String?
    var isSelected:String?
    var arrSubList = [StudentTestSWAnalysisListModal]()
//    var NotAttempted  :String?
//    var SubjectName  :String?
//    var TotalQue  :String?
//    var ObtainMark  :String?

//    cell.lbl_Title.text = "section"
//    cell.lbl_Attempted.text = ""
//  /  cell.lbl_NotAttempted.text = ""

    init(id:String, title:String, isSelected:String, arrSubList:[StudentTestSWAnalysisListModal])//, NotAttempted:String, SubjectName:String, TotalQue:String, ObtainMark:String)
    {
        self.id = id
        self.title = title
        self.isSelected = isSelected
        self.arrSubList = arrSubList
    }
    init(id:String, subtitle:String)//, isSelected:String)//, NotAttempted:String, SubjectName:String, TotalQue:String, ObtainMark:String)
    {
        self.id = id
        self.subtitle = subtitle
    }
}
