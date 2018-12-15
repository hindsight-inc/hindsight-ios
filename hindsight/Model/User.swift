//
//  User.swift
//  hindsight
//
//  Created by Sanwal, Manish on 10/16/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation

protocol UserProtocol {
    var username: String { get }
}

struct User: UserProtocol {
    let username: String
}
