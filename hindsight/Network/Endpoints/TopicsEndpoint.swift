//
//  TopicsEndpoint.swift
//  hindsight
//
//  Created by Sanwal, Manish on 10/16/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Moya

enum TopicEndpoint {
	case list(offset: Int, limit: Int)
}

extension TopicEndpoint: TargetType {
	var baseURL: URL {
		guard let url = URL(string: "http://localhost:18182") else {
			fatalError("URL creation failed")
		}
		return url
	}

	var path: String {
		switch self {
		case .list:
			return Constants.NonUI.Network.Topic.List.api
		}
	}

	var method: Moya.Method {
		return .get
	}

	var sampleData: Data {
		return Data()
	}

	var task: Task {
		switch self {
		case .list(let offset, let limit):
			let param = [
				Constants.NonUI.Network.Param.offset: offset,
				Constants.NonUI.Network.Param.limit: limit
			]
			return .requestParameters(parameters:param, encoding: URLEncoding.queryString)
		}
	}

	/// heades for endpoint
	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}

	/// Default parameter encoding.
	public var parameterEncoding: ParameterEncoding {
		return JSONEncoding.default
	}
}
