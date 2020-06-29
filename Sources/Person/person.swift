protocol Nameble {
    var name: String { get }
}

public enum PersonError: Error {
    case noName
    
    public var description: String {
        switch self {
        case .noName:
            return "No name specified"
        }
    }
}

open class Person: Nameble {
    public let name: String
    
    public init(_ name: String? = nil) throws {
        guard name != nil && name != "" else {
            throw PersonError.noName
        }
        self.name = name!
    }
}

extension Person {
    public func getName() -> String {   name    }
}
