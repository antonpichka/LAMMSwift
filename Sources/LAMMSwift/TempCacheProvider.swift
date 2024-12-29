public final class TempCacheProvider {
    private let tempCacheService: TempCacheService = TempCacheService.instance
    private let iteration: Int
    
    public init() async {
        iteration = await IterationService.instance.newValueParameterIteration()
    }
    
    public func getNamed<T: Sendable>(_ keyTempCache: String,_ defaultValue: T) async -> T {
        return await tempCacheService.getNamed(keyTempCache, defaultValue)
    }
    
    public func dispose(_ listKeyTempCache: [String]) async {
        await tempCacheService.dispose(listKeyTempCache,iteration)
    }
    
    public func listenNamed(_ keyTempCache: String, _ callback: @escaping @Sendable (_ event: Any) -> Void) async throws {
        try await tempCacheService.listenNamed(keyTempCache,callback,iteration)
    }
    
    public func update<T : Sendable>(_ keyTempCache: String, _ value: T) async {
        await tempCacheService.update(keyTempCache, value)
    }
    
    public func updateWNotify<T : Sendable>(_ keyTempCache: String,_ value: T) async throws {
        try await tempCacheService.updateWNotify(keyTempCache, value)
    }
    
    public func delete(_ keyTempCache: String) async {
        await tempCacheService.delete(keyTempCache)
    }
}
