//
//  Response.swift
//  hindsight
//
//  Created by Leo on 1/5/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Foundation

/**
 * Models for network responses
 */

/// Response for `/user/connect`
struct ConnectResponse: Decodable {
	var code: Int?
	var expire: String?		// TODO: map to data
	var token: String?
}
