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
    func connector(token: String) -> Single<NetworkResult>
}

struct ConnectAPIClient: ConnectAPIClientProtocol {

    let networkProvider: NetworkProviderProtocol

	/// Connecting to SSO provider, in this version it's always facebook
    func connector(token: String) -> Single<NetworkResult> {
		return networkProvider.connectFacebook(token: token)
	}
}
