//
//  ConnectFlowCoordinator.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import FBSDKLoginKit

protocol ConnectFlowCoordinatorProtocol {
    func presentLogInAsRoot(nc: UINavigationController)
}

struct ConnectFlowCoordinator: ConnectFlowCoordinatorProtocol, PresenterProviding {

    internal let presenter: Presenting

    private let container: Container

    private let navigationController: UINavigationController

    init(presenter: Presenting, container: Container, nc: UINavigationController) {
        self.presenter = presenter
        self.container = container
        self.navigationController = nc
        DependencyConfigurator.registerConnectFlowDependencies(container: container)

    }

    func presentLogInAsRoot(nc: UINavigationController) {
        let vm = LoginViewModel(facebookConnectClosure: {
            Connector(container: self.container, vc: self.navigationController).facebookConnect()
		})
        let vc = LoginViewController(viewModel: vm)
        navigationController.isNavigationBarHidden = true
        presenter.makeRoot(vc: vc, nc: navigationController)
    }
}

struct Connector {

    private let container: Container
    private var viewController: UIViewController
    private let client: ConnectApiClientProtocol
    private let loginManager = FBSDKLoginManager()

    init(container: Container, vc: UIViewController) {
        self.container = container
        self.viewController = vc
        self.client = container.resolveUnwrapped(ConnectApiClientProtocol.self)
    }

    func facebookConnect() {

        if let token = FBSDKAccessToken.current() {
            print("FB token exists", token.tokenString)
            self.client.connect(token: token.tokenString)
            return
        }

        loginManager.logIn(withReadPermissions: ["public_profile", "user_friends", "email"],
            from: viewController) { loginResult, error in

            if let error = error {
                print("FB failed", error)
                return
            }
            guard let result = loginResult else {
                print("FB invalid result")
                return
            }
            guard let token = result.token else {
                print("FB invalid token")
                return
            }
            print("FB token obtained", token.tokenString)
            self.client.connect(token: token.tokenString)
        }
    }
}
