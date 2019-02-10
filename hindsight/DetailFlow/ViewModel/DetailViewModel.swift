//
//  DetailViewModel.swift
//  hindsight
//
//  Created by Leo on 2/9/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import RxSwift

protocol DetailViewModelProtocol {
	var topic: Variable<TopicResponse> { get }
	func setup()
}

struct DetailViewModel: DetailViewModelProtocol {
    var topic = Variable<TopicResponse>(TopicResponse())

	func setup() {
		print(topic)
	}
}
