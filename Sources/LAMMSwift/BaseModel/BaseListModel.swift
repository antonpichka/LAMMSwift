open class BaseListModel<T : BaseModel> {
    public final var listModel: [T]
    
    public init(_ listModel: [T]) {
        self.listModel = listModel
    }
    
    open func clone() -> BaseListModel<T> {
        fatalError("Needs extends and must return type 'BaseListModel'")
    }
    
    open func toString() -> String {
        fatalError("Needs extends and must return type 'String'")
    }
    
    public final func sortingFromModelTTNamedTTNamedTTNamedTTIteratorParameterListModel(_ modelTTNamedTTNamedTTNamedTTIterator: BaseModelTTNamedTTNamedTTNamedTTIterator<T>) {
        let sortedListModelFromListModelParameterListModelIterator = modelTTNamedTTNamedTTNamedTTIterator.getSortedListModelFromListModelParameterListModelIterator(listModel)
        self.listModel.count > 0 ? listModel.removeAll() : nil
        sortedListModelFromListModelParameterListModelIterator.count > 0 ? self.listModel.append(contentsOf: sortedListModelFromListModelParameterListModelIterator) : nil
    }
    
    public final func insertFromNewModelParameterListModel(_ newModel: T) {
        self.listModel.append(newModel)
    }
    
    public final func updateFromNewModelParameterListModel(_ newModel: T) {
        let firstIndex = self.listModel.firstIndex(where: { $0.uniqueId == newModel.uniqueId })
        if(firstIndex == nil) {
            return
        }
        self.listModel[firstIndex!] = newModel
    }
    
    public final func deleteFromUniqueIdByModelParameterListModel(_ uniqueIdByModel: String) {
        let firstIndex = self.listModel.firstIndex(where: { $0.uniqueId == uniqueIdByModel })
        if(firstIndex == nil) {
            return
        }
        self.listModel.remove(at: firstIndex!)
    }
    
    public final func insertListFromNewListModelParameterListModel(_ newListModel: [T]) {
        self.listModel.append(contentsOf: newListModel)
    }
    
    public final func updateListFromNewListModelParameterListModel(_ newListModel: [T]) {
        for newItemModel: T in newListModel {
            let firstIndex = self.listModel.firstIndex(where: { $0.uniqueId == newItemModel.uniqueId })
            if(firstIndex == nil) {
                return
            }
            self.listModel[firstIndex!] = newItemModel
        }
    }
    
    public final func deleteListFromListUniqueIdByModelParameterListModel(_ listUniqueIdByModel: [String]) {
        for itemUniqueIdByModel: String in listUniqueIdByModel {
            let firstIndex = self.listModel.firstIndex(where: { $0.uniqueId == itemUniqueIdByModel })
            if(firstIndex == nil) {
                return
            }
            self.listModel.remove(at: firstIndex!)
        }
    }
}
