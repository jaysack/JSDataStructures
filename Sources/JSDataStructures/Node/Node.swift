
import Foundation

public class Node<T> {
    
    // MARK: - Init
    public init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Properties
    public var value: T
    public var prev: Node<T>?
    public var next: Node<T>?
}

// MARK: - EXT. Custom String Convertible
extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }
}
