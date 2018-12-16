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
			self.client.connect()
		})
        let vc = LoginViewController(viewModel: vm)
        navigationController.isNavigationBarHidden = true
        presenter.makeRoot(vc: vc, nc: navigationController)
    }
}
