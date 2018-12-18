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
                               nc: navigationController)
    }()

    lazy var detailFlow: DetailFlowCoordinatorProtocol = {
        DetailFlowCoordinator(presenter: presenter,
                               container: Container(parent: container),
                               nc: navigationController)
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
        configureNavigationControllerForLaunch(nc: navigationController)
        configureWindow(window: mainWindow, rootNavigationController: navigationController)
        presenter.makeKeyAndVisible(window: mainWindow)
        connectFlow.presentLogInAsRoot(nc: navigationController)
        return true
    }

    // MARK: - NavigationController Configuration

    /// Configure a `UINavigationController` to present a `LaunchViewController` as it's top view controller
    ///
    /// - Parameter nc: `UINavigationController` to configure
    func configureNavigationControllerForLaunch(nc: UINavigationController) {
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
