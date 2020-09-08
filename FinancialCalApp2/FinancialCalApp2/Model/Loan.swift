//
//  Loan.swift
//  FinancialCalApp2
//
//  Created by MahelM on 3/7/20.
//  Copyright © 2020 MahelM. All rights reserved.
//

import Foundation

class Loan {
    var amount : Double
    var interestRate : Double
    var noOfPayments : Double
    var payment : Double
    var historyStringArray : [String]
    
    init(amount: Double, interestRate: Double, noOfPayments: Double, payment: Double) {
        self.amount = amount
        self.interestRate = interestRate
        self.noOfPayments = noOfPayments
        self.payment = payment
        self.historyStringArray = [String]()
    }
}
