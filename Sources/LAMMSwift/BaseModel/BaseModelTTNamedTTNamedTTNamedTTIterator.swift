open class BaseModelTTNamedTTNamedTTNamedTTIterator<T: BaseModel> {
    public final var listModelIterator: [T]
    
    public init() {
        self.listModelIterator = []
    }
    
    open func currentModelWIndex() -> CurrentModelWIndex<T> {
        fatalError("Needs extends and must return type 'CurrentModelWIndex<T>'")
    }
    
    public final func getSortedListModelFromListModelParameterListModelIterator(_ listModel: [T]) -> [T] {
        if(listModel.isEmpty) {
            return []
        }
        self.listModelIterator.append(contentsOf: listModel)
        var newListModel: [T] = []
        while(self.listModelIterator.count > 0) {
            let currentModelWIndex = currentModelWIndex()
            self.listModelIterator.remove(at: currentModelWIndex.index)
            newListModel.append(currentModelWIndex.currentModel)
        }
        return newListModel
    }
}
