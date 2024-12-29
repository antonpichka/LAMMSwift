public final class LocalException : BaseException, @unchecked Sendable {
    public let enumGuilty: EnumGuilty
    public let message: String
    
    public init(_ thisClass: String, _ enumGuilty: EnumGuilty, _ key: String, _ message: String = "") {
        self.enumGuilty = enumGuilty
        self.message = message
        super.init(thisClass, "LocalException", key)
    }
    
    public override func toString() -> String {
        return "LocalException(enumGuilty: \(self.enumGuilty), key: \(self.key), message (optional): \(self.message))"
    }
}
