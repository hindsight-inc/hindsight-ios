//
//  ConnectApiClient.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import RxSwift

protocol ConnectAPIClientProtocol {
    func connect(token: String) -> Single<NetworkResult>
}

struct ConnectApiClient: ConnectAPIClientProtocol {

    let networkProvider: NetworkProviderProtocol

	// TODO: @Leo rename to `connector`?
	// (If connectSubscription or connectObservable or connectSignal... are not preferred)
    func connect(token: String) -> Single<NetworkResult> {
		return networkProvider.connectFacebook(token: token)
	}
}
