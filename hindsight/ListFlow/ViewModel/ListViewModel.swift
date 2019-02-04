//
//  ListViewModel.swift
//  hindsight
//
//  Created by Leo on 2/3/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import RxSwift

protocol ListViewModelProtocol {
	func setup()
}

struct ListViewModel: ListViewModelProtocol {

	private(set) var client: ListAPIClientProtocol
	private let bag = DisposeBag()

	func setup() {
		client.topicLister()
			.subscribe(onSuccess: { result in
				switch result {
				case .success(let data):
					guard let data = data as? Data else {
						print("LIST invalid response data")
						return
					}
					print("LIST on success", result)
					do {
						let topics = try JSONDecoder().decode([TopicResponse].self, from: data)
						print("LIST topics", topics)
					} catch let error {
						print("LIST decoding error", error)
					}
				case .error(let error):
					print("LIST result error", error)
				}
			}, onError: { error in
				print("LIST on error \(error)")
			})
			.disposed(by: bag)
	}
}
