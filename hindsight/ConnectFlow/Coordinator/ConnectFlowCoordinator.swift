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
import FacebookLogin

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
        //  TODO: @manish why static func here instead of transient object?
        DependencyConfigurator.registerConnectFlowDependencies(container: container)
    }

    private let bag = DisposeBag()

    //  TODO: @manish remove nc?
    func presentLogInAsRoot(nc: UINavigationController) {
        let vm = LoginViewModel(facebookConnectClosure: {
            let client = self.container.resolveUnwrapped(ConnectApiClientProtocol.self)
            Connector(client: client, vc: self.navigationController)
				.facebookConnect()
                .subscribe(
                    onSuccess: { model in
                        print("ON success", model)
						self.connectSuccess(token: model.token ?? "")
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
		// TODO: how to get next vc?
		let vc = UIViewController()
		presenter.push(vc: vc, onto: navigationController, animated: true)
	}

	private func connectFailure(error: Error) {
		// TODO: create resolveUnwrapped with arguments
		//let errorPresenter = container.resolveUnwrapped(ErrorPresentingProtocol.self)
		let viewController: UIViewController = navigationController
		let errorPresenter = container.resolve(ErrorPresentingProtocol.self, argument: viewController)!
		errorPresenter.show(error: error)
	}
}

import RxSwift

struct ConnectModel: Decodable {
    var code: Int?
	var expire: String?		// TODO: map to data
    var token: String?
}

struct Connector {

    private var viewController: UIViewController
    private let client: ConnectApiClientProtocol
    private let loginManager = FBSDKLoginManager()
    private let bag = DisposeBag()

    init(client: ConnectApiClientProtocol, vc: UIViewController) {
        self.client = client
        self.viewController = vc

        //FBSDKSettings.enableLoggingBehavior(.none)
        //FBSDKSettings.loggingBehaviors.removeAll()
        loginManager.logOut()
    }

    func facebookConnect() -> Single<ConnectModel> {
        return Single<ConnectModel>.create { single in
            if let token = FBSDKAccessToken.current() {
                print("FB token exists", token.tokenString)
                self.hindsightConnect(token: token, single: single)
                return Disposables.create()
            }

            // TODO: find where FBSDK define these permissions
			let permissions = ["public_profile", "user_friends", "email"]
            self.loginManager.logIn(withReadPermissions: permissions, from: self.viewController) { loginResult, error in

                if let error = error {
                    single(.error(error))
                    print("FB failed", error)
                    return
                }
                guard let result = loginResult else {
                    single(.error(NSError(domain: "FB invalid login result", code: -1)))
                    return
                }
                guard let token = result.token else {
                    single(.error(NSError(domain: "FB invalid login token", code: -1)))
                    return
                }
                print("FB token obtained", token.tokenString)
                self.hindsightConnect(token: token, single: single)
            }
            return Disposables.create()
        }
    }

    func hindsightConnect(token: FBSDKAccessToken, single: @escaping (SingleEvent<ConnectModel>) -> Void) {
        client.connect(token: token.tokenString)
			.subscribe(onSuccess: { result in
				switch result {
				case .success(let data):
					guard let data = data as? Data else {
                        single(.error(NSError(domain: "FB invalid response data", code: -1)))
						return
					}
					//let str = String(data: data, encoding: .utf8)
					//print("ON success", str ?? "nil")
					do {
						let model = try JSONDecoder().decode(ConnectModel.self, from: data)
						single(.success(model))
					} catch let error {
						single(.error(error))
					}
				case .error(let error):
    				single(.error(error))
				}
			}, onError: { error in
				single(.error(error))
			})
			//.disposed(by: self.bag)	// TODO: how to hold `bag` here?
            .disposed(by: globalBag)
    }
}

var globalBag = DisposeBag()
