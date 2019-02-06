//
//  ListViewModel.swift
//  hindsight
//
//  Created by Leo on 2/3/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import RxSwift

protocol ListViewModelProtocol {
    var topics: Variable<[TopicResponse]> { get }
	func setup()
}

struct ListViewModel: ListViewModelProtocol {

    var topics = Variable<[TopicResponse]>([TopicResponse]())

	private(set) var client: ListAPIClientProtocol
	private let bag = DisposeBag()

    init(client: ListAPIClientProtocol) {
        self.client = client
    }

	func setup() {
		client.topicLister()
			.subscribe(onSuccess: { result in
				switch result {
				case .success(let data):
					guard let data = data as? Data else {
						print("LIST invalid response data")
						return
					}
					do {
						let topics = try JSONDecoder().decode([TopicResponse].self, from: data)
                        self.topics.value = topics
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

    /*
    private func showFailure(error: Error) {
        let errorPresenter = container.resolveUnwrapped(ErrorPresentingProtocol.self)
        let errorViewController = errorPresenter.errorViewController(error: error)
        navigationController.present(errorViewController, animated: true) {
        }
    }
    */
}
