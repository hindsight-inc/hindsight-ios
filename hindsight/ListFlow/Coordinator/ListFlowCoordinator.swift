//
//  ListFlowCoordinator.swift
//  hindsight
//
//  Created by Leo on 1/26/19.
//  Copyright © 2019 hindsight-inc. All rights reserved.
//

import UIKit
import Swinject
import RxSwift

protocol ListFlowCoordinatorProtocol {
	func push(from navigationController: UINavigationController)
}

struct ListFlowCoordinator: ListFlowCoordinatorProtocol {
    private(set) var presenter: Presenting
    private let container: Container

	init(presenter: Presenting, container: Container) {
		self.presenter = presenter
		self.container = container
		DependencyConfigurator.registerListFlowDependencies(container: container)
	}

	func push(from navigationController: UINavigationController) {
		let client = container.resolveUnwrapped(ListAPIClientProtocol.self)
		let viewModel = ListViewModel(client: client)

		let storyboard = UIStoryboard(name: "ListFlow", bundle: nil)
		guard let listViewController = storyboard
			.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else {
				return
		}
		listViewController.viewModel = viewModel
		presenter.push(viewController: listViewController, onto: navigationController, animated: true)
	}
}

class ListViewController: UIViewController {

	@IBOutlet var tableView: UITableView!

	var viewModel: ListViewModelProtocol!

	/*
	init(viewModel: ListViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    */

	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.setup()
	}
}

protocol ListViewModelProtocol {
	func setup()
}

struct ListViewModel: ListViewModelProtocol {

	private(set) var client: ListAPIClientProtocol
    private let bag = DisposeBag()

	func setup() {
		client.topicLister()
			.subscribe(onSuccess: { result in
				print("ON success", result)
			}, onError: { error in
				print("ON error \(error)")
			})
			.disposed(by: bag)
	}
}
