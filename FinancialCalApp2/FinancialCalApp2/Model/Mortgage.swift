//
//  Mortgage.swift
//  FinancialCalApp2
//
//  Created by Mahel Manjitha Mawellage on 3/2/20.
//  Copyright © 2020 Mahel Manjitha Mawellage. All rights reserved.
//

import Foundation

class Mortgage {
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
