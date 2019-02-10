//
//  ListFlowCoordinator.swift
//  hindsight
//
//  Created by Leo on 1/26/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Swinject

protocol ListFlowCoordinatorProtocol {
	mutating func push(from navigationController: UINavigationController)
	mutating func makeRoot(from navigationController: UINavigationController)
}

struct ListFlowCoordinator: ListFlowCoordinatorProtocol {
    private(set) var presenter: Presenting
    private let container: Container
    private let nextClosure: TopicClosure

	private lazy var listViewController: UIViewController = {
		let client = container.resolveUnwrapped(ListAPIClientProtocol.self)
		let viewModel = ListViewModel(client: client, next: nextClosure)

		let storyboard = UIStoryboard(name: "ListFlow", bundle: nil)
		guard let viewController = storyboard
			.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
		else {
			fatalError("ListFlowCoordinator: error instantiating ListViewController")
		}
        // TODO: @Manish we have to use property inject here for storyboard based view controllers, right?
		viewController.viewModel = viewModel

		return viewController
	}()

	init(presenter: Presenting, container: Container, next closure: @escaping TopicClosure) {
		self.presenter = presenter
		self.container = container
		self.nextClosure = closure
		DependencyConfigurator.registerListFlowDependencies(container: container)
	}

	mutating func push(from navigationController: UINavigationController) {
		presenter.push(viewController: listViewController, onto: navigationController, animated: true)
	}

	mutating func makeRoot(from navigationController: UINavigationController) {
        presenter.makeRoot(viewController: listViewController, navigationController: navigationController)
	}
}
