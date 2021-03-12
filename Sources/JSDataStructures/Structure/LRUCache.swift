
import Foundation

public struct LRUCache<T: Hashable> {
    
    // MARK: - Init
    init(capacity: Int) {
        self.capacity = capacity
        self.list = DoublyLinkedList()
    }
    
    // MARK: - Properties
    public var capacity: Int
    public var count: Int { return list.count }
    public var peek: T? { return list.peek }
    private var list: DoublyLinkedList<T>

    // MARK: - Methods
    // Insert
    public mutating func insert(_ value: T) {
        // Add to head
        list.push(value)

        // Remove tail if capacity reached
        if count > capacity {
            list.popLast()
        }
    }
   
    // Contains
    public mutating func contains(_ value: T) -> Bool {
        // Get index
        guard let index = list.contains(value) else { return false }

        // Move node to front
        guard let node = list.remove(at: index) else { return false }
        list.push(node)

        // Return
        return true
    }
}
