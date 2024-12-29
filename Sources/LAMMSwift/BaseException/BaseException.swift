open class BaseException: Error, @unchecked Sendable {
    public let key: String
    
    public init(_ thisClass: String,_ exceptionClass: String,_ key: String) {
        self.key = key
        debugPrintException("\n===start_to_trace_exception===\n")
        debugPrintException(
            "WhereHappenedException(Class) --> \(thisClass)\n" +
            "NameException(Class) --> \(exceptionClass)\n" +
            "toString() --> \(toString())")
        debugPrintException("\n===end_to_trace_exception===\n")
    }
    
    open func toString() -> String {
        fatalError("Needs extends and must return type 'String'")
    }
}
