open class BaseModelWrapper {
    public final var listObject: [Any]
    
    public init(_ listObject: [Any]) {
        self.listObject = listObject
    }
    
    open func createModel<T: BaseModel>() -> T {
        fatalError("Needs extends and must return type 'BaseModel'")
    }
}
