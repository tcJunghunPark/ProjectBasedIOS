//
//  RoundButton.swift
//  Calculator
//
//  Created by Junghun Park on 2022/03/05.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }

}
