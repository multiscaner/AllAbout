//
//  UIExtensions.swift
//  AllAbout
//
//  Created by UjiN on 5/29/20.
//  Copyright © 2020 UjiN. All rights reserved.
//

import UIKit

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
