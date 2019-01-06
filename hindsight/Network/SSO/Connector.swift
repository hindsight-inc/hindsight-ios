//
//  Connector.swift
//  hindsight
//
//  Created by Leo on 1/5/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import RxSwift
import FBSDKLoginKit
import FacebookLogin

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

	func facebookConnect() -> Single<TokenProtocol> {
		return Single<TokenProtocol>.create { single in
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

	func hindsightConnect(token: FBSDKAccessToken, single: @escaping (SingleEvent<TokenProtocol>) -> Void) {
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
						let token = try JSONDecoder().decode(ConnectResponse.self, from: data)
						single(.success(token))
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
