//
//  PaymentListModel.swift
//  TestCraftLite
//
//  Created by ADMS on 02/04/21.
//

import Foundation
class PaymentListModal {

    var PaymentTransactionID :String?
    var PaymentAmount  :String?
    var PaymentDate  :String?
    var ExternalTransactionID:String?
    var ExternalTransactionStatus:String?
    var packageEndDate:String?
    var InvoiceId:String?
    var InvoiceGUId:String?
    var InvoiceLink:String?
    var OrderID:String?
    var packageName:String?
    var IsFree:String?

    init(PaymentTransactionID:String, PaymentAmount:String, PaymentDate:String, ExternalTransactionID:String, ExternalTransactionStatus:String, InvoiceId:String, InvoiceGUId:String, InvoiceLink:String, OrderID:String, packageName:String, IsFree:String) {
        self.PaymentTransactionID = PaymentTransactionID
        self.OrderID = OrderID
        self.PaymentAmount = PaymentAmount
        self.PaymentDate = PaymentDate
        self.ExternalTransactionID = ExternalTransactionID
        self.ExternalTransactionStatus = ExternalTransactionStatus
        self.InvoiceId = InvoiceId
        self.InvoiceGUId = InvoiceGUId
        self.InvoiceLink = InvoiceLink
        self.OrderID = OrderID
        self.packageName = packageName
        self.IsFree = IsFree
    }
}
