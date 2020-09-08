//
//  Keyboard.swift
//  UnitConversion
//
//  Created by MahelM on 3/5/20.
//  Copyright © 2020 MahelM. All rights reserved.
//

import UIKit



enum KeyboardButton: Int {
    case zero, one, two, three, four, five, six, seven, eight, nine, period, delete, negation
}

class Keyboard: UIView {
    let nibName = "Keyboard"
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    var activeTextField = UITextField()
    
    @IBAction func onBtnPressed(_ sender: UIButton) {
        let cursorPosition = getCursorPosition()
        
        if let currentText = self.activeTextField.text {
            switch KeyboardButton(rawValue: sender.tag)!{
            case .period:
                if !currentText.contains("."), currentText.count != 0 {
                    activeTextField.insertText(".")
                    setCursorPosition(from: cursorPosition)
                }
            case .delete:
                if currentText.count != 0 {
                    self.activeTextField.text?.remove(at: currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1))
                    
                    if String(currentText[currentText.index(currentText.startIndex, offsetBy: cursorPosition - 1)]) != "." {
                        activeTextField.sendActions(for: UIControl.Event.editingChanged)
                    }
                    
                    setCursorPosition(from: cursorPosition, offset: -1)
                }
                
            case .negation:
                if !currentText.contains("-"), currentText.count != 0 {
                    activeTextField.text?.insert("-", at: currentText.index(currentText.startIndex, offsetBy: 0))
                    activeTextField.sendActions(for: UIControl.Event.editingChanged)
                    setCursorPosition(from: cursorPosition)
                }
            default:
                activeTextField.insertText(String(sender.tag))
                setCursorPosition(from: cursorPosition)
            }
        }
    }
    
    func getCursorPosition() -> Int {
        guard let selectedRange = activeTextField.selectedTextRange else {return 0}
        return activeTextField.offset(from: activeTextField.beginningOfDocument, to: selectedRange.start)
    }
    
    func setCursorPosition(from:Int, offset: Int = 1) {
        if let newPosition = activeTextField.position(from: activeTextField.beginningOfDocument, offset: from + offset) {
            activeTextField.selectedTextRange = activeTextField.textRange(from: newPosition, to: newPosition)
        }
    }
}
