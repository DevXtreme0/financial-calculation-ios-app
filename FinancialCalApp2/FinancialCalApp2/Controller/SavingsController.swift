//
//  SavingsController.swift
//  FinancialCalApp2
//
//  Created by MahelM on 3/5/20.
//  Copyright © 2020 MahelM. All rights reserved.
//

import Foundation
import UIKit

class SavingsController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var presentValueTextField: UITextField!
    @IBOutlet weak var futureValueTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var noOfPaymentsTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var compoundPerYearTextField: UITextField!
    
    @IBOutlet weak var keyboardView: Keyboard!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var endBeginLabel: UILabel!
    
    @IBOutlet weak var endBeginSwitch: UISwitch!
    
    var savings : Savings = Savings(presentValue: 0.0, futureValue: 0.0, interestRate: 0.0,  noOfPayments: 0.0)
    
    /// perform additional initialization of view
    override func viewDidLoad() {
          super.viewDidLoad()
          self.assignDelegates()
          self.loadDefaultsData("SavingsHistory")
          self.loadInputWhenAppOpen()
      }
      
    /// load history data to string array
      func loadDefaultsData(_ historyKey :String) {
          let defaults = UserDefaults.standard
          savings.historyStringArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
      }
      
    /// disable system keybaord popup and call view textfields from controller
      func assignDelegates() {
          presentValueTextField.delegate = self
          presentValueTextField.inputView = UIView()
          futureValueTextField.delegate = self
          futureValueTextField.inputView = UIView()
          interestRateTextField.delegate = self
          interestRateTextField.inputView = UIView()
          noOfPaymentsTextField.delegate = self
          noOfPaymentsTextField.inputView = UIView()
          paymentTextField.delegate = self
          paymentTextField.inputView = UIView()
        
          endBeginLabel.text = "END - ON / BEGIN - OFF"
          compoundPerYearTextField.text = "12"
      }
    
    /// save typed data in textbox to relevent key
    @IBAction func editPresentSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(presentValueTextField.text, forKey:"savings_present")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editFutureSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(futureValueTextField.text, forKey:"savings_future")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editInterestRateSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(interestRateTextField.text, forKey:"savings_interest")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editNoOfPaymentsSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(noOfPaymentsTextField.text, forKey:"savings_noOfPayment")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editPaymentSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(paymentTextField.text, forKey:"savings_payment")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editSwitchSaveDefault(_ sender: UISwitch) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(endBeginSwitch.isOn, forKey:"savings_endBegin")
    }
    

    
    /// load data when app reopen
    func loadInputWhenAppOpen(){
        let defaultValue =  UserDefaults.standard
        let presentDefault = defaultValue.string(forKey:"savings_present")
        let interestRateDefault = defaultValue.string(forKey:"savings_interest")
        let noOfPayementsDefault = defaultValue.string(forKey:"savings_noOfPayment")
        let futureDefault = defaultValue.string(forKey:"savings_future")
        let paymentDefault = defaultValue.string(forKey:"savings_payment")
        /*let endBeginDefault =*/ defaultValue.set(true, forKey:"savings_endBegin")
        
        presentValueTextField.text = presentDefault
        futureValueTextField.text = futureDefault
        interestRateTextField.text = interestRateDefault
        noOfPaymentsTextField.text = noOfPayementsDefault
        paymentTextField.text = paymentDefault
        //endBeginSwitch.isOn = endBeginDefault
    }
    
    /// keyboard user input will display textbox
      func textFieldDidBeginEditing(_ textField: UITextField) {
          keyboardView.activeTextField = textField
      }
    
    /// change label text when END / BEGIN switch ON or OFF
    @IBAction func endBeginClicked(_ sender: UISwitch) {
        
        if sender.isOn {
           
            endBeginLabel.text! = "END - ON / BEGIN - OFF"
            
            
            
            
        }
        else {
           
            endBeginLabel.text! = "END - OFF / BEGIN - ON"
            
            
        }
        
    }
    
      /// clear all textbox data
    @IBAction func onClear(_ sender: UIButton) {
          
          presentValueTextField.text! = ""
          futureValueTextField.text! = ""
          interestRateTextField.text! = ""
          
          noOfPaymentsTextField.text! = ""
          paymentTextField.text! = ""
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
    /// calculate formula when calculate button clicked
    @IBAction func onCalculate(_ sender: UIButton) {
        
    /// check whether all textbox empty or not
    if presentValueTextField.text! == "" && futureValueTextField.text! == "" &&
           interestRateTextField.text! == "" && noOfPaymentsTextField.text! == "" &&
        paymentTextField.text! == "" {
            
            let alertController = UIAlertController(title: "Warning", message: "Please enter value(s) to calculate ", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
             
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
                /// check whether all textbox filled or not
                } else if presentValueTextField.text! != "" && futureValueTextField.text! != "" &&
                      interestRateTextField.text! != "" && noOfPaymentsTextField.text! != ""
    && paymentTextField.text! != ""{
                
                let alertController = UIAlertController(title: "Warning", message: "Need one empty field.", preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    
                    
                }
                
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:nil)
                
            /// present value calculation
    } else if presentValueTextField.text! == "" && futureValueTextField.text! != "" && interestRateTextField.text! != "" && noOfPaymentsTextField.text! != ""{
            
           let futureValue = Double(futureValueTextField.text!)!
            let interestValue = Double(interestRateTextField.text!)!
            let noOfPaymentsValue = Double(noOfPaymentsTextField.text!)!
            
            let interestDivided = interestValue/100
            
        /// present value formula - P = A/(1+rn)nt
            let presentValueCalculate = futureValue / pow(1 + (interestDivided / 12), 12 * noOfPaymentsValue)
            
            presentValueTextField.text = String(format: "%.2f",presentValueCalculate)
            
          
       
            /// interest rate calculation
    } else if interestRateTextField.text! == "" && presentValueTextField.text! != "" && futureValueTextField.text! != "" && noOfPaymentsTextField.text! != ""  {
            
            let presentValue = Double(presentValueTextField.text!)!
            let futureValue = Double(futureValueTextField.text!)!
            let noOfPaymentsValue = Double(noOfPaymentsTextField.text!)!
            
         /// interest rate formula - r = n[(A/P)1/nt-1]
            let interestRateCalculate = 12 * ( pow ( ( futureValue / presentValue ), 1 / ( 12 * noOfPaymentsValue ) ) - 1 )
            //let interstRateTwoDecimal = Double(round(100*interestRateCalculate)/100)
        
            interestRateTextField.text! = String(format: "%.2f",interestRateCalculate*100)
            
        /// number of payments calculation
    } else if noOfPaymentsTextField.text! == "" && presentValueTextField.text! != ""
        && futureValueTextField.text! != "" && interestRateTextField.text! != ""{
                
            let presentValue = Double(presentValueTextField.text!)!
            let futureValue = Double(futureValueTextField.text!)!
            let interestValue = Double(interestRateTextField.text!)!
            
            let interestDivided = interestValue/100
            
         /// number of payments formula - t = log(A/P) /n [log(1+r/n)]
            let noOfPaymentsCalculate = log (futureValue/presentValue) / (12*log(1+interestDivided/12))
            //let noOfPaymentsTwoDecimal = Double(round(100*noOfPaymentsCalculate)/100)
        
            noOfPaymentsTextField.text! = String(format: "%.2f",noOfPaymentsCalculate)
        
    } else if futureValueTextField.text! == "" && paymentTextField.text! == "" {
        
         let alertController = UIAlertController(title: "Warning", message: "Need payment value to calculate", preferredStyle: .alert)
               
               let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                   
                   
                   
               }
               
               alertController.addAction(OKAction)
               
               self.present(alertController, animated: true, completion:nil)
        
        /// regular contribution with future value calculation
    } else if paymentTextField.text! != "" && endBeginSwitch.isOn == true && presentValueTextField.text! != "" && noOfPaymentsTextField.text! != "" && interestRateTextField.text! != "" {
        
        let presentValue = Double(presentValueTextField.text!)!
        let interestValue = Double(interestRateTextField.text!)!
        let noOfPaymentsValue = Double(noOfPaymentsTextField.text!)!
        let paymentValue = Double(paymentTextField.text!)!
        
        let compoundPerYear = 12.00
        
        let interestDivided = interestValue/100
        
        ///regular contribution with future value formula, when END selected - principal = P * pow( 1 + ( r / n ),n * t )
        let compoundInterestPrincipal = presentValue * pow( 1.00 + ( interestDivided / compoundPerYear ),compoundPerYear * noOfPaymentsValue )
        ///regular contribution with future value formula, when END selected  - future vlaue series = PMT * (  pow(( 1 + r / n  ), n * t  ) - 1) /  ( r / n )
        let futureValueSeries = paymentValue * (  pow(( 1.00 + interestDivided / compoundPerYear  ), compoundPerYear * noOfPaymentsValue  ) - 1.00) /  ( interestDivided / compoundPerYear )
        
         let  totalA = compoundInterestPrincipal + futureValueSeries
        
        futureValueTextField.text! = String(format: "%.2f",totalA)
        
        
    } else if paymentTextField.text! != "" && endBeginSwitch.isOn == false && presentValueTextField.text! != "" && noOfPaymentsTextField.text! != "" && interestRateTextField.text! != ""{
        
        
         let presentValue = Double(presentValueTextField.text!)!
         let interestValue = Double(interestRateTextField.text!)!
         let noOfPaymentsValue = Double(noOfPaymentsTextField.text!)!
         let paymentValue = Double(paymentTextField.text!)!
         
         let compoundPerYear = 12.00
         
         let interestDivided = interestValue/100
         
          ///regular contribution with future value formula, when BEGIN selected - principal = P * pow( 1 + ( r / n ),n * t )
         let compoundInterestPrincipal = presentValue * pow( 1.00 + ( interestDivided / compoundPerYear ),compoundPerYear * noOfPaymentsValue )
        ///regular contribution with future value formula, when BEGIN selected  - future vlaue series = PMT * (  pow(( 1 + r / n  ), n * t  ) - 1) /  ( r / n )*  (1 + r / n)
         let futureValueSeries = paymentValue * (  pow(( 1.00 + interestDivided / compoundPerYear  ), compoundPerYear * noOfPaymentsValue  ) - 1.00) /  ( interestDivided / compoundPerYear ) *  (1 + interestDivided / compoundPerYear)
         
          let  totalA = compoundInterestPrincipal + futureValueSeries
         
         futureValueTextField.text! = String(format: "%.2f",totalA)
        
    /// this condition will pass when all the text box filled other than payment text box and switch on
    } else if paymentTextField.text! == "" && endBeginSwitch.isOn == true && presentValueTextField.text! != "" && noOfPaymentsTextField.text! != "" && interestRateTextField.text! != "" {
        
        let alertController = UIAlertController(title: "Warning", message: "Payment value calculate is not defined.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
      
        
       /// this condition will pass when all the text box filled other than payment text box and switch off
    } else if paymentTextField.text! == "" && endBeginSwitch.isOn == false && presentValueTextField.text! != "" && noOfPaymentsTextField.text! != "" && interestRateTextField.text! != "" {
        
        let alertController = UIAlertController(title: "Warning", message: "Payment value calculation is not defined.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
        } else {
        
        let alertController = UIAlertController(title: "Warning", message: " Please enter value(s) to calculate.", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
        
      }

    }
    
    /// save data in history view when save button clicked
    @IBAction func onSave(_ sender: UIButton){
          
        if presentValueTextField.text! != "" && futureValueTextField.text! != "" &&
        interestRateTextField.text! != "" && noOfPaymentsTextField.text! != ""
        && paymentTextField.text! != "" {
        
          let defaults = UserDefaults.standard
            let historyString = "Present Value is \(presentValueTextField.text!), Future Value is \(futureValueTextField.text!), Interest Rate is \(interestRateTextField.text!)%, No. of Payments is  \(noOfPaymentsTextField.text!), Payment is  \(paymentTextField.text!), END - \(endBeginSwitch.isOn)"
             
             savings.historyStringArray.append(historyString)
             defaults.set(savings.historyStringArray, forKey: "SavingsHistory")
        
            
            let alertController = UIAlertController(title: "Success Alert", message: "Successfully Saved.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
      
        }
             /// check whether fields are empty before save nill values
        else if presentValueTextField.text! == "" || futureValueTextField.text! == "" ||
           interestRateTextField.text! == "" || noOfPaymentsTextField.text! == "" ||
        paymentTextField.text! == "" {
            
            let alertController = UIAlertController(title: "Warning Alert", message: "One or More Input are Empty", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
        }
        else {
            
            let alertController = UIAlertController(title: "Error Alert", message: "Please do calculate. Save Unsuccessful", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
        }
        
         }
    
}
