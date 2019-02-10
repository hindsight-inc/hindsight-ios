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
	var expire: String?		// Example: "2030-06-03T15:53:50-04:00"
	var token: String?
}

struct FacebookUserResponse: Decodable {
	var id: Int?
	var name: String?
	var avatar_url: String?
}

struct UserResponse: Decodable {
	var id: Int?
	var username: String?
	var facebook_user: FacebookUserResponse?
}

struct OpinionResponse: Decodable {
	var id: Int?
	var title: String?
	var vote_count: Int?
}

struct TopicResponse: Decodable {
	var id: Int?
	var author: UserResponse?
	var title: String?
	var content: String?
	var cover_id: Int?
	var milestone_deadline: String?		// Example: "2018-12-02T17:04:06-05:00"
	var opinions: [OpinionResponse]?
}
