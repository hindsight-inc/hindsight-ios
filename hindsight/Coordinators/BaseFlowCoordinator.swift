//
//  BaseFlowCoordinator.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol BaseFlowCoorinatorProtocol {

}

/// TODO @Manish: `BaseFlowCoordinator` sounds a bit misleading, as `Base` usually suggests it's a base class.
/// How about `RootFlowCoordinator` which indicates it hands root level navigation etc.?
class BaseFlowCoordinator: PresenterProviding {

    // MARK: - Properties

    /// `Presenting` object responsible for view controller presentation
    var presenter: Presenting

    /// The main window
    private let mainWindow = UIWindow(frame: UIScreen.main.bounds)

    /// root navigation controller
    private let navigationController = UINavigationController()

    /// A `Swinject` Dependency Injection Container
    private let container = Container()

    lazy var connectFlow: ConnectFlowCoordinatorProtocol = {
        ConnectFlowCoordinator(presenter: presenter,
                               container: Container(parent: container),
                               navigationController: navigationController)
    }()

	lazy var listFlow: ListFlowCoordinatorProtocol = {
		ListFlowCoordinator(presenter: presenter, container: Container(parent: container), next: { topic in
			self.detailFlow.push(from: self.navigationController, topic: topic)
		})
	}()

	lazy var detailFlow: DetailFlowCoordinatorProtocol = {
		DetailFlowCoordinator(presenter: presenter,
							  container: Container(parent: container),
							  navigationController: navigationController)
	}()

//    lazy var createFlow: ConnectFlowCoordinatorProtocol = {
//        ConnectFlowCoordinator(presenter: presenter,
//                               container: Container(parent: container),
//                               nc: navigationController)
//    }()

    // MARK: - Initialization

    /// Initialize a `BaseFlowCoordinator` with a `Presenting` object
    ///
    /// - parameter presenter: Responsible for view controller presentation
    ///
    /// - returns: Initialized `BaseFlowCoordinator`
    init(presenter: Presenting) {
        self.presenter = presenter
        DependencyConfigurator.registerCoreDependencies(container: container)
    }

    /// Configures the `mainWindow` with its `rootViewController` and presents it
    /// Called by the `AppController` during launch to present the user interface
    ///
    /// - Parameters:
    ///   - application: The running `UIApplication`.
    ///   - launchOptions: launch-time options via `UIApplicationDelegate`.
    /// - Returns: Whether or not `RootFlowCoordinator` can handle the launch
    ///            directives prescribed in the `launchOptions` dictionary.
    func presentRootInterface(application: UIApplication,
                              withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationControllerForLaunch(navigationController: navigationController)
        configureWindow(window: mainWindow, rootNavigationController: navigationController)
        presenter.makeKeyAndVisible(window: mainWindow)

		let authProvider = container.resolveUnwrapped(AuthProviderProtocol.self)
		if !authProvider.isAuthenticated() {
    		connectFlow.presentLogInAsRoot {
        		self.listFlow.push(from: self.navigationController)
    		}
		} else {
			self.listFlow.makeRoot(from: navigationController)
		}
        return true
    }

    // MARK: - NavigationController Configuration

    /// Configure a `UINavigationController` to present a `LaunchViewController` as it's top view controller
    ///
    /// - Parameter nc: `UINavigationController` to configure
    func configureNavigationControllerForLaunch(navigationController: UINavigationController) {
        // configure navigationBar here
    }

    // MARK: - Configure Window

    /// Configure a window with a root `UINavigationController` and set `UIAppearance` settings
    ///
    /// - Parameters:
    ///   - window: the window to configure
    ///   - rootNavigationController: the navigation controller to be the `window`'s `rootViewController`
    private func configureWindow(window: UIWindow, rootNavigationController: UINavigationController) {

        window.backgroundColor = UIColor.white
        window.rootViewController = rootNavigationController
        // Temporary location for UI appearance setup
        rootNavigationController.navigationBar.isTranslucent = false
        UINavigationBar.appearance().barTintColor = ColorName.hindsightTheme.color
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: ColorName.hindsightWhite.color]
        // font - NSFontAttributeName: FontFamily.Interstate.regular.font(size: 16.0)
    }
}
