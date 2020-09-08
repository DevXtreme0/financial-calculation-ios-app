//
//  CompoundOptSelectController.swift
//  FinancialCalApp2
//
//  Created by MahelM on 2/27/20.
//  Copyright © 2020 MahelM. All rights reserved.
//
import Foundation
import UIKit

class MortgageViewController: UIViewController, UITextFieldDelegate{
    
    
  
   // @IBOutlet weak var mortgageViewScroller: UIScrollView!
   // @IBOutlet weak var outSideStack: UIStackView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var noOfPayementsTF: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var keyboardView: Keyboard!
    
    var mortgage : Mortgage = Mortgage(amount: 0.0, interestRate: 0.0, noOfPayments: 0.0, payment: 0.0)
    
    /// perform additional initialization of view 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.assignDelegates()
        self.loadDefaultsData("MortgageHistory")
        self.loadInputWhenAppOpen()
        
    }
    
    /// load history data to string array
    func loadDefaultsData(_ historyKey :String) {
        let defaults = UserDefaults.standard
        mortgage.historyStringArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    /// disable system keybaord popup and call view textfields from controller
    func assignDelegates() {
        amountTextField.delegate = self
        amountTextField.inputView = UIView()
        interestRateTextField.delegate = self
        interestRateTextField.inputView = UIView()
        noOfPayementsTF.delegate = self
        noOfPayementsTF.inputView = UIView()
        paymentTextField.delegate = self
        paymentTextField.inputView = UIView()
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editAmountSaveDefault(_ sender: UITextField)  {
        let defaultValue = UserDefaults.standard
        defaultValue.set(amountTextField.text, forKey:"mortgage_amount")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editInterestRateSaveDefault(_ sender: UITextField) {
        let defaultValue = UserDefaults.standard
        defaultValue.set(interestRateTextField.text, forKey:"mortgage_interest_rate")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editNoOfPaymentsSaveDefault(_ sender: UITextField) {
        let defaultValue = UserDefaults.standard
        defaultValue.set(noOfPayementsTF.text, forKey:"mortgage_noOfPayments")
        
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editPaymentSaveDefault(_ sender: UITextField) {
        let defaultValue = UserDefaults.standard
          defaultValue.set(paymentTextField.text, forKey:"mortgage_payment")
        
    }

    /// load data when app reopen
    func loadInputWhenAppOpen(){
        let defaultValue =  UserDefaults.standard
        let amountDefault = defaultValue.string(forKey:"mortgage_amount")
        let interestRateDefault = defaultValue.string(forKey:"mortgage_interest_rate")
        let noOfPayementsDefault = defaultValue.string(forKey:"mortgage_noOfPayments")
        let paymentDefault = defaultValue.string(forKey:"mortgage_payment")
        
        amountTextField.text = amountDefault
        interestRateTextField.text = interestRateDefault
        noOfPayementsTF.text = noOfPayementsDefault
        paymentTextField.text = paymentDefault
        
    }
    
    /// keybaord user input will display textbox
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardView.activeTextField = textField
    }
    
    /// clear all textbox data
    @IBAction func onClear(_ sender: UIButton) {
        
        amountTextField.text = ""
        interestRateTextField.text = ""
        noOfPayementsTF.text = ""
        paymentTextField.text = ""
    }
    
    /// calculate formula when calculate button clicked
    @IBAction func onCalculate(_ sender: UIButton) {
        
        /// check whether all textbox empty or not
        if amountTextField.text! == "" && interestRateTextField.text! == "" &&
           paymentTextField.text! == "" && noOfPayementsTF.text! == "" {
            
            let alertController = UIAlertController(title: "Warning Alert", message: "Please enter value(s) to calculate ", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
              /// check whether all textbox filled or not
            } else if amountTextField.text! != "" && interestRateTextField.text! != "" &&
                  paymentTextField.text! != "" && noOfPayementsTF.text! != "" {
            
            let alertController = UIAlertController(title: "Warning Alert", message: " Need one empty field.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in

            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
          /// payment calculation
        } else if paymentTextField.text! == "" && amountTextField.text! != "" &&
        interestRateTextField.text! != "" && noOfPayementsTF.text! != "" {
            
               let amountValue = Double(amountTextField.text!)!
               let interestRateValue = Double(interestRateTextField.text!)!
               let noOfPaymentsValue = Double(noOfPayementsTF.text!)!
                
               let interestDivided = interestRateValue/100
               
            
            /// payment formula - M = P[i(1+i)n] / (1+i)nt
                let payment = amountValue * ( (interestDivided/12 * pow(1 + interestDivided/12 , noOfPaymentsValue) ) / ( pow(1 + interestDivided/12 , noOfPaymentsValue) - 1 ) )
               
                //let paymentTwoDecimal = Double(round(100*payment)/100)
                paymentTextField.text = String(format: "%.2f",payment )
            
          /// amount calculation
        } else if amountTextField.text! == "" && noOfPayementsTF.text! != "" &&
        interestRateTextField.text! != "" && paymentTextField.text! != ""{
          
             let noOfPaymentsValue = Double(noOfPayementsTF.text!)!
             let interestRateValue = Double(interestRateTextField.text!)!
             let paymentValue = Double(paymentTextField.text!)!
             
             let interestDivided = interestRateValue/100
           
             /// mortgage amout formula - P= (M * ( pow ((1 + R/t), (n*t)) - 1 )) / ( R/t * pow((1 + R/t), (n*t)))
            
             let Present  = (paymentValue * ( pow((1 + interestDivided / noOfPaymentsValue), (noOfPaymentsValue)) - 1 )) / ( interestDivided / noOfPaymentsValue * pow((1 + interestDivided / noOfPaymentsValue), (noOfPaymentsValue)))
             
             amountTextField.text = String(format: "%.2f",Present)
            
          /// interest rate calculation
        } else if interestRateTextField.text! == "" && amountTextField.text! != "" &&
        noOfPayementsTF.text! != "" && paymentTextField.text! != "" {
            
            let alertController = UIAlertController(title: "Warning", message: "Interest rate calculation is not defined. ", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
             
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
      
            
          /// number of payments calculation
        } else if noOfPayementsTF.text! == "" && interestRateTextField.text! != "" && amountTextField.text! != "" && paymentTextField.text! != ""{
            
            let amountValue = Double(amountTextField.text!)!
            let interestRateValue = Double(interestRateTextField.text!)!
            let paymentValue = Double(paymentTextField.text!)!
            
            let interestDivided = (interestRateValue / 100) / 12
            
            /// number of payments formula - log((PMT / i) / ((PMT / i) - P)) / log(1 + i)
            let calculatedNumOfMonths = log((paymentValue / interestDivided) / ((paymentValue / interestDivided) - amountValue)) / log(1 + interestDivided)
            
            //let   calculatedNumOfYears = round(100 * (calculatedNumOfMonths / 12)) / 100
            noOfPayementsTF.text = String(format: "%.2f",calculatedNumOfMonths)
            
        } else {
        
            let alertController = UIAlertController(title: "Warning", message: "Please enter value(s) to calculate ", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
             
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
       
        }
        
    }
    /*
     Formula Attribute Naming
     
     P = present/principal/amount value
     F = future value
     r = interest rate
     t = (time) number of payments
     n = compound per year
     PMT = payment
     
     */
     /// save data in history view when save button clicked
    @IBAction func onSave(_ sender: UIButton){
        
        if amountTextField.text! != "" && interestRateTextField.text! != "" &&
        paymentTextField.text! != "" && noOfPayementsTF.text! != ""
        {
        let defaults = UserDefaults.standard
             /// format of displaying history
        let historyString = "Mortgage Amount is \(amountTextField.text!), Interest Rate is \(interestRateTextField.text!)%, No.of Payment is \(noOfPayementsTF.text!), Payment is \(paymentTextField.text!)"
           
           mortgage.historyStringArray.append(historyString)
           defaults.set(mortgage.historyStringArray, forKey: "MortgageHistory")
            
            let alertController = UIAlertController(title: "Success Alert", message: "Successfully Saved.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
            
        }
            /// check whether fields are empty before save nill values
        else if amountTextField.text == "" || interestRateTextField.text == "" ||
        paymentTextField.text == "" || noOfPayementsTF.text == ""{
            
            let alertController = UIAlertController(title: "Warning Alert", message: "One or More Input are Empty", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
        }  else{
            
            
            
        let alertController = UIAlertController(title: "Error Alert", message: "Please do calculate. Save Unsuccessful", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        }
       }
    
    
}
