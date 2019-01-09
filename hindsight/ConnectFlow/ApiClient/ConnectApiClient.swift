//
//  ConnectApiClient.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import RxSwift

// TODO: @Leo rename to ConnnectAPIClientProtocol etc.?
protocol ConnectAPIClientProtocol {
    func connect(token: String) -> Single<NetworkResult>
}

struct ConnectApiClient: ConnectAPIClientProtocol {

    let networkProvider: NetworkProviderProtocol

	// TODO: @Leo rename to `connectObservable` etc.?
    func connect(token: String) -> Single<NetworkResult> {
		return networkProvider.connectFacebook(token: token)
	}
}
