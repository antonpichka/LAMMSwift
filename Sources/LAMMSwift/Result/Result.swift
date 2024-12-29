public final class Result {
    public let parameter: Any?
    public let exceptionController: ExceptionController
    
    private init(_ parameter: Any?,_ exceptionController: ExceptionController) {
        self.parameter = parameter
        self.exceptionController = exceptionController
    }
    
    public static func success(_ parameter: Any?) -> Result {
        return Result(parameter, ExceptionController.success())
    }
    
    public static func exception(_ exception: BaseException) -> Result {
        return Result(nil, ExceptionController.exception(exception))
    }
}
