import XCTest
@testable import LAMMSwift

final class TempCacheProviderTestMain: XCTestCase {
    public func testTempCacheProviderTestMain() async throws {
        let tempCacheProvider = await TempCacheProvider()
        let key = "key"
        let keyFirst = await tempCacheProvider.getNamed(key,"default")
        try await tempCacheProvider.listenNamed(key, { event in
            let event = event as? String ?? ""
            XCTAssertEqual(event, "Two")
        })
        try? await Task.sleep(nanoseconds: UInt64(1) * 1_000_000_000)
        try await tempCacheProvider.updateWNotify(key,"Two")
        await tempCacheProvider.dispose([key])
        try await tempCacheProvider.listenNamed(key, { event in
            let event = event as? String ?? ""
            XCTAssertEqual(event, "Three")
        })
        XCTAssertEqual(keyFirst, "default")
    }
}
