open class BaseDataForNamed<T: RawRepresentable> where T.RawValue == String {
    public final var isLoading: Bool
    public final var exceptionController: ExceptionController
    
    public init(_ isLoading: Bool) {
        self.isLoading = isLoading
        self.exceptionController = ExceptionController.success()
    }
    
    open func getEnumDataForNamed() -> T {
        fatalError("Needs extends and must return type 'Enum'")
    }
    
    open func toString() -> String {
        fatalError("Needs extends and must return type 'String'")
    }
}
