$HEADER$
import Quick
import Nimble

@testable import <#ProjectName#>

class $CLASS$Spec: QuickSpec {
    override func spec() {
        describe("$CLASS$") {

            var sut: $CLASS$!

            beforeEach {
                sut = $CLASS$.fromStoryboard($CLASS$.storyboardName)
                expect(sut.view).notTo(beNil())
            }

            afterEach {
                sut = nil
            }

            // TODO: write tests here..
        }
    }
}
