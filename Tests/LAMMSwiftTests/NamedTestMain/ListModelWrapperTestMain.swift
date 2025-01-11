import XCTest
@testable import LAMMSwift

open class IPAddress : BaseModel {
    public let ip: String
    
    public override init(_ ip: String) {
        self.ip = ip
        super.init(ip)
    }
    
    open override func clone() -> IPAddress {
        return IPAddress(self.ip)
    }
    
    open override func toString() -> String {
        return "IPAddress(ip: \(self.ip))"
    }
}

open class ListIPAddress<T : IPAddress> : BaseListModel<T> {
    public override init(_ listModel: [T]) {
        super.init(listModel)
    }
    
    open override func clone() -> ListIPAddress<T> {
        var newListModel: [T] = []
        for itemModel: T in self.listModel {
            newListModel.append(itemModel.clone() as! T)
        }
        return ListIPAddress(newListModel)
    }
    
    open override func toString() -> String {
        var strListModel = "\n"
        for itemModel: T in self.listModel {
            strListModel += "\(itemModel.toString()),\n"
        }
        return "ListIPAddress(listModel: [\(strListModel)])"
    }
}

open class IPAddressWrapper : BaseModelWrapper {
    public override init(_ listObject: [Any]) {
        super.init(listObject)
    }
    
    open override func createModel<T: BaseModel>() -> T {
        return IPAddress(self.listObject[0] as? String ?? "") as! T
    }
}

open class ListIPAddressWrapper : BaseListModelWrapper {
    public override init(_ listsListObject: [[Any]]) {
        super.init(listsListObject)
    }
    
    open override func createListModel<T: BaseModel, Y: BaseListModel<T>>() -> Y {
        var listModel: [IPAddress] = []
        for itemListObject: [Any] in self.listsListObject {
            let iPAddressWrapper = IPAddressWrapper(itemListObject)
            listModel.append(iPAddressWrapper.createModel())
        }
        return ListIPAddress(listModel) as! Y
    }
}

final class ListModelWrapperTestMain: XCTestCase {
    public func testListModelWrapperTestMain() {
        let listIPAddressWrapper = ListIPAddressWrapper(
            [
                ["1.1.1.1"],
                ["2.2.2.2"],
                ["3.3.3.3"],
                ["4.4.4.4"],
                ["5.5.5.5"],
                ["6.6.6.6"],
                ["7.7.7.7"]
            ]
        )
        let listIPAddress: ListIPAddress<IPAddress> = listIPAddressWrapper.createListModel()
        XCTAssertEqual(listIPAddress.listModel.count, 7)
    }
}
