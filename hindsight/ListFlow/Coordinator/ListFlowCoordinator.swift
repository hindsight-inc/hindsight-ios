//
//  ListFlowCoordinator.swift
//  hindsight
//
//  Created by Leo on 1/26/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import Swinject

protocol ListFlowCoordinatorProtocol {
	func push(from navigationController: UINavigationController)
	func makeRoot(from navigationController: UINavigationController)
}

final class ListFlowCoordinator: ListFlowCoordinatorProtocol {
    private(set) var presenter: Presenting
    private let container: Container

	private lazy var listViewController: UIViewController = {
		let client = container.resolveUnwrapped(ListAPIClientProtocol.self)
		let viewModel = ListViewModel(client: client)

		let storyboard = UIStoryboard(name: "ListFlow", bundle: nil)
		guard let listViewController = storyboard
			.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
		else {
			fatalError("ListFlowCoordinator: error instantiating ListViewController")
		}
        // TODO: @Manish we have to use property inject here for storyboard based view controllers, right?
		listViewController.viewModel = viewModel

		return listViewController
	}()

	init(presenter: Presenting, container: Container) {
		self.presenter = presenter
		self.container = container
		DependencyConfigurator.registerListFlowDependencies(container: container)
	}

	func push(from navigationController: UINavigationController) {
		presenter.push(viewController: listViewController, onto: navigationController, animated: true)
	}

	func makeRoot(from navigationController: UINavigationController) {
        presenter.makeRoot(viewController: listViewController, navigationController: navigationController)
	}
}
