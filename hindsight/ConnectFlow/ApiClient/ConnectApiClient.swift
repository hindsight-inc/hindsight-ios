//
//  ConnectApiClient.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
protocol ConnectApiClientProtocol {
	func connect(token: String)
}

struct ConnectApiClient: ConnectApiClientProtocol {

    let networkProvider: NetworkProviderProtocol

    func connect(token: String) {
		_ = networkProvider.connectFacebook(token: token)
	}
}
