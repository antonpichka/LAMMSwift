public final class NetworkException : BaseException, @unchecked Sendable {
    public let statusCode: Int
    public let nameStatusCode: String
    public let descriptionStatusCode: String
    
    public init(_ thisClass: String, _ key: String, _ statusCode: Int, _ nameStatusCode: String = "", _ descriptionStatusCode: String = "") {
        self.statusCode = statusCode
        self.nameStatusCode = nameStatusCode
        self.descriptionStatusCode = descriptionStatusCode
        super.init(thisClass, "NetworkException", key)
    }
    
    public static func fromKeyAndStatusCode(_ thisClass: String, _ key: String, _ statusCode: Int) -> NetworkException {
        switch(statusCode) {
            case 201:
                return NetworkException(thisClass, key, 201, "201 Created", "The request has been fulfilled and resulted in a new resource being created.")
            case 202:
                return NetworkException(thisClass, key, 202, "202 Accepted", "The request has been accepted for processing, but the processing has not been completed.")
            case 203:
                return NetworkException(thisClass, key, 203, "203 Non-Authoritative Information", "The returned metaInformation in the entity-header is not the definitive set as available from the origin server, but is gathered from a local or a third-party copy.")
            case 204:
                return NetworkException(thisClass, key, 204, "204 No Content", "The request has been fulfilled and resulted in a new resource being created.")
            case 205:
                return NetworkException(thisClass, key, 205, "205 Reset Content", "The server has fulfilled the request and the user agent SHOULD reset the document view which caused the request to be sent.")
            case 206:
                return NetworkException(thisClass, key, 206, "206 Partial Content", "The server has fulfilled the partial GET request for the resource.")
            case 300:
                return NetworkException(thisClass, key, 300, "300 Multiple Choices", "User (or user agent) can select a preferred representation and redirect its request to that location.")
            case 301:
                return NetworkException(thisClass, key, 301, "301 Moved Permanently", "The requested resource has been assigned a new permanent URI and any future references to this resource SHOULD use one of the returned URIs.")
            case 302:
                return NetworkException(thisClass, key, 302, "302 Found", "The requested resource resides temporarily under a different URI.")
            case 303:
                return NetworkException(thisClass, key, 303, "303 See Other", "The response to the request can be found under a different URI and SHOULD be retrieved using a GET method on that resource.")
            case 304:
                return NetworkException(thisClass, key, 304, "304 Not Modified", "If the client has performed a conditional GET request and access is allowed, but the document has not been modified, the server SHOULD respond with this status code.")
            case 305:
                return NetworkException(thisClass, key, 305, "305 Use Proxy", "The requested resource MUST be accessed through the proxy given by the Location field.")
            case 307:
                return NetworkException(thisClass, key, 307, "307 Temporary Redirect", "The requested resource resides temporarily under a different URI.")
            case 400:
                return NetworkException(thisClass, key, 400, "400 Bad Request", "The request could not be understood by the server due to malformed syntax.")
            case 401:
                return NetworkException(thisClass, key, 401, "401 Unauthorized", "The request requires user authentication.")
            case 402:
                return NetworkException(thisClass, key, 402, "402 Payment Required", "The client must pay the server before requesting access.")
            case 403:
                return NetworkException(thisClass, key, 403, "403 Forbidden", "The server understood the request, but is refusing to fulfill it.")
            case 404:
                return NetworkException(thisClass, key, 404, "404 Not Found", "The server has not found anything matching the Request-URI.")
            case 405:
                return NetworkException(thisClass, key, 405, "405 Method Not Allowed", "The method specified in the Request-Line is not allowed for the resource identified by the Request-URI.")
            //
            case 406:
                return NetworkException(thisClass, key, 406, "406 Not Acceptable", "The resource identified by the request is only capable of generating response entities which have content characteristics not acceptable according to the accept headers sent in the request.")
            case 407:
                return NetworkException(thisClass, key, 407, "407 Proxy Authentication Required", "This code is similar to 401 (Unauthorized), but indicates that the client must first authenticate itself with the proxy.")
            case 408:
                return NetworkException(thisClass, key, 408, "408 Request Timeout", "The client did not produce a request within the time that the server was prepared to wait.")
            case 409:
                return NetworkException(thisClass, key, 409, "409 Conflict", "The request could not be completed due to a conflict with the current state of the resource.")
            case 410:
                return NetworkException(thisClass, key, 410, "410 Gone", "The requested resource is no longer available at the server and no forwarding address is known.")
            case 411:
                return NetworkException(thisClass, key, 411, "411 Length Required", "The server refuses to accept the request without a defined Content-Length.")
            case 412:
                return NetworkException(thisClass, key, 412, "412 Precondition Failed", "The precondition given in one or more of the request-header fields evaluated to false when it was tested on the server.")
            case 413:
                return NetworkException(thisClass, key, 413, "413 Request Entity Too Large", "The server is refusing to process a request because the request entity is larger than the server is willing or able to process.")
            case 414:
                return NetworkException(thisClass, key, 414, "414 Request URI Too Long", "The server is refusing to service the request because the Request-URI is longer than the server is willing to interpret.")
            case 415:
                return NetworkException(thisClass, key, 415, "415 Unsupported Media Type", "The server is refusing to service the request because the entity of the request is in a format not supported by the requested resource for the requested method.")
            case 416:
                return NetworkException(thisClass, key, 416, "416 Requested Range Not Satisfiable", "A server SHOULD return a response with this status code if a request included a Range request-header field (section 14.35), and none of the range-specifier values in this field overlap the current extent of the selected resource, and the request did not include an If-Range request-header field.")
            case 417:
                return NetworkException(thisClass, key, 417, "417 Expectation Failed", "The expectation given in an Expect request-header field (see section 14.20) could not be met by this server.")
            case 500:
                return NetworkException(thisClass, key, 500, "500 Internal Server Error", "The server encountered an unexpected condition which prevented it from fulfilling the request.")
            case 501:
                return NetworkException(thisClass, key, 501, "501 Not Implemented", "The server does not support the functionality interface_function_view_model to fulfill the request.")
            case 502:
                return NetworkException(thisClass, key, 502, "502 Bad Gateway", "The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.")
            case 503:
                return NetworkException(thisClass, key, 503, "503 Service Unavailable", "The server is currently unable to handle the request due to a temporary overloading or maintenance of the server.")
            case 504:
                return NetworkException(thisClass, key, 504, "504 Gateway Timeout", "The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server specified by the URI.")
            case 505:
                return NetworkException(thisClass, key, 505, "505 HTTP Version Not Supported", "The server does not support, or refuses to support, the HTTP protocol version that was used in the request message.")
            default:
                return NetworkException(thisClass, key, 0)
        }
    }
    
    public override func toString() -> String {
        return "NetworkException(key: \(self.key), statusCode: \(self.statusCode), nameStatusCode: \(self.nameStatusCode), descriptionStatusCode: \(self.descriptionStatusCode)"
    }
}
