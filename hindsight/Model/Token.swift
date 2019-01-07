//
//  File.swift
//  hindsight
//
//  Created by Leo on 1/5/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Foundation

/// Bearer token
protocol TokenProtocol: Decodable {
	var token: String? { get }
}

extension ConnectResponse: TokenProtocol {
}
