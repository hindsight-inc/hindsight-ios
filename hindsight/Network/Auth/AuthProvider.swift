//
//  AuthProvider.swift
//  hindsight
//
//  Created by Leo on 1/30/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Foundation

protocol AuthProviderProtocol {
	func save(token: String)
	func isAuthenticated() -> Bool
}

/// A simple auth provider for early development purpose only
struct SimpleAuthProvider: AuthProviderProtocol {

	private let tokenKey = "bearer_token"

	func save(token: String) {
		UserDefaults.standard.set(token, forKey: tokenKey)
	}

	func isAuthenticated() -> Bool {
		return UserDefaults.standard.string(forKey: tokenKey) != nil
	}
}
