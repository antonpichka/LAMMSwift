open class BaseNamedStreamWState<T: RawRepresentable, Y: BaseDataForNamed<T>> : IDispose where T.RawValue == String  {
    public init() {
    }
    
    open func getDataForNamed() -> Y {
        fatalError("Needs extends and must return type 'Y'")
    }
    
    open func listenStreamDataForNamedFromCallback(_ callback: @escaping (_ event: Y) -> Void) throws {
        fatalError("Needs extends and must return type 'Void'")
    }
    
    open func notifyStreamDataForNamed() throws {
        fatalError("Needs extends and must return type 'Void'")
    }
    
    open func dispose() {
        fatalError("Needs extends and must return type 'Void'")
    }
}
