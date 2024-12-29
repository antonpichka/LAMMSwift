public final actor TempCacheService {
    public static let instance = TempCacheService()
    
    private var tempCache: [String: Any]
    private var tempCacheWStreams: [String: [Int : (_ event: Any) -> Void]]
    
    private init() {
        self.tempCache = [:]
        self.tempCacheWStreams = [:]
    }

    public func getNamed<T>(_ keyTempCache: String,_ defaultValue: T) -> T {
        if !tempCache.contains(where: { $0.key == keyTempCache }) {
            return defaultValue
        }
        return tempCache[keyTempCache] as! T
    }
    
    public func dispose(_ listKeyTempCache: [String],_ iteration: Int) {
        for itemKeyTempCache in listKeyTempCache {
            if !tempCacheWStreams.contains(where: { $0.key == itemKeyTempCache }) {
                continue
            }
            tempCacheWStreams[itemKeyTempCache]?.removeValue(forKey: iteration)
        }
    }
    
    public func listenNamed(_ keyTempCache: String,_ callback: @escaping @Sendable (_ event: Any) -> Void,_ iteration: Int) throws {
        if !tempCacheWStreams.contains(where: { $0.key == keyTempCache }) {
            tempCacheWStreams[keyTempCache] = [:]
            tempCacheWStreams[keyTempCache]?[iteration] = callback
            return
        }
        if !tempCacheWStreams.contains(where: { $0.key == keyTempCache}) {
            throw LocalException(
                "TempCacheService",
                EnumGuilty.developer,
                "{ \(keyTempCache)---\(iteration) }",
                "Under such a key and iteration there already exists a listener: { \(keyTempCache)---\(iteration) }")
        }
        tempCacheWStreams[keyTempCache]?[iteration] = callback
    }
    
    public func update(_ keyTempCache: String,_ value: Any) {
        tempCache[keyTempCache] = value
    }
    
    public func updateWNotify(_ keyTempCache: String,_ value: Any) throws {
        update(keyTempCache, value)
        if !tempCacheWStreams.contains(where: { $0.key == keyTempCache }) {
            return
        }
        for (_, callback) in tempCacheWStreams[keyTempCache]! {
            callback(value)
        }
    }
    
    public func delete(_ keyTempCache: String) {
        tempCache.removeValue(forKey: keyTempCache)
        tempCacheWStreams.removeValue(forKey: keyTempCache)
    }
}
