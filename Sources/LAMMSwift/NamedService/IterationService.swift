public final actor IterationService {
    public static let instance = IterationService()
    
    private var iteration: Int
    
    private init() {
        self.iteration = -1
    }
    
    public func newValueParameterIteration() -> Int {
        iteration += 1
        return iteration
    }
}
