//
//  DynamicProviderTest.swift
//  hindsightTests
//
//  Created by Sanwal, Manish on 10/23/18.
//  Copyright © 2018 hindsight-inc. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxSwift
import RxBlocking
import Moya

@testable import hindsight

class DynamicProviderTest: QuickSpec {
    override func spec() {
//        describe("Dynamic Provider") {
//            context("On request call") {
//                let target = AuthEndpoint.refresh
//                let url = URL(string: "https://www.google.com")!
//                let result = try? DynamicProvider(baseURL: url)
//                    .rx
//                    .request(target)
//                    .toBlocking()
//                    .first()!
//                xit("should call MoyaProvider request") {
//                    expect(result).to(beNil())
//                }
//            }
//        }

        describe("AuthEndpoint") {
            context("should ping") {
//                let provider = MoyaProvider<AuthEndpoint>()
//                let result = try? provider.rx.request(AuthEndpoint.ping).toBlocking().first()!
                let target = AuthEndpoint.ping
                let url = URL(string: "http://localhost:18182")!
                let result = try? DynamicProvider(baseURL: url)
                    .rx
                    .request(target)
                    .toBlocking()
                    .first()!
                fit("should call MoyaProvider request") {
                    expect(result).toNot(beNil())
                }
            }
        }
    }
}
