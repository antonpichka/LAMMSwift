open class BaseModelWrapperRepository : IDispose {
    public init() {
    }
    
    open func dispose() {
        fatalError("Needs extends and must return type 'Void'")
    }
    
    public final func getSafeValueFromMapAndKeyAndDefaultValue(_ map: [String: Any],_ key: String,_ defaultValue: Any) -> Any {
        return map.contains(where: { $0.key == key }) ? map[key]! : defaultValue
    }
}
