//
//  TestModelData.swift
//  TestCraftLite
//
//  Created by ADMS on 07/04/21.
//

import Foundation

class TestModelData{
    var Status:String
    var Msg:String
    var data:[subPreferenceList]

    init(Status:String, Msg:String, data:[subPreferenceList]) {
        self.Status = Status
        self.Msg = Msg
        self.data = data
    }
}

class arrTestList{

    var SubjectName:String
    var TestName:String
    var NumberOfHintUsed:String
    var TestEndTime:String
    var TestDuration:String
    var CourseName:String
    var STGuiD:Int
    var TestInstruction:String
    var RemainTime:String
    var NumberOfHint:String
    var Icon:String
    var TutorName:String
    var Name:String
    var TotalQuestions:String
    var TestMarks:String

    var StatusName:String
    var IsCompetetive:String
    var TestStartTime:String
    var StudentTestID:Int
    var TestID:Int
    var TestGuiD:Int
    var TestPackageName:String
    var IsFree:String
    var Price:String
    var TestPackageID:Int

    init(SubjectName:String,TestName:String,NumberOfHintUsed:String,TestEndTime:String,TestDuration:String,CourseName:String,STGuiD:Int,TestInstruction:String,RemainTime:String,NumberOfHint:String,Icon:String,TutorName:String,Name:String,TotalQuestions:String,TestMarks:String,StatusName:String,IsCompetetive:String,TestStartTime:String,StudentTestID:Int,TestID:Int,TestGuiD:Int,TestPackageName:String,IsFree:String,Price:String,TestPackageID:Int) {
        self.SubjectName = SubjectName
        self.TestName = TestName
        self.NumberOfHintUsed = NumberOfHintUsed
        self.TestEndTime = TestEndTime
        self.TestDuration = TestDuration
        self.CourseName = CourseName
        self.STGuiD = STGuiD
        self.TestInstruction = TestInstruction
        self.RemainTime = RemainTime
        self.NumberOfHint = NumberOfHint
        self.Icon = Icon
        self.TutorName = TutorName
        self.Name = Name
        self.TotalQuestions = TotalQuestions
        self.TestMarks = TestMarks
        self.StatusName = StatusName
        self.IsCompetetive = IsCompetetive
        self.TestStartTime = TestStartTime
        self.StudentTestID = StudentTestID
        self.TestID = TestID
        self.TestGuiD = TestGuiD
        self.TestPackageName = TestPackageName
        self.IsFree = IsFree
        self.Price = Price
        self.TestPackageID = TestPackageID
    }
}

class getSubscriptionModel {
    var ID :Int?
    var isSubscription :String?
    var isCompetitive  :Bool?
    var StandardID:String?

    var Icon:String?
    var StandardName:String?
    var BannerIcon:String?
    var TestSummary:String?
    var Performance:String?

    var BoardID:String?
    var ExpirationDate:String?
    var IsExpired:String?
    var Name:String?
    var PackageList:String?



    init(ID:Int, StandardID:String,isSubscription:String, isCompetitive:Bool, Icon:String,  StandardName:String, BannerIcon:String, TestSummary:String, Performance:String, BoardID:String, ExpirationDate:String, IsExpired:String, Name:String, PackageList:String)
    {
        self.ID = ID
        self.StandardID = StandardID
        self.isSubscription = isSubscription
        self.isCompetitive = isCompetitive
        self.Icon = Icon
        self.StandardName = StandardName
        self.BannerIcon = BannerIcon
        self.TestSummary = TestSummary
        self.Performance = Performance
        self.BoardID = BoardID
        self.ExpirationDate = ExpirationDate
        self.IsExpired = IsExpired
        self.Name = Name
        self.PackageList = PackageList
    }

}



class TestListModal {

    var testID :String?
    var studentTestID :String?
    var testName  :String?
    var testSubTitle:String?

    var testStatusName:String?
    var testMarks:String?
    var testStartTime:String?
    var testDuration:String?
    var testEndTime:String?

    var testFirstTime  :String?
    var testDate:String?
    var ChapterName:String?
    var TeacherName:String?
    var IntroLink:String?

    var RemainTime:String?
    var IsCompetetive:String?
    var CourseName:String?
    var TotalQue:String?
    var NumberOfHint:String?
    var NumberOfHintUsed:String?

    init(testID:String, studentTestID:String, testName:String, testFirstTime:String,  testSubTitle:String, testDate:String, testStatusName:String, testMarks:String, testStartTime:String, testDuration:String, testEndTime:String, chapterName:String, teacherName:String, remainTime:String, isCompetetive:String, courseName:String, totalQue:String, introLink:String, NumberOfHint:String, NumberOfHintUsed:String )
    {
        self.testID = testID
        self.studentTestID = studentTestID
        self.testName = testName
        self.testFirstTime = testFirstTime
        self.testSubTitle = testSubTitle
        self.testDate = testDate
        self.testStatusName = testStatusName
        self.testMarks = testMarks
        self.testStartTime = testStartTime
        self.testDuration = testDuration
        self.testEndTime = testEndTime
        self.ChapterName = chapterName
        self.TeacherName = teacherName
        self.RemainTime = remainTime
        self.IsCompetetive = isCompetetive
        self.CourseName = courseName
        self.TotalQue = totalQue
        self.IntroLink = introLink
        self.NumberOfHint = NumberOfHint
        self.NumberOfHintUsed = NumberOfHintUsed
    }
}
