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
	var nextClosure: TopicClosure { get }

	func setup()
}

struct ListViewModel: ListViewModelProtocol {

    var topics = Variable<[TopicResponse]>([TopicResponse]())
	var nextClosure: TopicClosure

	private(set) var client: ListAPIClientProtocol
	private let bag = DisposeBag()

	init(client: ListAPIClientProtocol, next closure: @escaping TopicClosure) {
        self.client = client
		self.nextClosure = closure
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

	func detailHandler() -> Single<TopicResponse> {
		return Single<TopicResponse>.create { single in
			single(.error(NSError()))
			return Disposables.create()
		}
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
