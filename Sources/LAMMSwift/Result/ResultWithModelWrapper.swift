public final class ResultWithModelWrapper {
    public let modelWrapper: BaseModelWrapper?
    public let exceptionController: ExceptionController
    
    private init(_ modelWrapper: BaseModelWrapper?,_ exceptionController: ExceptionController) {
        self.modelWrapper = modelWrapper
        self.exceptionController = exceptionController
    }
    
    public static func success(_ modelWrapper: BaseModelWrapper?) -> ResultWithModelWrapper {
        return ResultWithModelWrapper(modelWrapper, ExceptionController.success())
    }
    
    public static func exception(_ exception: BaseException) -> ResultWithModelWrapper {
        return ResultWithModelWrapper(nil, ExceptionController.exception(exception))
    }
}
