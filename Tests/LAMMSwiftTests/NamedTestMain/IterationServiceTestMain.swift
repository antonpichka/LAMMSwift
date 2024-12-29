import XCTest
@testable import LAMMSwift

final class IterationServiceTestMain: XCTestCase {
    public func testIterationServiceTestMain() async {
        _ = await TempCacheProvider()
        _ = await TempCacheProvider()
        _ = await TempCacheProvider()
        _ = await TempCacheProvider()
        _ = await TempCacheProvider()
        let newValueParameterIteration = await IterationService.instance.newValueParameterIteration()
        XCTAssertEqual(newValueParameterIteration, 5)
    }
}
