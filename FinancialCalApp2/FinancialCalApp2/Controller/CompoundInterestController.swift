//
//  CompoundInterestViewController.swift
//  FinancialCalApp2
//
//  Created by Mahel Manjitha Mawellage on 3/4/20.
//  Copyright © 2020 Mahel Manjitha Mawellage. All rights reserved.
//

import Foundation
import UIKit

class CompoundInterestController : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var presentValueTextField: UITextField!
    @IBOutlet weak var futureValueTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
  
    @IBOutlet weak var noOfPaymentsTextField: UITextField!
    @IBOutlet weak var keyboardView: Keyboard!
    
    
    var compoundInterest : CompoundInterest = CompoundInterest(presentValue: 0.0, futureValue: 0.0, interestRate: 0.0,  noOfPayments: 0.0)
    
    /// perform additional initialization of view
    override func viewDidLoad() {
          super.viewDidLoad()
          self.assignDelegates()
          self.loadDefaultsData("CompoundInterestHistory")
          self.loadInputWhenAppOpen()
      }
      
      /// load history data to string array  
      func loadDefaultsData(_ historyKey :String) {
          let defaults = UserDefaults.standard
          compoundInterest.historyStringArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
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
      }
    
    /// save typed data in textbox to relevent key
    @IBAction func editPresentSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(presentValueTextField.text, forKey:"compound_present")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editFutureSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(futureValueTextField.text, forKey:"compound_future")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editInterestRateSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(interestRateTextField.text, forKey:"compound_interest")
    }
    
    /// save typed data in textbox to relevent key
    @IBAction func editNoOfPaymentsSaveDefault(_ sender: UITextField) {
        
        let defaultValue = UserDefaults.standard
        defaultValue.set(noOfPaymentsTextField.text, forKey:"compound_noOfPayment")
    }

      /// load data when app reopen
      func loadInputWhenAppOpen(){
          let defaultValue =  UserDefaults.standard
          let presentDefault = defaultValue.string(forKey:"compound_present")
          let interestRateDefault = defaultValue.string(forKey:"compound_interest")
          let noOfPayementsDefault = defaultValue.string(forKey:"compound_noOfPayment")
          let futureDefault = defaultValue.string(forKey:"compound_future")
          
          presentValueTextField.text = presentDefault
          futureValueTextField.text = futureDefault
          interestRateTextField.text = interestRateDefault
          noOfPaymentsTextField.text = noOfPayementsDefault
          
      }
    
    /// keybaord user input will display textbox
      func textFieldDidBeginEditing(_ textField: UITextField) {
          keyboardView.activeTextField = textField
      }
      
    /// clear all textbox data
    @IBAction func onClear(_ sender: UIButton) {
          
          presentValueTextField.text = ""
          futureValueTextField.text = ""
          interestRateTextField.text = ""
          noOfPaymentsTextField.text = ""
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
           interestRateTextField.text! == "" && noOfPaymentsTextField.text! == "" {
            
            let alertController = UIAlertController(title: "Alert", message: "Please enter value(s) to calculate ", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
            /// check whether all textbox filled or not
            } else if presentValueTextField.text! != "" && futureValueTextField.text! != "" &&
                  interestRateTextField.text! != "" && noOfPaymentsTextField.text! != "" {
            
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
            
            /// present value formula - P =  A/(1+rn)nt
            let presentValueCalculate = futureValue / pow(1 + (interestDivided / 12), 12 * noOfPaymentsValue)
            
            presentValueTextField.text = String(format: "%.2f",presentValueCalculate)
            
            /// future value calculation
        } else if futureValueTextField.text! == "" && presentValueTextField.text! != "" && interestRateTextField.text! != "" && noOfPaymentsTextField.text! != "" {
            
            let presentValue = Double(presentValueTextField.text!)!
            let interestValue = Double(interestRateTextField.text!)!
            let noOfPaymentsValue = Double(noOfPaymentsTextField.text!)!
            
            let interestDivided = interestValue/100
            
            ///future value formula - A = P(1+(r/n)nt)
            let futureValueCalculate = presentValue * pow (1 + (interestDivided / 12 ), 12 * noOfPaymentsValue )
            
             //let paymentTwoDecimal = Double(round(100*payment)/100)
            futureValueTextField.text = String(format: "%.2f",futureValueCalculate)
            
            /// interest rate calculation
        } else if interestRateTextField.text! == "" && presentValueTextField.text! != ""
        && futureValueTextField.text! != "" && noOfPaymentsTextField.text! != "" {
            
            let presentValue = Double(presentValueTextField.text!)!
            let futureValue = Double(futureValueTextField.text!)!
            let noOfPaymentsValue = Double(noOfPaymentsTextField.text!)!
             
            /// interest rate formula - r = n[(A/P)1/nt-1]
            let interestRateCalculate = 12 * ( pow ( ( futureValue / presentValue ), 1 / ( 12 * noOfPaymentsValue ) ) - 1 )
            
            interestRateTextField.text = String(format: "%.2f",interestRateCalculate * 100)
            
            /// no of payment calculation
        } else if noOfPaymentsTextField.text! == "" && presentValueTextField.text! != "" && futureValueTextField.text! != "" && interestRateTextField.text! != "" {
            
            let presentValue = Double(presentValueTextField.text!)!
            let futureValue = Double(futureValueTextField.text!)!
            let interestValue = Double(interestRateTextField.text!)!
            
            let interestDivided = interestValue/100
            
            /// number of payments formula - t = log(A/P) /n [log(1+r/n)]
            let noOfPaymentsCalculate = log (futureValue/presentValue) / (12*log(1+interestDivided/12))
            
             noOfPaymentsTextField.text = String(format: "%.2f",noOfPaymentsCalculate)
           
            /// output warning message when none of the above conditions are met
        } else {
            
            let alertController = UIAlertController(title: "Warning", message: "Please enter value(s) to calculate ", preferredStyle: .alert)
    
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        
    }
    
    alertController.addAction(OKAction)
    
    self.present(alertController, animated: true, completion:nil)
        }          
              
      }
  
     /// save data in history view when save button clicked
    @IBAction func onSave(_ sender: UIButton){
          
        if presentValueTextField.text! != "" && futureValueTextField.text! != "" &&
        interestRateTextField.text! != "" && noOfPaymentsTextField.text! != "" {
            
          let defaults = UserDefaults.standard
        let historyString = "Present Value is \(presentValueTextField.text!), Future Value is \(futureValueTextField.text!), Interest Rate is \(interestRateTextField.text!)%,  No.of Payment is \(noOfPaymentsTextField.text!)"
             
             compoundInterest.historyStringArray.append(historyString)
             defaults.set(compoundInterest.historyStringArray, forKey: "CompoundInterestHistory")
        
            let alertController = UIAlertController(title: "Success Alert", message: "Successfully Saved.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
            
            /// check whether fields are empty before save nill values
        } else if presentValueTextField.text! == "" || futureValueTextField.text! == "" ||
        interestRateTextField.text! == "" || noOfPaymentsTextField.text! == "" {
            
            let alertController = UIAlertController(title: "Warning Alert", message: "One or More Input are Empty", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
            
        } else {
            
            let alertController = UIAlertController(title: "Error Alert", message: "Please do calculate. Save Unsuccessful", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            
        }
        
        
        
        
         }
    
    
    
}
