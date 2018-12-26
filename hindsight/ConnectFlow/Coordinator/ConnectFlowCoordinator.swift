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
        //  TODO: @manish why static func here?
        DependencyConfigurator.registerConnectFlowDependencies(container: container)
    }

    //  TODO: @manish remove nc?
    func presentLogInAsRoot(nc: UINavigationController) {
        let vm = LoginViewModel(facebookConnectClosure: {
            let bag = DisposeBag()
            let subscription = Connector(container: self.container, vc: self.navigationController)
                .facebookConnect()
                .subscribe { event in
                    print("FB event: \(event)")
                }
            subscription.disposed(by: bag)
        })
        let vc = LoginViewController(viewModel: vm)
        navigationController.isNavigationBarHidden = true
        presenter.makeRoot(vc: vc, nc: navigationController)
    }
}

import RxSwift

struct Connector {

    private let container: Container
    private var viewController: UIViewController
    private let client: ConnectApiClientProtocol
    private let loginManager = FBSDKLoginManager()

    init(container: Container, vc: UIViewController) {
        self.container = container
        self.viewController = vc
        self.client = container.resolveUnwrapped(ConnectApiClientProtocol.self)
        loginManager.logOut()
    }

    func facebookConnect() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            if let token = FBSDKAccessToken.current() {
                print("FB token exists", token.tokenString)
                self.client.connect(token: token.tokenString)
                observer.onNext(false)
                observer.onCompleted()
                return Disposables.create()
            }

            self.loginManager.logIn(withReadPermissions: ["public_profile", "user_friends", "email"], from: self.viewController) { loginResult, error in

                if let error = error {
                    observer.onNext(false)
                    observer.onCompleted()
                    print("FB failed", error)
                    return
                }
                guard let result = loginResult else {
                    observer.onNext(false)
                    observer.onCompleted()
                    print("FB invalid result")
                    return
                }
                guard let token = result.token else {
                    observer.onNext(false)
                    observer.onCompleted()
                    print("FB invalid token")
                    return
                }
                print("FB token obtained", token.tokenString)
                self.client.connect(token: token.tokenString)
                observer.onNext(true)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
