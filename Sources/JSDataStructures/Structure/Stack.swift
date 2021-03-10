
import Foundation

struct Stack<T> {

    // MARK: - Init
    public init() {
        self.elements = []
    }

    // MARK: - Properties
    private var elements: [T]
    public var peek: T? { return elements.last }
    public var isEmpty: Bool { return elements.isEmpty }
    public var count: Int { return elements.count }
    
    // MARK: - Methods
    // Push
    public mutating func push(_ value: T) {
        elements.append(value)
    }

    // Pop
    @discardableResult
    public mutating func pop() -> T? {
        return elements.popLast()
    }
}

// MARK: - EXT. Custom String Convertible
extension Stack: CustomStringConvertible {

    var description: String {
        guard !isEmpty else { return "EMPTY STACK" }
        let label = "STACK: \(count)\n"
        let divider = "--\n"
        let elementsPrintout = elements.map { "\($0)\n" }
        return label + divider + elementsPrintout.joined() + divider
    }
}
