//
//  ListAPIClient.swift
//  hindsight
//
//  Created by Leo on 1/28/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Foundation
import RxSwift

protocol ListAPIClientProtocol {
	func topicLister() -> Single<NetworkResult>
}

struct ListAPIClient: ListAPIClientProtocol {

	let networkProvider: NetworkProviderProtocol

	/// List all topics
	func topicLister() -> Single<NetworkResult> {
		return networkProvider.topics()
	}
}
