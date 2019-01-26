//
//  ErrorPresenting.swift
//  hindsight
//
//  Created by Leo on 1/1/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import UIKit

/// Preparing UI component(s) to present an error
protocol ErrorPresentingProtocol {

	/// Getting a `UIViewController` from an `Error`
	func errorViewController(error: Error) -> UIViewController
}

/// Preparing a `UIAlertViewController` to present an error
struct AlertErrorPresenter: ErrorPresentingProtocol {

	func errorViewController(error: Error) -> UIViewController {
		let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)

		let okAction = UIAlertAction(title: "OK", style: .default) { _ in
		}
		alertController.addAction(okAction)

        return alertController
	}
}
