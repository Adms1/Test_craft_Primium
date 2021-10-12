//
//  PackageDetailsModal.swift
//  TestCraftLite
//
//  Created by ADMS on 02/04/21.
//

import Foundation
class PackageDetailsModal {

    var TestPackageName  :String = ""
    var TestPackageDescription:String?
    var TestPackageSalePrice:String?
    var TestPackageListPrice:String?
    var NumberOfTest:String?
    var Subject:String = ""
    var TutorId :String?
    var id :String?
    var TestPackageID:String?
    var image  :String?
    var selected  :String?
    var arrTestType  = [PackageDetailsModal]()
    var TestQuantity  :String?
    var TestTypeName  :String?
    var packageStartDate:String?
    var TutorName:String = ""
    var InstituteName:String?
    var packageEndDate:String?
    var isCompetitive:String?
    var std:String?
    var stdId:String?
    var strTime:String?
    var BoardID:String?
    var NumberOfComletedTest:String?

    init(TestPackageID:String, TestPackageName:String, TestPackageDescription:String, TestPackageSalePrice:String, TestPackageListPrice:String, NumberOfTest:String, image:String, selected:String, packageStartDate:String, packageEndDate:String, Subject:String, TutorId:String, TutorName:String, InstituteName:String, arrTestType:[PackageDetailsModal], isCompetitive:String, std:String, stdId:String, BoardID:String,NumberOfComletedTest:String) {
        self.TestPackageID = TestPackageID
        self.TestPackageName = TestPackageName
        self.TestPackageDescription = TestPackageDescription
        self.TestPackageSalePrice = TestPackageSalePrice
        self.TestPackageListPrice = TestPackageListPrice
        self.NumberOfTest = NumberOfTest
        self.image = image
        self.selected = selected
        self.packageStartDate = packageStartDate
        self.packageEndDate = packageEndDate
        self.Subject = Subject
        self.TutorId = TutorId
        self.TutorName = TutorName
        self.InstituteName = InstituteName
        self.arrTestType = arrTestType
        self.isCompetitive = isCompetitive
        self.std = std
        self.stdId = stdId
        self.BoardID = BoardID
        self.NumberOfComletedTest = NumberOfComletedTest

    }
//    // OLD
//    init(TestPackageID:String, TestPackageName:String, TestPackageDescription:String, TestPackageSalePrice:String, TestPackageListPrice:String, NumberOfTest:String, image:String, selected:String, packageStartDate:String, packageEndDate:String, Subject:String, TutorId:String, TutorName:String, InstituteName:String, arrTestType:[PackageDetailsModal]) {
//        self.TestPackageID = TestPackageID
//        self.TestPackageName = TestPackageName
//        self.TestPackageDescription = TestPackageDescription
//        self.TestPackageSalePrice = TestPackageSalePrice
//        self.TestPackageListPrice = TestPackageListPrice
//        self.NumberOfTest = NumberOfTest
//        self.image = image
//        self.selected = selected
//        self.packageStartDate = packageStartDate
//        self.packageEndDate = packageEndDate
//        self.Subject = Subject
//        self.TutorId = TutorId
//        self.TutorName = TutorName
//        self.InstituteName = InstituteName
//        self.arrTestType = arrTestType
//    }

    init(id:String, TestTypeName:String, TestQuantity:String, strTime:String) {
        self.id = id
        self.TestTypeName = TestTypeName
        self.TestQuantity = TestQuantity
        self.strTime = strTime
    }
    static func <(lhs: PackageDetailsModal, rhs: PackageDetailsModal) -> Bool {
        return lhs.Subject < rhs.Subject
    }
}
