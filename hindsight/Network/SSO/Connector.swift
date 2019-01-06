//
//  Connector.swift
//  hindsight
//
//  Created by Leo on 1/5/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import RxSwift
import FacebookCore
import FacebookLogin

/// SSO connector. For now other than facebook connect,
/// we don't have anything else in mind, so it's in its simplest form.
struct Connector {

	private var viewController: UIViewController
	private let client: ConnectApiClientProtocol
	private let loginManager = LoginManager()
	private let bag = DisposeBag()

	init(client: ConnectApiClientProtocol, viewController: UIViewController) {
		self.client = client
		self.viewController = viewController

		//FBSDKSettings.enableLoggingBehavior(.none)
		//FBSDKSettings.loggingBehaviors.removeAll()
		loginManager.logOut()
	}

	func facebookConnect() -> Single<TokenProtocol> {
		return Single<TokenProtocol>.create { single in
			if let token = AccessToken.current {
				print("FB token exists", token.authenticationToken)
				self.hindsightConnect(token: token, single: single)
				return Disposables.create()
			}

			let permissions: [ReadPermission] = [
				.publicProfile,
				.userFriends,
				.email
			]
			self.loginManager.logIn(readPermissions: permissions, viewController: self.viewController) { result in
				switch result {
				case .success(_, _, let token):
    				self.hindsightConnect(token: token, single: single)
				case .failed(let error):
					single(.error(error))
				case .cancelled:
					single(.error(NSError(domain: "FB connect cancelled", code: -1)))
				}
			}
			return Disposables.create()
		}
	}

	func hindsightConnect(token: AccessToken, single: @escaping (SingleEvent<TokenProtocol>) -> Void) {
		client.connect(token: token.authenticationToken)
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
