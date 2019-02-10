//
//  DetailAPIClient.swift
//  hindsight
//
//  Created by Leo on 2/9/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Foundation
import RxSwift

// TODO: fetch details with comments
protocol DetailAPIClientProtocol {
	func topicDetail() -> Single<NetworkResult>
}

struct DetailAPIClient: DetailAPIClientProtocol {

	let networkProvider: NetworkProviderProtocol

	/// List all topics
	func topicDetail() -> Single<NetworkResult> {
		return networkProvider.topicDetail(topic: TopicResponse())
	}
}
