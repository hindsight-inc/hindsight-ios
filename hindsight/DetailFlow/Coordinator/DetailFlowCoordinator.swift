//
//  DetailFlowCoordinator.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/6/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol DetailFlowCoordinatorProtocol {
	mutating func push(from navigationController: UINavigationController, topic: TopicResponse)
    //func presentFeed(navigationController: UINavigationController)
    //func presentDetails(/*feed here,*/navigationController: UINavigationController)
}

struct DetailFlowCoordinator: DetailFlowCoordinatorProtocol, PresenterProviding {

    let presenter: Presenting

    private let container: Container

    private let navigationController: UINavigationController

	private lazy var detailViewController: UIViewController = {
		//let client = container.resolveUnwrapped(DetailAPIClientProtocol.self)
		//let viewModel = DetailViewModel(client: client)

		let storyboard = UIStoryboard(name: "DetailFlow", bundle: nil)
		guard let viewController = storyboard
			.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
		else {
			fatalError("DetailFlowCoordinator: error instantiating DetailViewController")
		}
		//listViewController.viewModel = viewModel

		return viewController
	}()

    init(presenter: Presenting, container: Container, navigationController: UINavigationController) {
        self.presenter = presenter
        self.container = container
        self.navigationController = navigationController
    }

	mutating func push(from navigationController: UINavigationController, topic: TopicResponse) {
		//detailViewModel.topic = topic
		presenter.push(viewController: detailViewController, onto: navigationController, animated: true)
	}

	/*
    func presentFeed(navigationController: UINavigationController) {

    }

    func presentDetails(/*feed here,*/navigationController: UINavigationController) {

    }
	*/
}
