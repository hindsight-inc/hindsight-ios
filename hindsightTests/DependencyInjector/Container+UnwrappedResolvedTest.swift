import Nimble
import Quick
import Swinject

@testable import hindsight

class ResolverUnwrappingTest: QuickSpec {

	private let test = "test"
	private let arg1 = "arg1"
	private let arg2 = "arg2"

    override func spec() {

		describe("Resolver+Unwrapping extension") {
    		let container = Container()

			context("when resolving with no arguments") {
    			it("should not be nil") {
    				container.register(NSObjectProtocol.self) { _ in
    					NSObject()
    				}
    				let obj = container.resolveUnwrapped(NSObjectProtocol.self)
    				expect(obj).toNot(beNil())
    			}

				it("should resolve a specific instance") {
					container.register(String.self) { _ in
						self.test
					}
					let str = container.resolveUnwrapped(String.self)
					expect(str).to(equal(self.test))
				}
			}

			context("when resolving with 1 argument") {

				it("should resolve a specific instance") {
					container.register(String.self) { _, a1 in
						self.test + a1
					}
					let str = container.resolveUnwrapped(String.self, argument: self.arg1)
					expect(str).to(equal(self.test + self.arg1))
				}
			}

			context("when resolving with 2 arguments") {

				it("should resolve a specific instance") {
					container.register(String.self) { _, a1, a2 in
						self.test + a1 + a2
					}
					let str = container.resolveUnwrapped(String.self, arguments: self.arg1, self.arg2)
					expect(str).to(equal(self.test + self.arg1 + self.arg2))
				}
			}
		}
    }
}
