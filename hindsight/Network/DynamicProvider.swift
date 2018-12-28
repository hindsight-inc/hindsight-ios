//
//  DynamicProvider.swift
//  hindsight
//
//  Created by Sanwal, Manish on 10/16/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import Moya
import RxSwift

/// The dynamic base URL provider
/// This class wraps the endpoints defined in the app and provide functionality to
/// dynamically change the URL based on configuration.
struct DynamicTarget: TargetType {
    /// The base URL based on configuration
    let baseURL: URL

    /// the actual target
    private let target: TargetType

    /// Initializer
    ///
    /// - Parameters:
    ///   - baseURL: base URL
    ///   - target: target
    init(baseURL: URL, target: TargetType) {
        self.baseURL = baseURL
        self.target = target
    }

    /// TargetType path
    var path: String {
        return target.path
    }

    /// TargetType method
    var method: Moya.Method {
        return target.method
    }

    /// TargetType sampleData
    var sampleData: Data {
        return target.sampleData
    }

    /// TargetType task
    var task: Task {
        return target.task
    }

    /// TargetType headers
    var headers: [String: String]? {
        return target.headers
    }
}

/// a Dynamic provider
class DynamicProvider: MoyaProvider<DynamicTarget> {
    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
}

// MARK: - Reactive extension
/// we are just routing the calls to actual target type
extension Reactive where Base: DynamicProvider {
    func request(_ token: TargetType, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
//        let p = MoyaProvider<AuthEndpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
//        return p.rx.request(.refresh)

//
        let dynamicTarget = DynamicTarget(baseURL: base.baseURL, target: AuthEndpoint.ping)
        let provider = MoyaProvider<DynamicTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
//        provider.request(dynamicTarget) { res in
//            print(res)
//        }
        return provider.rx.request(dynamicTarget, callbackQueue: callbackQueue)
    }

    func requestWithProgress(_ token: TargetType, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        let dynamicTarget = DynamicTarget(baseURL: base.baseURL, target: token)
        let provider = MoyaProvider<DynamicTarget>()
        return provider.rx.requestWithProgress(dynamicTarget, callbackQueue: callbackQueue)
    }
}
