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
import RxSwift

protocol ConnectFlowCoordinatorProtocol {
    func presentLogInAsRoot()
}

struct ConnectFlowCoordinator: ConnectFlowCoordinatorProtocol, PresenterProviding {

    internal let presenter: Presenting

    private let container: Container

    private let navigationController: UINavigationController

    init(presenter: Presenting, container: Container, navigationController: UINavigationController) {
        self.presenter = presenter
        self.container = container
        self.navigationController = navigationController
        //  TODO: @Manish why static func here instead of transient object?
		DependencyConfigurator.registerConnectFlowDependencies(container: container,
															   viewController: self.navigationController)
    }

    private let bag = DisposeBag()

    func presentLogInAsRoot() {
        let vm = LoginViewModel(facebookConnectClosure: {
			let connector = self.container.resolveUnwrapped(SSOConnectorProtocol.self)
            connector.connect()
                .subscribe(
                    onSuccess: { bearer in
                        print("ON success", bearer)
						self.connectSuccess(token: bearer.token ?? "")
                    },
                    onError: { error in
                        print("ON error \(error)")
						self.connectFailure(error: error)
                    }
                )
                .disposed(by: self.bag)
        })
        let vc = LoginViewController(viewModel: vm)
        navigationController.isNavigationBarHidden = true
        presenter.makeRoot(viewController: vc, navigationController: navigationController)
    }

	private func connectSuccess(token: String) {
		// TokenManager().setToken(token)
		// TODO: @Leo how to get next vc? do we get BaseFlowCoordinator here?
		let vc = UIViewController()
		presenter.push(viewController: vc, onto: navigationController, animated: true)
	}

	private func connectFailure(error: Error) {
		let errorPresenter = container.resolveUnwrapped(ErrorPresentingProtocol.self)
		let errorViewController = errorPresenter.errorViewController(error: error)
		navigationController.present(errorViewController, animated: true) {
		}
	}
}
