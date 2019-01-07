import Nimble
import Quick
import Swinject
import Moya

@testable import hindsight

class ConnectEndpointTest: QuickSpec {

	private let token = "token"

	override func spec() {

		describe("ConnectEndpoint") {

			context("when using ConnectEndpoint.connect") {
				let endpoint = ConnectEndpoint.connect(accessToken: self.token)

				it("should not be nil") {
					expect(endpoint).toNot(beNil())
				}

				it("should have baseURL") {
					expect(endpoint.baseURL).toNot(beNil())
				}

				it("should have correct path") {
					expect(endpoint.path).toNot(beNil())
					expect(endpoint.path).to(equal(Constants.NonUI.Network.Auth.Connect.api))
				}

				it("should be post") {
					expect(endpoint.method).toNot(beNil())
					expect(endpoint.method).to(equal(Moya.Method.post))
				}

				it("should have parameters") {
					expect(endpoint.task).toNot(beNil())
				}

				it("should have headers") {
					expect(endpoint.headers).toNot(beNil())
				}
			}
		}
	}
}
