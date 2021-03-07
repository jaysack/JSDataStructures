
import Foundation

struct DoublyLinkedList<T: Equatable> {
    
    // MARK: - Nodes
    private var head: Node<T>?
    private var tail: Node<T>?

    // MARK: - Properties
    public var count: Int = 0
    public var peek: T? { return head?.value }
    public var isEmpty: Bool { return head == nil }
    public var hasSoloItem: Bool { return head === tail && tail != nil }

    // MARK: - Push
    public mutating func push(_ value: T) {

        // 1. Create node
        let node = Node(value)
        
        // 2. Count incrementation
        defer { count += 1 }

        // 3. Empty case
        if isEmpty {
            head = node
            tail = node
        
        // 4. Default case
        } else {
            // 4.a. connect to other nodes
            head?.prev = node
            node.next = head

            // 4.b. activate/deactivate refs
            head = node
        }
    }

    // MARK: - Append
    public mutating func append(_ value: T) {

        // 1. Create node
        let node = Node(value)

        // 2. Count incrementation
        defer { count += 1 }

        // 3. Empty case
        if isEmpty {
            tail = node
            head = node

        // 4. Default case
        } else {
            tail?.next = node
            node.prev = tail
            tail = node
        }
    }
    
    // MARK: - Insert at
    @discardableResult
    public mutating func insert(_ value: T, at index: Int) -> Bool {
        // 1. Create node
        let node = Node(value)

        // 2. Defer count incrementation
        defer { count += 1 }

        // 3. Out of bounds case (including negative indexes)
        guard (index >= 0) && (index < count) else { return false }

        // 4. Empty case
        if isEmpty {
            head = node
            tail = node
            return true
        }

        // 5. Find current node at index
        var n: Int = 0
        var prev = head
        var current = head

        while n < index {
            prev = current
            current = current?.next
            n += 1
        }

        // 6. Insert new node between 'prev' and 'current'
        prev?.next = node
        node.prev = prev

        current?.prev = node
        node.next = current

        return true
    }

    // MARK: - Pop
    @discardableResult
    public mutating func pop() -> T? {

        // 1. Defer count decrease
        defer { count -= 1 }

        // 2. Solo case
        if hasSoloItem {
            defer {
                head = nil
                tail = nil
            }
            return head?.value
        
        // 3. Default case
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
        // 1. Defer count decrease
        defer { count -= 1 }
        
        // 2. Empty case
        if isEmpty {
            return nil
        }

        // 3. Solo case
        if hasSoloItem {
            defer {
                tail = nil
                head = nil
            }
            return tail?.value

        // 4. Default case
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
        
        // 1. Guard out of bounds (including negative indexes)
        guard (index >= 0) && (index < count) else { return nil }

        // 2. Defer count decrease
        defer { count -= 1 }

        // 3. Find node
        var n = 0
        var current = head
        
        while n < index {
            current = current?.next
            n += 1
        }

        // 4. Remove node
        current?.prev?.next = current?.next
        current?.next?.prev = current?.prev

        // 5. Return value
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

    var description: String {
        guard let head = head else { return "EMPTY DOUBLY LINKED LIST" }
        return "DOUBLY LINKED LIST: \(count) || " + String(describing: head)
    }
}
