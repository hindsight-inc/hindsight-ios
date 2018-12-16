//
//  NetworkProvider.swift
//  hindsight
//
//  Created by Sanwal, Manish on 10/17/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import RxSwift
import Moya

enum Result<T> {
    case success(T)
    case error(HindsightError)
}

enum HindsightError: Error {
    /// A struct to represent web service error
    struct WebServiceError {
        /// webservice error code
        let code: Int?
        /// webservice error message
        let message: String?
        /// webservice error resolve
        let resolve: String?
    }

    /// - webServiceError(wsError: WebServiceError): a webservice error
    case webServiceError(wsError: WebServiceError)

    /// An Enum type to abstract all object mapping errors
    ///
    /// - missingRequiredKey: missing a required key in mapping.
    /// - incorrectType: value is not of correct data type
    /// - ambiguousKey: the key can not be resolved uniquely or unknown key
    enum ObjectMappingError {
        case missingRequiredKey
        case incorrectType
        case ambiguousKey
    }

    /// - objectMappingError(mappingError: ObjectMappingError): an object mapping error.
    case objectMappingError(mappingError: ObjectMappingError)

    /// - unableToCast: unable to type cast exception
    case unableToCast

    /// - decodingError- a general object decoding error.
    case decodingError

    /// - missingRequiredInput - a method doesn't have required input to function
    case missingRequiredInput

    /// NotImplemented- method not impleted
    case NotImplemented
}

enum SourceBehaviour {
    case prod
    case local
    case mock
    case stubbed

    func baseUrl() -> URL {
        switch self {
        case .prod:
            return URL(string: "superarts.ddns.net:18182")!
        case .local:
			return URL(string: "localhost:18182")!
        case .mock:
            return URL(string: "localhost:18182")!
        case .stubbed:
            return URL(string: "superarts.ddns.net:18182")!
        }
    }
}

typealias NetworkResult = Result<Any?>

/// Describe Network operations
protocol NetworkProviderProtocol {

    /// Register User
    ///
    /// - Parameter user: user credentials
    /// - Returns: Single<Result<Bool>>
    func register(user: UserCredentialsProtocol) -> Single<NetworkResult>

    /// Login User
    ///
    /// - Parameter user: user credentials
    /// - Returns: Single<Result<Bool>>
    func login(user: UserCredentialsProtocol) -> Single<NetworkResult>

	/// Connect User
	///
	/// - Parameter token: access token
	/// - Returns: Single<Result<Bool>>
	func connectFacebook(token: String) -> Single<NetworkResult>

    /// get a list of topics
    ///
    /// - Returns: Single<Result<[TopicProtocol]>>
    func topics() -> Single<NetworkResult>

    /// create a topic
    ///
    /// - Parameter topic: a topic
    /// - Returns: Single<Result<TopicProtocol>>
    func create(topic: TopicProtocol) -> Single<NetworkResult>

    /// get details of a topic
    ///
    /// - Parameter topic: Topic
    /// - Returns: Single<Result<TopicProtocol>>
    func details(topic: TopicProtocol) -> Single<NetworkResult>
}

struct NetworkProvider: NetworkProviderProtocol {

    let sourceBehaviour: SourceBehaviour

    /// Register User
    ///
    /// - Parameter user: user credentials
    /// - Returns: Single<Result<Bool>>
    func register(user: UserCredentialsProtocol) -> Single<NetworkResult> {
        return webServiceRequest(method: AuthEndpoint.register(userName: user.userName, password: user.password))
    }

	/// Login User
	///
	/// - Parameter user: user credentials
	/// - Returns: Single<Result<Bool>>
	func login(user: UserCredentialsProtocol) -> Single<NetworkResult> {
		return webServiceRequest(method: AuthEndpoint.login(userName: user.userName, password: user.password))
	}

    /// Connect User
    ///
    /// - Parameter token: access token
    /// - Returns: Single<Result<Bool>>
    func connectFacebook(token: String) -> Single<NetworkResult> {
		print("Connecting to facebook...")
        return webServiceRequest(method: AuthEndpoint.connect(accessToken: token))
    }

    /// get a list of topics
    ///
    /// - Returns: Single<Result<[TopicProtocol]>>
    func topics() -> Single<NetworkResult> {
        return Variable(Result.error(.NotImplemented)).asObservable().asSingle()
    }

    /// create a topic
    ///
    /// - Parameter topic: a topic
    /// - Returns: Single<Result<TopicProtocol>>
    func create(topic: TopicProtocol) -> Single<NetworkResult> {
        return Variable(Result.error(.NotImplemented)).asObservable().asSingle()
    }

    /// get details of a topic
    ///
    /// - Parameter topic: Topic
    /// - Returns: Single<Result<TopicProtocol>>
    func details(topic: TopicProtocol) -> Single<NetworkResult> {
        return Variable(Result.error(.NotImplemented)).asObservable().asSingle()
    }
}

/// DataProviders
extension NetworkProvider {

//    func dynamicDataProvider<T: TargetType>(target: T) -> MoyaProvider<DynamicProvider> {
//        return MoyaProvider<DynamicProvider>()
//    }
    fileprivate func webServiceRequest <Target> (method: Target) -> Single<NetworkResult> where Target: TargetType {
        return DynamicProvider(baseURL: sourceBehaviour.baseUrl())
            .rx
            .request(method)
            .debug()
            .map { (response) -> NetworkResult in
				print(response)
                var json: Any?
                do {
                    let response = try response.filterSuccessfulStatusCodes()
                    if !response.data.isEmpty {
                        json = try response.mapJSON()
                    }
                    print("response json -> \(String(describing: json))")
                } catch let error {
                    print (error)
                    do {
                        let errorJson = try response.filter(statusCodes: 300...399).mapJSON(failsOnEmptyData: true)
                        print("response error json -> \(errorJson)")

                        /// fill webservice error with appropriate values
                        let wsError = HindsightError.WebServiceError(code: response.statusCode,
                                                                     message: response.description,
                                                                     resolve: response.debugDescription)

                        /// can handle recoverable failures here
                        return Result.error(HindsightError.webServiceError(wsError: wsError))
                    } catch {
                        /// fill webservice error with appropriate values
                        let wsError = HindsightError.WebServiceError(code: response.statusCode,
                                                                     message: response.description,
                                                                     resolve: response.debugDescription)

                        return Result.error(HindsightError.webServiceError(wsError: wsError))
                    }
                }
                return NetworkResult.success(json)
        }
    }
}
