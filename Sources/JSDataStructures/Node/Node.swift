
import Foundation

final public class Node<T>: LinkNodeProtocol {

    // MARK: - Typealiases
    public typealias Value = T
    public typealias Element = Node<T>
    
    // MARK: - Init
    public init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Properties
    public var value: T
    public var prev: Element?
    public weak var next: Element?
}

// MARK: - EXT. Custom String Convertible
extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }
}
