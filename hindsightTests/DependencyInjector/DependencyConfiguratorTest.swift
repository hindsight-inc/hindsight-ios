import Nimble
import Quick
import Swinject

@testable import hindsight

class DependencyConfiguratorTest: QuickSpec {

    override func spec() {

		describe("DependencyConfigurator") {
    		let container = Container()

			context("when registering core dependencies") {
				DependencyConfigurator.registerCoreDependencies(container: container)

				it("should resolve network provider") {
					let provider = container.resolveUnwrapped(NetworkProviderProtocol.self)
					expect(provider).toNot(beNil())
				}
			}

			context("when registering connect flow dependencies") {
                DependencyConfigurator.registerConnectFlowDependencies(container: container)

				it("should resolve connect API client") {
					let client = container.resolveUnwrapped(ConnectApiClientProtocol.self)
					expect(client).toNot(beNil())
				}

				it("should resolve error presenter") {
					let presenter = container.resolveUnwrapped(ErrorPresentingProtocol.self, argument: UIViewController())
					expect(presenter).toNot(beNil())
				}

    			it("should resolve SSO connector") {
					let client = container.resolveUnwrapped(ConnectApiClientProtocol.self)
					let connector = container.resolveUnwrapped(SSOConnectorProtocol.self, arguments: client, UIViewController())
    				expect(connector).toNot(beNil())
    			}
			}
		}
    }
}
