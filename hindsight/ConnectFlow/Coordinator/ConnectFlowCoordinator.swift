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
	// who owns API client?
	private let client: ConnectApiClientProtocol

    private let navigationController: UINavigationController

    init(presenter: Presenting, container: Container, nc: UINavigationController) {
        self.presenter = presenter
        self.container = container
        self.navigationController = nc
        DependencyConfigurator.registerConnectFlowDependencies(container: container)

		client = container.resolveUnwrapped(ConnectApiClientProtocol.self)
    }

    func presentLogInAsRoot(nc: UINavigationController) {
        let vm = LoginViewModel(facebookConnectClosure: {
            self.facebookLoginTest()
		})
        let vc = LoginViewController(viewModel: vm)
        navigationController.isNavigationBarHidden = true
        presenter.makeRoot(vc: vc, nc: navigationController)
    }

    private let loginManager = FBSDKLoginManager()
    private func facebookLoginTest() {

        loginManager.logIn(withReadPermissions: ["public_profile", "user_friends", "email"],
            from: navigationController) { loginResult, error in

            if let error = error {
                print(error)
                return
            }
            guard let result = loginResult else {
                print("invalid result")
                return
            }
            guard let token = result.token else {
                print("invalid token")
                return
            }
            print(result, token)
            self.client.connect(token: token.tokenString)
        }
    }
}
