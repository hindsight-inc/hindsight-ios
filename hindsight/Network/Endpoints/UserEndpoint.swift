//
//  UserEndpoint.swift
//  hindsight
//
//  Created by manish on 10/14/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import Moya

/// Authentication endpoints
enum AuthEndpoint {
    case register(userName: String, password: String)
    case login(userName: String, password: String)
	/// Connect method is hard-coded as `facebook` for v1;
    /// it shall be exposed when more than one connect methods are supported
	case connect(accessToken: String)
    case refresh
}

extension AuthEndpoint: TargetType {
    var baseURL: URL {
        fatalError("Control should not come here, get the base URL from DynamicProvider")
    }

    var path: String {
        switch self {
        case .register:
            return Constants.NonUI.Network.Auth.Register.api
        case .login:
            return Constants.NonUI.Network.Auth.Login.api
        case .connect:
			return Constants.NonUI.Network.Auth.Connect.api
        case .refresh:
            return Constants.NonUI.Network.Auth.Refresh.api
        }
    }

    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .login:
            return .post
        case .connect:
			return .post
        case .refresh:
            return .get
		}
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .login(let userName, let password):
            return .requestParameters(parameters: [Constants.NonUI.Network.Auth.Login.Param.username: userName,
                                                   Constants.NonUI.Network.Auth.Login.Param.password: password],
                                      encoding: URLEncoding.default)
        case .register(let userName, let password):
			return .requestParameters(parameters: [Constants.NonUI.Network.Auth.Login.Param.username: userName,
												   Constants.NonUI.Network.Auth.Login.Param.password: password],
									  encoding: URLEncoding.default)
        case .connect(let token):
            return .requestParameters(parameters:
                [Constants.NonUI.Network.Auth.Connect.Param.method:
                    Constants.NonUI.Network.Auth.Connect.Param.Methods.facebook,
                Constants.NonUI.Network.Auth.Connect.Param.accessToken: token],
                encoding: URLEncoding.default)
        case .refresh:
            return .requestPlain
        }
    }

    /// heades for endpoint
    var headers: [String: String]? {
        return nil
    }

    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}

/// SSO endpoints
enum ConnectEndpoint {
	case connect(accessToken: String)
}

extension ConnectEndpoint: TargetType {
	var baseURL: URL {
		guard let url = URL(string: "http://localhost:18182") else {
			fatalError("URL creation failed")
		}
		return url
	}

	var path: String {
		switch self {
		case .connect:
			return Constants.NonUI.Network.Auth.Connect.api
		}
	}

	var method: Moya.Method {
		return .post
	}

	var sampleData: Data {
		return Data()
	}

	var task: Task {
		switch self {
		case .connect(let token):
			let param = [
				Constants.NonUI.Network.Auth.Connect.Param.method: Constants.NonUI.Network.Auth.Connect.Param.Methods.facebook,
				Constants.NonUI.Network.Auth.Connect.Param.accessToken: token
			]
			return .requestParameters(parameters:param, encoding: JSONEncoding.default)
		}
	}

	/// heades for endpoint
	var headers: [String: String]? {
		return ["Content-type": "application/json"]
	}

	/// The method used for parameter encoding.
	public var parameterEncoding: ParameterEncoding {
		return JSONEncoding.default
	}
}
