import LAMMSwift
import Foundation

public final class FactoryModelWrapperRepositoryUtility {
    private init() {
    }
    
    public static func getIPAddressWrapperRepositoryFromNamedUrlSessionService(_ namedUrlSessionService: BaseNamedUrlSessionService) -> IPAddressWrapperRepository {
        return IPAddressWrapperRepository(namedUrlSessionService)
    }
}

public final class KeysUrlEndpointUtility {
    /* JsonipAPI */
    public static let jsonipAPI: String = "https://jsonip.com"
    public static let jsonipAPIQQProviders: String = "\(jsonipAPI)/providers"
    
    private init() {
    }
}

public final class ReadyDataUtility {
    public static let unknown: String = "unknown"
    public static let success: String = "success"
    
    private init() {
    }
}

public final class KeysHttpClientServiceUtility {
    /* IPAddress */
    public static let iPAddressQQIp: String = "ip"
    
    private init() {
    }
}

open class IPAddress : BaseModel {
    public let ip: String
    
    public override init(_ ip: String) {
        self.ip = ip
        super.init(ip)
    }
    
    open override func clone() -> IPAddress {
        return IPAddress(self.ip)
    }
    
    open override func toString() -> String {
        return "IPAddress(ip: \(self.ip))"
    }
}

open class ListIPAddress<T : IPAddress> : BaseListModel<T> {
    public override init(_ listModel: [T]) {
        super.init(listModel)
    }
    
    open override func clone() -> ListIPAddress<T> {
        var newListModel: [T] = []
        for itemModel: T in self.listModel {
            newListModel.append(itemModel.clone() as! T)
        }
        return ListIPAddress(newListModel)
    }
    
    open override func toString() -> String {
        var strListModel = "\n"
        for itemModel: T in self.listModel {
            strListModel += "\(itemModel.toString()),\n"
        }
        return "ListIPAddress(listModel: [\(strListModel)])"
    }
}

open class IPAddressWrapper : BaseModelWrapper {
    public override init(_ listObject: [Any]) {
        super.init(listObject)
    }
    
    open override func createModel<T: BaseModel>() -> T {
        return IPAddress(self.listObject[0] as? String ?? "") as! T
    }
}

open class ListIPAddressWrapper : BaseListModelWrapper {
    public override init(_ listsListObject: [[Any]]) {
        super.init(listsListObject)
    }
    
    open override func createListModel<T: BaseModel, Y: BaseListModel<T>>() -> Y {
        var listModel: [IPAddress] = []
        for itemListObject: [Any] in self.listsListObject {
            for itemObject: Any in itemListObject {
                listModel.append(IPAddress(itemObject as? String ?? ""))
            }
        }
        return ListIPAddress(listModel) as! Y
    }
}

open class BaseNamedUrlSession {
    open func get(url: URL, headers: [String: String]? = nil) async throws -> (Data, URLResponse) {
        fatalError("Needs extends and must return type '(Data, URLResponse)'")
    }
    
    open func post(url: URL, headers: [String: String]? = nil, body: [String: Any]) async throws -> (Data, URLResponse) {
        fatalError("Needs extends and must return type '(Data, URLResponse) '")
    }
    
    open func close() async {
        fatalError("Needs extends and must return type 'Void'")
    }
}

public final class DefaultUrlSession: BaseNamedUrlSession {
    private let urlSession: URLSession
    
    public init(_ urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    public override func get(url: URL, headers: [String: String]? = nil) async throws -> (Data, URLResponse) {
        if headers == nil {
            return try await self.urlSession.data(for: URLRequest(url: url))
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return try await self.urlSession.data(for: request)
    }
    
    public override func post(url: URL, headers: [String: String]? = nil, body: [String: Any]) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        if headers == nil {
            return try await self.urlSession.data(for: request)
        }
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return try await self.urlSession.data(for: request)
    }
    
    public override func close() async {
        urlSession.invalidateAndCancel()
    }
}

public final class TimeoutUrlSession: BaseNamedUrlSession {
    private let urlSession: URLSession
    private let timeoutInterval: TimeInterval
    
    public init(_ urlSession: URLSession,_ timeoutInterval: TimeInterval) {
        self.urlSession = urlSession
        self.timeoutInterval = timeoutInterval
    }
    
    public override func get(url: URL, headers: [String : String]? = nil) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url, timeoutInterval: self.timeoutInterval)
        request.httpMethod = "GET"
        if headers == nil {
            return try await self.urlSession.data(for: request)
        }
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return try await self.urlSession.data(for: request)
    }
    
    public override func post(url: URL, headers: [String : String]? = nil, body: [String : Any]) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url, timeoutInterval: self.timeoutInterval)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        if headers == nil {
            return try await self.urlSession.data(for: request)
        }
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return try await self.urlSession.data(for: request)
    }
    
    public override func close() async {
        urlSession.invalidateAndCancel()
    }
}

open class BaseNamedUrlSessionService {
    public init() {}
    
    open func getParameterNamedUrlSession() -> BaseNamedUrlSession? {
        fatalError("Needs extends and must return type 'BaseNamedUrlSession'")
    }
}

public final class DefaultUrlSessionService: BaseNamedUrlSessionService {
    public static let instance = DefaultUrlSessionService()
    private var namedUrlSession: BaseNamedUrlSession?
    
    private override init() {}
    
    public override func getParameterNamedUrlSession() -> BaseNamedUrlSession? {
        if self.namedUrlSession != nil {
            return self.namedUrlSession
        }
        self.namedUrlSession = DefaultUrlSession(URLSession.shared)
        return self.namedUrlSession
    }
}

public final class TimeoutUrlSessionService: BaseNamedUrlSessionService {
    public static let instance = TimeoutUrlSessionService()
    private var namedUrlSession: BaseNamedUrlSession?
    
    private override init() {}
    
    public override func getParameterNamedUrlSession() -> BaseNamedUrlSession? {
        if self.namedUrlSession != nil {
            return self.namedUrlSession
        }
        self.namedUrlSession = TimeoutUrlSession(URLSession.shared, 5)
        return self.namedUrlSession
    }
}

open class IPAddressWrapperRepository : BaseModelWrapperRepository {
    public let namedUrlSessionService: BaseNamedUrlSessionService
    
    public init(_ namedUrlSessionService: BaseNamedUrlSessionService) {
        self.namedUrlSessionService = namedUrlSessionService
    }
    
    public override func dispose() {
    }
    
    public func getIPAddressParameterNamedUrlSessionService() async throws -> ResultWithModelWrapper {
        do {
            let (body, response) = try await self.namedUrlSessionService.getParameterNamedUrlSession()!.get(url: URL.init(string: KeysUrlEndpointUtility.jsonipAPI)!)
            let responseFirst: HTTPURLResponse? = response as? HTTPURLResponse
            if responseFirst?.statusCode != 200 {
                throw NetworkException.fromKeyAndStatusCode("IPAddressWrapperRepository", String(responseFirst?.statusCode ?? 0), responseFirst?.statusCode ?? 0)
            }
            let data: [String: Any]? = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any]
            let ipByIPAddress = getSafeValueFromMapAndKeyAndDefaultValue(data ?? [:], KeysHttpClientServiceUtility.iPAddressQQIp, "")
            return ResultWithModelWrapper.success(IPAddressWrapper([ipByIPAddress]))
        } catch let e as NetworkException {
            return ResultWithModelWrapper.exception(e)
        } catch {
            return ResultWithModelWrapper.exception(LocalException("IPAddressWrapperRepository", EnumGuilty.device, ReadyDataUtility.unknown, error.localizedDescription))
        }
    }
}

public enum EnumDataForMainVM: String {
    case isLoading
    case exception
    case success
}

public final class DataForMainVM : BaseDataForNamed<EnumDataForMainVM> {
    public var iPAddress: IPAddress
    
    public init(_ isLoading: Bool,_ iPAddress: IPAddress) {
        self.iPAddress = iPAddress
        super.init(isLoading)
    }
    
    public override func getEnumDataForNamed() -> EnumDataForMainVM {
        if isLoading {
            return EnumDataForMainVM.isLoading
        }
        if exceptionController.isWhereNotEqualsNilParameterException() {
            return EnumDataForMainVM.exception
        }
        return EnumDataForMainVM.success
    }
    
    public override func toString() -> String {
        return "DataForMainVM(isLoading: \(isLoading), exceptionController: \(exceptionController.toString()), iPAddress: \(iPAddress.toString()))"
    }
}

public final class MainVM {
    // ModelWrapperRepository
    private let iPAddressWrapperRepository = FactoryModelWrapperRepositoryUtility.getIPAddressWrapperRepositoryFromNamedUrlSessionService(TimeoutUrlSessionService.instance)
    
    // TempCacheProvider
    private let tempCacheProvider: TempCacheProvider
    
    // NamedUtility
    
    // NamedStreamWState
    private let namedStreamWState: BaseNamedStreamWState<EnumDataForMainVM,DataForMainVM>
    
    public init() async {
        self.tempCacheProvider = await TempCacheProvider()
        self.namedStreamWState = DefaultStreamWState(DataForMainVM(true, IPAddress("")))
    }
    
    public func initial() async throws {
        try self.namedStreamWState.listenStreamDataForNamedFromCallback({ event in
            self.build()
        })
        let firstRequest = try await firstRequest()
        debugPrint("MainVM: \(firstRequest)")
        try namedStreamWState.notifyStreamDataForNamed()
    }
    
    public func dispose() async {
        self.iPAddressWrapperRepository.dispose()
        await self.tempCacheProvider.dispose([])
        self.namedStreamWState.dispose()
    }
    
    private func build() {
        let dataWNamed = self.namedStreamWState.getDataForNamed()
        switch dataWNamed.getEnumDataForNamed() {
            case EnumDataForMainVM.isLoading:
                debugPrint("Build: isLoading")
                break
            case EnumDataForMainVM.exception:
                debugPrint("Build: Exception(\(dataWNamed.exceptionController.getKeyParameterException()))")
                break
            case EnumDataForMainVM.success:
                debugPrint("Build: Success(\(dataWNamed.iPAddress.toString()))")
                break
        }
    }
    
    private func firstRequest() async throws -> String {
        let getIPAddressParameterNamedUrlSessionService = try await self.iPAddressWrapperRepository.getIPAddressParameterNamedUrlSessionService()
        if getIPAddressParameterNamedUrlSessionService.exceptionController.isWhereNotEqualsNilParameterException() {
            return await firstQQFirstRequestQQGetIPAddressParameterNamedUrlSessionService(getIPAddressParameterNamedUrlSessionService.exceptionController)
        }
        self.namedStreamWState.getDataForNamed().isLoading = false
        self.namedStreamWState.getDataForNamed().iPAddress = getIPAddressParameterNamedUrlSessionService.modelWrapper!.createModel()
        return ReadyDataUtility.success
    }
    
    private func firstQQFirstRequestQQGetIPAddressParameterNamedUrlSessionService(_ exceptionController: ExceptionController) async -> String {
        self.namedStreamWState.getDataForNamed().isLoading = false
        self.namedStreamWState.getDataForNamed().exceptionController = exceptionController
        return exceptionController.getKeyParameterException()
    }
}

@main
public struct Main {
    public static func main() async {
        let mainVM = await MainVM()
        try! await mainVM.initial()
        await mainVM.dispose()
    }
}
// EXPECTED OUTPUT:
//
// MainVM: success
// Build: Success(IPAddress(ip: ${your_ip}))
//
// Process finished with exit code 0

/// OR

// EXPECTED OUTPUT:
//
// ===start_to_trace_exception===
//
// WhereHappenedException(Class) --> ${WhereHappenedException(Class)}
// NameException(Class) --> ${NameException(Class)}
// toString() --> ${toString()}
//
// ===end_to_trace_exception===
//
// MainVM: ${getKeyParameterException}
// Build: Exception(${getKeyParameterException})
//
// Process finished with exit code 0
