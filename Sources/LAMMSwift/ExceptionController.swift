public final class ExceptionController {
    private let exception: BaseException?
    
    private init(_ exception: BaseException?) {
        self.exception = exception
    }
    
    public static func success() -> ExceptionController {
        return ExceptionController(nil)
    }
    
    public static func exception(_ exception: BaseException) -> ExceptionController {
        return ExceptionController(exception)
    }
    
    public func toString() -> String {
        if(self.exception == nil) {
            return "ExceptionController(exception: nil)"
        }
        return "ExceptionController(exception: \(exception?.toString() ?? "")"
    }
    
    public func getKeyParameterException() -> String {
        return self.exception?.key ?? ""
    }
    
    public func isWhereNotEqualsNilParameterException() -> Bool {
        return self.exception != nil
    }
}
