open class BaseListModelWrapper {
    public final var listsListObject: [[Any]]
    
    public init(_ listsListObject: [[Any]]) {
        self.listsListObject = listsListObject
    }
    
    open func createListModel<T: BaseModel, Y: BaseListModel<T>>() -> Y {
        fatalError("Needs extends and must return type 'BaseListModel<BaseModel>'")
    }
}
