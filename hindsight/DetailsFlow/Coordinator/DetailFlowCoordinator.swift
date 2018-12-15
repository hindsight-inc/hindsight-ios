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
    func presentFeed(nc: UINavigationController)
    func presentDetails(/*feed here,*/nc: UINavigationController)
}

struct DetailFlowCoordinator: DetailFlowCoordinatorProtocol, PresenterProviding {

    internal let presenter: Presenting

    private let container: Container

    private let navigationController: UINavigationController

    init(presenter: Presenting, container: Container, nc: UINavigationController) {
        self.presenter = presenter
        self.container = container
        self.navigationController = nc
    }

    func presentFeed(nc: UINavigationController) {

    }
    func presentDetails(/*feed here,*/nc: UINavigationController) {

    }
}
