//
//  MainTabController.swift
//  FinancialCalApp2
//
//  Created by MahelM on 3/4/20.
//  Copyright © 2020 MahelM. All rights reserved.
//

import Foundation
import UIKit

class MainTabController : UITabBarController {
    
    @IBOutlet weak var userInterfaceTabBarItem: UITabBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fontAttributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:14)]
        
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
        
        
        
    }
    
   /* override  func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 55
        tabBar.frame.origin.y = view.frame.height - 55
    }*/
    
    
}
