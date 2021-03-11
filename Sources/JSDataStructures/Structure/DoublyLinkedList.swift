
import Foundation

public struct DoublyLinkedList<T: Equatable> {
    
    // MARK: - Init
    public init() {
        head = nil
        tail = nil
        count = 0
    }

    // MARK: - Nodes
    private var head: Node<T>?
    private var tail: Node<T>?

    // MARK: - Properties
    public var count: Int
    public var peek: T? { return head?.value }
    public var isEmpty: Bool { return head == nil }
    public var hasSoloItem: Bool { return head === tail && !isEmpty }

    // MARK: - Push
    public mutating func push(_ value: T) {

        // Create node
        let node = Node(value)
        
        // Count incrementation
        defer { count += 1 }

        // Empty case
        if isEmpty {
            head = node
            tail = node
        
        // Default case
        } else {
            // connect to other nodes
            head?.prev = node
            node.next = head

            // activate/deactivate refs
            head = node
        }
    }

    // MARK: - Append
    public mutating func append(_ value: T) {

        // Create node
        let node = Node(value)

        // Count incrementation
        defer { count += 1 }

        // Empty case
        if isEmpty {
            tail = node
            head = node

        // Default case
        } else {
            tail?.next = node
            node.prev = tail
            tail = node
        }
    }
    
    // MARK: - Insert at
    @discardableResult
    public mutating func insert(_ value: T, at index: Int) -> Bool {
        // Create node
        let node = Node(value)

        // Defer count incrementation
        defer { count += 1 }

        // Out of bounds case (including negative indexes)
        guard (index >= 0) && (index < count) else { return false }

        // Empty case
        if isEmpty {
            head = node
            tail = node
            return true
        }

        // Find current node at index
        var n: Int = 0
        var prev = head
        var current = head

        while n < index {
            prev = current
            current = current?.next
            n += 1
        }

        // Insert new node between 'prev' and 'current'
        prev?.next = node
        node.prev = prev

        current?.prev = node
        node.next = current

        return true
    }

    // MARK: - Pop
    @discardableResult
    public mutating func pop() -> T? {

        // Defer count decrease
        defer { count -= 1 }

        // Solo case
        if hasSoloItem {
            defer {
                head = nil
                tail = nil
            }
            return head?.value
        
        // Default case
        } else {
            defer {
                head?.next?.prev = nil
                head = head?.next
            }
            return head?.value
        }
    }
    
    // MARK: - Pop Last
    @discardableResult
    public mutating func popLast() -> T? {
        // Defer count decrease
        defer { count -= 1 }
        
        // Empty case
        if isEmpty {
            return nil
        }

        // Solo case
        if hasSoloItem {
            defer {
                tail = nil
                head = nil
            }
            return tail?.value

        // Default case
        } else {
            defer {
                tail?.prev?.next = nil
                tail = tail?.prev
            }
            return tail?.value
        }
    }

    // MARK: - Remove at
    public mutating func remove(at index: Int) -> T? {
        
        // Guard out of bounds (including negative indexes)
        guard (index >= 0) && (index < count) else { return nil }

        // Defer count decrease
        defer { count -= 1 }

        // Find node
        var n = 0
        var current = head
        
        while n < index {
            current = current?.next
            n += 1
        }

        // Remove node
        current?.prev?.next = current?.next
        current?.next?.prev = current?.prev

        // Return value
        return current?.value
    }

    // MARK: Node
    public func node(at index: Int) -> Node<T>? {
        // Guard out of bounds (including negative indexes)
        guard (index >= 0) && (index < count) else { return nil }
        
        var n = 0
        var current = head

        // Find node
        while n < index {
            current = current?.next
            n += 1
        }

        return current
    }

    // MARK: - Contains
    public func contains(_ value: T) -> Int? {
        
        var n = 0
        var current = head
        
        while n < count, let currentValue = current?.value {
            if currentValue == value { return n }
            current = current?.next
            n += 1
        }

        return nil
    }
}

// MARK: - EXT. Custom String Convertible
extension DoublyLinkedList: CustomStringConvertible {

    public var description: String {
        guard let head = head else { return "EMPTY DOUBLY LINKED LIST" }
        return "DOUBLY LINKED LIST: \(count) || " + String(describing: head)
    }
}

// MARK: - Ext. Collection Protocols Helpers
extension DoublyLinkedList {
    
    public struct Index: Comparable {
        
        public var node: Node<T>?
        
        static public func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):       return left.next === right.next
            case (nil, nil):                return true
            default:                        return false
            }
        }
        
        static public func < (lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
}

// MARK: EXT. Collection Conformance Properties
extension DoublyLinkedList: RandomAccessCollection {

    public var startIndex: Index { return Index(node: head) }
    public var endIndex: Index { return Index(node: tail) }

    public func index(before i: Index) -> Index {
        return Index(node: i.node?.prev)
    }

    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }

    public subscript(position: Index) -> T {
        precondition(indices.contains(position), "\(String(describing: self)): index \(position) is out-of-bounds")
        return position.node!.value
    }
}
