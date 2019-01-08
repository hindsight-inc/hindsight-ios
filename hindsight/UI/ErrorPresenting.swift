//
//  ErrorPresenting.swift
//  hindsight
//
//  Created by Leo on 1/1/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import UIKit

protocol ErrorPresentingProtocol {
	var viewController: UIViewController { get set }
	func show(error: Error)
}

struct AlertErrorPresenter: ErrorPresentingProtocol {
//    public var viewController: UIViewController

    public var present: (UIAlertController) -> Void

	public func show(error: Error) {
		let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)

		let okAction = UIAlertAction(title: "OK", style: .default) { _ in
			print("Cancel button pressed")
		}
		alertController.addAction(okAction)

//        viewController.present(alertController, animated: true) {
//        }
        present(alertController)
	}
}
