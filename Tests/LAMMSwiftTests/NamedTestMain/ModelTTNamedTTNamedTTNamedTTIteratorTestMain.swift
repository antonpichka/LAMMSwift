import XCTest
@testable import LAMMSwift

open class UserBalance : BaseModel {
    public let username: String
    public let money: Int
    
    public init(_ username: String,_ money: Int) {
        self.username = username
        self.money = money
        super.init(username)
    }
    
    open override func clone() -> UserBalance {
        return UserBalance(username, money)
    }
    
    open override func toString() -> String {
        return "UserBalance(username: \(username), money: \(money))"
    }
}

open class ListUserBalance<T : UserBalance> : BaseListModel<T> {
    public override init(_ listModel: [T]) {
        super.init(listModel)
    }
    
    open override func clone() -> ListUserBalance<T> {
        var newListModel: [T] = []
        for itemModel: T in self.listModel {
            newListModel.append(itemModel.clone() as! T)
        }
        return ListUserBalance(newListModel)
    }
    
    open override func toString() -> String {
        var strListModel = "\n"
        for itemModel: T in self.listModel {
            strListModel += "\(itemModel.toString()),\n"
        }
        return "ListUserBalance(listModel: [\(strListModel)])"
    }
}

public final class UserBalanceTTOrderByDescTTMoneyTTIterator : BaseModelTTNamedTTNamedTTNamedTTIterator<UserBalance> {
    public override func currentModelWIndex() -> CurrentModelWIndex<UserBalance> {
        var clone = listModelIterator[0].clone()
        if(listModelIterator.count <= 1) {
            return CurrentModelWIndex(clone,0)
        }
        var indexRemove = 0
        for i in 1..<listModelIterator.count {
            let itemModelIterator = listModelIterator[i]
            if itemModelIterator.money > clone.money {
                clone = itemModelIterator.clone()
                indexRemove = i
                continue
            }
        }
        return CurrentModelWIndex<UserBalance>(clone,indexRemove)
    }
}

final class ModelTTNamedTTNamedTTNamedTTIteratorTestMain: XCTestCase {
    public func testModelTTNamedTTNamedTTNamedTTIteratorTestMain() {
        let listUserBalance = ListUserBalance([])
        listUserBalance.insertListFromNewListModelParameterListModel(
            [
                UserBalance("Jone", 3),
                UserBalance("Freddy", 1),
                UserBalance("Mitsuya", 10),
                UserBalance("Duramichi", 5),
                UserBalance("Hook", 7),
                UserBalance("Sexy", -1)
            ])
        XCTAssertEqual("ListUserBalance(listModel: [\n" +
                       "UserBalance(username: Jone, money: 3),\n" +
                       "UserBalance(username: Freddy, money: 1),\n" +
                       "UserBalance(username: Mitsuya, money: 10),\n" +
                       "UserBalance(username: Duramichi, money: 5),\n" +
                       "UserBalance(username: Hook, money: 7),\n" +
                       "UserBalance(username: Sexy, money: -1),\n" +
                       "])", listUserBalance.toString())
        let userBalanceTTOrderByDescTTMoneyTTIterator = UserBalanceTTOrderByDescTTMoneyTTIterator()
        listUserBalance.sortingFromModelTTNamedTTNamedTTNamedTTIteratorParameterListModel(userBalanceTTOrderByDescTTMoneyTTIterator)
        XCTAssertEqual("ListUserBalance(listModel: [\n" +
                       "UserBalance(username: Mitsuya, money: 10),\n" +
                       "UserBalance(username: Hook, money: 7),\n" +
                       "UserBalance(username: Duramichi, money: 5),\n" +
                       "UserBalance(username: Jone, money: 3),\n" +
                       "UserBalance(username: Freddy, money: 1),\n" +
                       "UserBalance(username: Sexy, money: -1),\n" +
                       "])", listUserBalance.toString())
        listUserBalance.updateFromNewModelParameterListModel(UserBalance("Duramichi", 15))
        listUserBalance.sortingFromModelTTNamedTTNamedTTNamedTTIteratorParameterListModel(userBalanceTTOrderByDescTTMoneyTTIterator)
        XCTAssertEqual("ListUserBalance(listModel: [\n" +
                       "UserBalance(username: Duramichi, money: 15),\n" +
                       "UserBalance(username: Mitsuya, money: 10),\n" +
                       "UserBalance(username: Hook, money: 7),\n" +
                       "UserBalance(username: Jone, money: 3),\n" +
                       "UserBalance(username: Freddy, money: 1),\n" +
                       "UserBalance(username: Sexy, money: -1),\n" +
                       "])", listUserBalance.toString())
        listUserBalance.deleteFromUniqueIdByModelParameterListModel("Mitsuya")
        listUserBalance.sortingFromModelTTNamedTTNamedTTNamedTTIteratorParameterListModel(userBalanceTTOrderByDescTTMoneyTTIterator)
        XCTAssertEqual("ListUserBalance(listModel: [\n" +
                       "UserBalance(username: Duramichi, money: 15),\n" +
                       "UserBalance(username: Hook, money: 7),\n" +
                       "UserBalance(username: Jone, money: 3),\n" +
                       "UserBalance(username: Freddy, money: 1),\n" +
                       "UserBalance(username: Sexy, money: -1),\n" +
                       "])", listUserBalance.toString())
    }
}
