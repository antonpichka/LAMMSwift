open class BaseNamedState<T: RawRepresentable, Y: BaseDataForNamed<T>> : IDispose where T.RawValue == String {
    public init() {
    }
    
    open func getDataForNamed() -> Y {
        fatalError("Needs extends and must return type 'Y'")
    }
    
    open func dispose() {
        fatalError("Needs extends and must return type 'Void'")
    }
}
