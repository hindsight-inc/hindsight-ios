//
//  Container+UnwrappedResolved.swift
//  hindsight
//
//  Created by Sanwal, Manish on 11/5/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import Swinject

// swiftlint:disable force_unwrapping
extension Resolver {
    /// Resolve a given `Service.Type` to the registered Service.
    /// This method will `fatalError` if no `Service` is registered for `Service.Type`,
    /// rather than the default which will return an implicitly unwrapped optional.
    ///
    /// - Parameter type: A given `Service.Type` which needs to be resolved to a concrete instance
    /// - Returns: An instance of `Service` that the `Service.Type` is registered for
	func resolveUnwrapped<Service>(_ type: Service.Type) -> Service {
		let result = resolve(type)
		assert(result != nil, String(format: "Could not resolve type %@", String(describing: type)))
		return result!
	}

    /// Resolve a given `Service.Type` to the registered Service with 1 argument.
	func resolveUnwrapped<Service, Arg>(_ type: Service.Type, argument: Arg) -> Service {
		let result = resolve(type, argument: argument)
		assert(result != nil, String(format:
			"Could not resolve type %@ with 1 argument", String(describing: type)))
		return result!
	}

    /// Resolve a given `Service.Type` to the registered Service with 2 arguments.
	func resolveUnwrapped<Service, Arg1, Arg2>(_ type: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
		// Swinject doesn't use `Any...`, so we'll have to create different versions to support up to `arg9`
		let result = resolve(type, arguments: arg1, arg2)
        assert(result != nil, String(format:
			"Could not resolve type %@ with 2 arguments", String(describing: type)))
        return result!
    }
}
// swiftlint:enable force_unwrapping
