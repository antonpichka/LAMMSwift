public final class CurrentModelWIndex<T: BaseModel> {
    public let currentModel: T
    public let index: Int
    
    public init(_ currentModel: T, _ index: Int) {
        self.currentModel = currentModel
        self.index = index
    }
}
