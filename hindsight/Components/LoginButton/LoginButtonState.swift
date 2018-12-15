//
//  LoginButtonState.swift
//  hindsight
//
//  Created by Wei-Ting Lin on 11/13/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import UIKit

protocol LoginButtonStateProtocol {
    /// The `Variable` represents the button text in the current state
    var text: String {get}
    /// The `UIColor` represents the button textColor in the current state
    var textColor: UIColor {get}
    /// The `UIColor` represents the button backgroundColor in the current state
    var backgroundColor: UIColor {get}
    /// The `UIImage` represents the button image in the current state
    var image: UIImage? {get}
}

struct LoginButtonState: LoginButtonStateProtocol {
    /// The `Variable` represents the button text in the current state
    let text: String
    /// The `UIColor` represents the button textColor in the current state
    let textColor: UIColor
    /// The `UIColor` represents the button backgroundColor in the current state
    let backgroundColor: UIColor
    /// The `UIImage` represents the button image in the current state
    let image: UIImage?
    /// The `Function` to construct the struct
    init(text: String, textColor: UIColor, backgroundColor: UIColor, image: UIImage?) {
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.image = image
    }
}
