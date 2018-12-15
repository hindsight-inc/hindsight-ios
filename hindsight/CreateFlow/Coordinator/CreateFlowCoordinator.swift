//
//  CreateFlowCoordinator.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/6/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol CreateFlowCoordinatorProtocol {
    func presentCreateView(nc: UINavigationController)
}

struct CreateFlowCoordinator: CreateFlowCoordinatorProtocol, PresenterProviding {

    internal let presenter: Presenting

    private let container: Container

    private let navigationController: UINavigationController

    init(presenter: Presenting, container: Container, nc: UINavigationController) {
        self.presenter = presenter
        self.container = container
        self.navigationController = nc
        DependencyConfigurator.registerCreateFlowDependencies(container: container)
    }

    func presentCreateView(nc: UINavigationController) {

    }
}
