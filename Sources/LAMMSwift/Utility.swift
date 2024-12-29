public func debugPrint(_ text: String) {
    print(text)
}

public func debugPrintException(_ text: String) {
    debugPrint("\u{001B}[0;31m\(text)\u{001B}[0m")
}
