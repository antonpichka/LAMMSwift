public final class ResultWithListModelsWrapper {
    public let listModelWrapper: BaseListModelWrapper?
    public let exceptionController: ExceptionController
    
    private init(_ listModelWrapper: BaseListModelWrapper?,_ exceptionController: ExceptionController) {
        self.listModelWrapper = listModelWrapper
        self.exceptionController = exceptionController
    }
    
    public static func success(_ listModelWrapper: BaseListModelWrapper) -> ResultWithListModelsWrapper {
        return ResultWithListModelsWrapper(listModelWrapper, ExceptionController.success())
    }
    
    public static func exception(_ exception: BaseException) -> ResultWithListModelsWrapper {
        return ResultWithListModelsWrapper(nil, ExceptionController.exception(exception))
    }
}
