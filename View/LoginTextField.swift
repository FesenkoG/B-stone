//
//  LoginTextField.swift
//  В-stone
//
//  Created by Георгий Фесенко on 29.01.2018.
//  Copyright © 2018 Georgy. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2.0
        

    }
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

}
