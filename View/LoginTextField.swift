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
        var placeholderr = self.placeholder
        if placeholderr == nil {
            placeholderr = ""
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderr!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.5
        

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
