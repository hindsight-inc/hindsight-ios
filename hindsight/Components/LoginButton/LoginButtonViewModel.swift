//
//  LoginButtonViewModel.swift
//  hindsight
//
//  Created by Wei-Ting Lin on 11/13/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginButtonProtocol {
    /// The `Variable` represents a RxSwift `Observable` which will be observed for button state changes
    var buttonState: Variable<LoginButtonStateProtocol> { get }
    /// The `Function` handles `UILongPressGestureRecognizer` when state changes to .began
    func didSelect()
    /// The `Function` handles `UILongPressGestureRecognizer` when state changes to .cancelled
    func didCancel()
    /// The `Function` handles `UILongPressGestureRecognizer` when state changes to .ended
    func didRelease()
}

struct LoginButtonViewModel: LoginButtonProtocol {
    /// The `Variable` represents a RxSwift `Observable` which will be observed for button state changes
    internal let buttonState: Variable<LoginButtonStateProtocol>
    /// The `LoginButtonStateProtocol` represents button normal state
    private let normalState: LoginButtonStateProtocol
    /// The `LoginButtonStateProtocol` represents button highlight state
    private let highlightState: LoginButtonStateProtocol?
    /// The `VoidClosure` delegates the button tapped action
    private let didSelectClosure: VoidClosure

    init(normalState: LoginButtonStateProtocol,
         highlightState: LoginButtonStateProtocol?,
         didSelectClosure: @escaping VoidClosure) {
        self.normalState = normalState
        self.highlightState = highlightState
        self.didSelectClosure = didSelectClosure
        self.buttonState = Variable(normalState)
    }

    func didSelect() {
        if let hs = highlightState {
            buttonState.value = hs
        }
    }

    func didCancel() {
        buttonState.value = normalState
    }

    func didRelease() {
        buttonState.value = normalState
        didSelectClosure()
    }
}
