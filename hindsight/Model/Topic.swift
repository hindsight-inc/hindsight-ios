//
//  Topic.swift
//  hindsight
//
//  Created by Sanwal, Manish on 10/16/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation

protocol TopicProtocol {
    var title: String { get }
    var content: String { get }
}

struct Topic: TopicProtocol {
    let title: String
    let content: String
}
