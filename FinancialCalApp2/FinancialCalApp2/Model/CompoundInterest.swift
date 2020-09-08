//
//  CompoundInterest.swift
//  FinancialCalApp2
//
//  Created by Mahel Manjitha Mawellage on 3/4/20.
//  Copyright © 2020 Mahel Manjitha Mawellage. All rights reserved.
//

class CompoundInterest {
    var presentValue : Double
    var futureValue : Double
    var interestRate : Double
    var noOfPayments : Double
    var historyStringArray : [String]
    
    init(presentValue: Double, futureValue : Double, interestRate: Double, noOfPayments: Double) {
        self.presentValue = presentValue
        self.futureValue = futureValue
        self.interestRate = interestRate
        self.noOfPayments = noOfPayments
        self.historyStringArray = [String]()
    }
}
