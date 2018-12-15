//
//  UserCredentialsProtocol.swift
//  hindsight
//
//  Created by Sanwal, Manish on 10/17/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation

protocol UserCredentialsProtocol {
    var userName: String { get }
    var password: String { get }
}

struct UserCredentials: UserCredentialsProtocol {
    let userName: String
    let password: String
}
