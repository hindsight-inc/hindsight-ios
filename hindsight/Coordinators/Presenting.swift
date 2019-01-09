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
    ///   - viewController: View controller to present
    ///   - presentingViewController: View controller to present from
    ///   - animated: `bool` determining whether or not to animate the presentation
    ///   - completion: Closure to call once presentation has completed
    func present(viewController: UIViewController,
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
    ///   - viewController: View controller to be pushed
    ///   - navigationController: Navigation controller onto which `viewController` is to be pushed
    ///   - animated: `bool` determining whether or not to animate the presentation
    func push(viewController: UIViewController, onto navigationController: UINavigationController, animated: Bool)

    /// Pop the top view controller off of the given navigation controller
    ///
    /// - Parameters:
    ///   - navigationController: Navigation controller from which the view controller is to be popped
    ///   - animated: `bool` determining whether or not to animate the presentation
    func pop(navigationController: UINavigationController, animated: Bool)

    /// makes the view passed in as the root view of the navigation controller
    ///
    /// - Parameters:
    ///   - viewController: the view controller to be made root
    ///   - navigationController: UINavigationController
    func makeRoot(viewController: UIViewController, navigationController: UINavigationController)
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
    ///   - viewController: View controller to present
    ///   - presentingViewController: View controller to present from
    ///   - animated: `bool` determining whether or not to animate the presentation
    ///   - completion: Closure to call once presentation has completed
    func present(viewController: UIViewController,
                 from presentingViewController: UIViewController,
                 animated: Bool, completion: (() -> Void)?) {
        presentingViewController.present(viewController, animated: animated, completion: completion)
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
    ///   - viewController: View controller to be pushed
    ///   - navigationController: Navigation controller onto which `viewController` is to be pushed
    ///   - animated: `bool` determining whether or not to animate the presentation
    func push(viewController: UIViewController, onto navigationController: UINavigationController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    /// Pop the top view controller off of the given navigation controller
    ///
    /// - Parameters:
    ///   - navigationController: Navigation controller from which the view controller is to be popped
    ///   - animated: `bool` determining whether or not to animate the presentation
    func pop(navigationController: UINavigationController, animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    /// makes the view passed in as the root view of the navigation controller
    ///
    /// - Parameters:
    ///   - viewController: the view controller to be made root
    ///   - navigationController: UINavigationController
    func makeRoot(viewController: UIViewController, navigationController: UINavigationController) {
        navigationController.viewControllers = [viewController]
    }
}
