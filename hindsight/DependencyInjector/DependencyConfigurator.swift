//
//  DependencyConfigurator.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import Swinject

/// Configure dependencies for the app
struct DependencyConfigurator {
    /// register core dependencies to start the app
    ///
    /// - Parameter container: a swinject container
    static func registerCoreDependencies(container: Container) {
        container.register(NetworkProviderProtocol.self) { _ in
			// TODO: @Manish There is an issue inside Moya's RX extension that causes `[weak base]` to be nil.
            //NetworkProvider(sourceBehaviour: .stubbed)
            MoyaNetworkProvider()
        }
    }

    /// Register dependencies for connect flow
    ///
    /// - Parameter container: a swinject container
    static func registerConnectFlowDependencies(container: Container, presenter: UIViewController) {
		/// Resolving top level dependencies
        let networkProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)

		/// Registering coordinator level dependencies
		container.register(ConnectApiClientProtocol.self) { _ in
			ConnectApiClient(networkProvider: networkProvider)
		}
		container.register(ErrorPresentingProtocol.self) { _, viewController in
			AlertErrorPresenter(viewController: viewController)
		}
        let client = container.resolveUnwrapped(Service.Type)
		container.register(SSOConnectorProtocol.self) { _, client in
			//FacebookConnector(client: client, viewController: presenter)
            AnotherConnector(client: client)
		}
    }

    /// Register dependencies for Detail flow
    ///
    /// - Parameter container: a swinject container
    static func registerDetailFlowDependencies(container: Container) {
        let nwProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)
        print(nwProvider)
    }

    /// Register dependencies for create flow
    ///
    /// - Parameter container: a swinject container
    static func registerCreateFlowDependencies(container: Container) {
        let nwProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)
        print(nwProvider)
    }
}
