//
//  HistoryViewController.swift
//  FinancialCalApp2
//
//  Created by Mahel Manjitha Mawellage on 3/2/20.
//  Copyright © 2020 Mahel Manjitha Mawellage. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UITableViewController {
    

    var history : [String] = [String]()
    
    /// perform additional initialization of view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initHistoryInfo()
    }
    
    /// load history data when history view switched
    func initHistoryInfo() {
        if let vcs = self.navigationController?.viewControllers {
            let previousVC = vcs[vcs.count - 2]
            
            if previousVC is MortgageViewController {
                loadDefaultsData("MortgageHistory")
            }
            
            if previousVC is CompoundInterestController {
                loadDefaultsData("CompoundInterestHistory")
            }
            
            if previousVC is SavingsController {
                loadDefaultsData("SavingsHistory")
            }
        
            if previousVC is LoanController {
                loadDefaultsData("LoanHistory")
            }
        }
    }
    
     /// load history data to string array
    func loadDefaultsData(_ historyKey :String) {
        let defaults = UserDefaults.standard
        history = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    /// perform additional display history data in each row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    /// perform additional tabelview row data with idetifier name
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableHistoryCell")!
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }
    
    }
