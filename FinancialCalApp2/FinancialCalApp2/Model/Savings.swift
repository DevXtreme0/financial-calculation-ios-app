//
//  Savings.swift
//  FinancialCalApp2
//
//  Created by MahelM on 3/5/20.
//  Copyright © 2020 MahelM. All rights reserved.
//

import Foundation

class Savings {
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
