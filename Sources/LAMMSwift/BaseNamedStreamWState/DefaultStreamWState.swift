public final class DefaultStreamWState<T: RawRepresentable, Y: BaseDataForNamed<T>> : BaseNamedStreamWState<T,Y> where T.RawValue == String {
    private let dataForNamed: Y
    private var isDispose: Bool = false
    private var callback: ((_ event: Y) -> Void)? = nil
    
    public init(_ dataForNamed: Y) {
        self.dataForNamed = dataForNamed
        super.init()
    }
    
    public override func getDataForNamed() -> Y {
        return dataForNamed
    }
    
    public override func dispose() {
        if(self.isDispose) {
            return
        }
        self.isDispose = true
        self.callback = nil
    }
    
    public override func listenStreamDataForNamedFromCallback(_ callback: @escaping (Y) -> Void) throws {
        if(self.isDispose) {
            throw LocalException(
                "DefaultStreamWState",
                EnumGuilty.developer,
                "DefaultStreamWStateQQListenStreamDataWNamedWCallback",
                "Already disposed of")
        }
        if(self.callback != nil) {
            throw LocalException(
                "DefaultStreamWState",
                EnumGuilty.developer,
                "DefaultStreamWStateQQListenStreamDataWNamedWCallback",
                "Duplicate")
        }
        self.callback = callback
    }
    
    public override func notifyStreamDataForNamed() throws {
        if(self.isDispose) {
            throw LocalException(
                "DefaultStreamWState",
                EnumGuilty.developer,
                "DefaultStreamWStateQQNotifyStreamDataWNamed",
                "Already disposed of")
        }
        if(self.callback == nil) {
            throw LocalException(
                "DefaultStreamWState",
                EnumGuilty.developer,
                "DefaultStreamWStateQQNotifyStreamDataWNamed",
                "Stream has no listener")
        }
        self.callback!(self.dataForNamed)
    }
}
