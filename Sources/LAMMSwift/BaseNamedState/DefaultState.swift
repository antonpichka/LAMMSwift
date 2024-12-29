public final class DefaultState<T: RawRepresentable, Y: BaseDataForNamed<T>> : BaseNamedState<T,Y> where T.RawValue == String  {
    private let dataForNamed: Y
    
    public init(_ dataForNamed: Y) {
        self.dataForNamed = dataForNamed
        super.init()
    }
    
    public override func getDataForNamed() -> Y {
        return self.dataForNamed
    }
    
    public override func dispose() {
    }
}
