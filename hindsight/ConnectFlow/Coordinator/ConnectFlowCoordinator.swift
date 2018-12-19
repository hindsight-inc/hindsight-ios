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
            self.facebookConnect()
		})
        let vc = LoginViewController(viewModel: vm)
        navigationController.isNavigationBarHidden = true
        presenter.makeRoot(vc: vc, nc: navigationController)
    }

    private let loginManager = FBSDKLoginManager()
    private func facebookConnect() {

        if let token = FBSDKAccessToken.current() {
            print("FB token exists", token.tokenString)
            self.client.connect(token: token.tokenString)
            return
        }

        loginManager.logIn(withReadPermissions: ["public_profile", "user_friends", "email"],
            from: navigationController) { loginResult, error in

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
