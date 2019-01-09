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
        //  TODO: @Manish why static func here instead of transient object?
		DependencyConfigurator.registerConnectFlowDependencies(container: container, viewController: self.navigationController)
    }

    private let bag = DisposeBag()

    //  TODO: @Manish remove nc as we are using self.navigationController?
    func presentLogInAsRoot(nc: UINavigationController) {
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
        presenter.makeRoot(vc: vc, nc: navigationController)
    }

	private func connectSuccess(token: String) {
		// TokenManager().setToken(token)
		// TODO: @Leo how to get next vc?
		let vc = UIViewController()
		presenter.push(vc: vc, onto: navigationController, animated: true)
	}

	private func connectFailure(error: Error) {
		let errorPresenter = container.resolveUnwrapped(ErrorPresentingProtocol.self)
		let errorViewController = errorPresenter.errorViewController(error: error)
		navigationController.present(errorViewController, animated: true) {
		}
	}
}
