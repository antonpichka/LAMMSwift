open class BaseModel {
    public let uniqueId: String
    
    public init(_ uniqueId: String) {
        self.uniqueId = uniqueId
    }
    
    open func clone() -> BaseModel {
        fatalError("Needs extends and must return type 'BaseModel'")
    }
    
    open func toString() -> String {
        fatalError("Needs extends and must return type 'String'")
    }
}
