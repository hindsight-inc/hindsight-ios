//
//  UserEndpoint.swift
//  hindsight
//
//  Created by manish on 10/14/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import Moya

enum AuthEndpoint {
    case register(userName: String, password: String)
    case login(userName: String, password: String)
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
