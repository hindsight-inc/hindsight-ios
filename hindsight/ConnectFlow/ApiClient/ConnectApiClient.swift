//
//  ConnectApiClient.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import RxSwift

protocol ConnectApiClientProtocol {
    func connect(token: String) -> Single<NetworkResult>
}

struct ConnectApiClient: ConnectApiClientProtocol {

    let networkProvider: NetworkProviderProtocol

    func connect(token: String) -> Single<NetworkResult> {
		return networkProvider.connectFacebook(token: token)
	}
}
