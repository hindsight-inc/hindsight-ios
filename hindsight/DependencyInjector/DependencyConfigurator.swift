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
            NetworkProvider(sourceBehaviour: .local)
        }
    }

    /// Register dependencies for connect flow
    ///
    /// - Parameter container: a swinject container
    static func registerConnectFlowDependencies(container: Container) {
        let nwProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)
        container.register(ConnectApiClientProtocol.self) { _ in
            ConnectApiClient(networkProvider: nwProvider)
        }
    }

    /// Register dependencies for Detail flow
    ///
    /// - Parameter container: a swinject container
    static func registerDetailFlowDependencies(container: Container) {
        let nwProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)
    }

    /// Register dependencies for create flow
    ///
    /// - Parameter container: a swinject container
    static func registerCreateFlowDependencies(container: Container) {
        let nwProvider = container.resolveUnwrapped(NetworkProviderProtocol.self)
    }
}
