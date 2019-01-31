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
		container.register(AuthProviderProtocol.self) { _ in
			SimpleAuthProvider()
		}
    }

    /// Register dependencies for connect flow
    ///
    /// - Parameter container: a Swinject container
    /// - Parameter viewController: a `UIViewController` that is required for some specific implemention(s),
	/// i.e. `FacebookConnector`
    static func registerConnectFlowDependencies(container: Container, viewController: UIViewController) {
		/// Resolving top level dependencies
        let networkProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)

		/// Registering coordinator level dependencies
		container.register(ConnectAPIClientProtocol.self) { _ in
			ConnectAPIClient(networkProvider: networkProvider)
		}
		container.register(ErrorPresentingProtocol.self) { _ in
			AlertErrorPresenter()
		}
        let client = container.resolveUnwrapped(ConnectAPIClientProtocol.self)
		container.register(SSOConnectorProtocol.self) { _ in
			FacebookConnector(client: client, viewController: viewController)
		}
    }

	static func registerListFlowDependencies(container: Container) {
		/// Resolving top level dependencies
		let networkProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)

		/// Registering coordinator level dependencies
		container.register(ListAPIClientProtocol.self) { _ in
			ListAPIClient(networkProvider: networkProvider)
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
