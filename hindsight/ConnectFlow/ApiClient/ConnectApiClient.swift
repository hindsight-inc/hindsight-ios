//
//  ConnectApiClient.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
protocol ConnectApiClientProtocol {
	func connect()
}

struct ConnectApiClient: ConnectApiClientProtocol {

    let networkProvider: NetworkProviderProtocol

	func connect() {
		// why no network call is made?
		_ = networkProvider.connectFacebook(token: "123")
	}
}
