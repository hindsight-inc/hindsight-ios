//
//  Presenting.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import UIKit

protocol Presenting {
    /// Make the given window key and visible
    ///
    //var Parameter window: `UIWindow` to make key and visible
    func makeKeyAndVisible(window: UIWindow)

    /// Present the given view controller modally
    ///
    /// - Parameters:
    ///   - vc: View controller to present
    ///   - presentingViewController: View controller to present from
    ///   - animated: `bool` determining whether or not to animate the presentation
    ///   - completion: Closure to call once presentation has completed
	// TODO: @Leo rename nc and vc to navigationController and viewController?
    func present(vc: UIViewController,
                 from presentingViewController: UIViewController,
                 animated: Bool, completion: (() -> Void)?)

    /// Dismiss the given modally presented view controller
    ///
    /// - Parameters:
    ///   - presentingViewController: Presenting view controller
    ///   - animated: `bool` determining whether or not to animate the presentation
    ///   - completion: Closure to call once dismissal has completed
    func dismiss(from presentingViewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// Push a given view controller onto the given navigation controller
    ///
    /// - Parameters:
    ///   - vc: View controller to be pushed
    ///   - nc: Navigation controller onto which `vc` is to be pushed
    ///   - animated: `bool` determining whether or not to animate the presentation
    func push(vc: UIViewController, onto nc: UINavigationController, animated: Bool)

    /// Pop the top view controller off of the given navigation controller
    ///
    /// - Parameters:
    ///   - nc: Navigation controller from which the view controller is to be popped
    ///   - animated: `bool` determining whether or not to animate the presentation
    func pop(nc: UINavigationController, animated: Bool)

    /// makes the view passed in as the root view of the navigation controller
    ///
    /// - Parameters:
    ///   - vc: the view controller to be made root
    ///   - nc: UINavigationController
    func makeRoot(vc: UIViewController, nc: UINavigationController)
}

/// a presenting provide which will be used by the flow coordinators
protocol PresenterProviding {
    var presenter: Presenting { get }
}

///  Default implementation of `FlowPresenting` protocol
struct DefaultPresenter: Presenting {

    /// Make the given window key and visible
    ///
    /// - Parameter window: `UIWindow` to make key and visible
    func makeKeyAndVisible(window: UIWindow) {
        window.makeKeyAndVisible()
    }

    /// Present the given view controller modally
    ///
    /// - Parameters:
    ///   - vc: View controller to present
    ///   - presentingViewController: View controller to present from
    ///   - animated: `bool` determining whether or not to animate the presentation
    ///   - completion: Closure to call once presentation has completed
    func present(vc: UIViewController,
                 from presentingViewController: UIViewController,
                 animated: Bool, completion: (() -> Void)?) {
        presentingViewController.present(vc, animated: animated, completion: completion)
    }

    /// Dismiss the given modally presented view controller
    ///
    /// - Parameters:
    ///   - presentingViewController: Presenting view controller
    ///   - animated: `bool` determining whether or not to animate the presentation
    ///   - completion: Closure to call once dismissal has completed
    func dismiss(from presentingViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentingViewController.dismiss(animated: animated, completion: completion)
    }

    /// Push a given view controller onto the given navigation controller
    ///
    /// - Parameters:
    ///   - vc: View controller to be pushed
    ///   - nc: Navigation controller onto which `vc` is to be pushed
    ///   - animated: `bool` determining whether or not to animate the presentation
    func push(vc: UIViewController, onto nc: UINavigationController, animated: Bool) {
        nc.pushViewController(vc, animated: animated)
    }

    /// Pop the top view controller off of the given navigation controller
    ///
    /// - Parameters:
    ///   - nc: Navigation controller from which the view controller is to be popped
    ///   - animated: `bool` determining whether or not to animate the presentation
    func pop(nc: UINavigationController, animated: Bool) {
        nc.popViewController(animated: animated)
    }

    /// makes the view passed in as the root view of the navigation controller
    ///
    /// - Parameters:
    ///   - vc: the view controller to be made root
    ///   - nc: UINavigationController
    func makeRoot(vc: UIViewController, nc: UINavigationController) {
        nc.viewControllers = [vc]
    }
}
