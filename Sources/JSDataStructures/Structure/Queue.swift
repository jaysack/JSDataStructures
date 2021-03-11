
import Foundation

public struct Queue<T> {
    
    // MARK: - Init
    public init() {
        self.elements = []
    }

    // MARK: - Properties
    private var elements: [T]
    public var count: Int { return elements.count }
    public var peek: T? { return elements.first }
    public var isEmpty: Bool { return elements.isEmpty }

    // MARK: - Enqueue
    @discardableResult
    public mutating func enqueue(_ value: T) -> Bool {
        elements.append(value)
        return true
    }
    
    // MARK: - Dequeue
    @discardableResult
    public mutating func dequeue() -> T? {
        // Empty case
        guard !isEmpty else { return nil }

        // Default case
        guard let head = elements.first else { return nil }
        elements = Array(elements.dropFirst())

        // Return head
        return head
    }
}

// MARK: - EXT. Custom String Convertible
extension Queue: CustomStringConvertible {

    public var description: String {
        guard !isEmpty else { return "EMPTY QUEUE" }
        return "QUEUE: \(count) || \(elements)"
    }
}
