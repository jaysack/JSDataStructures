//
//  LRUCache.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import Foundation

//
// ==============
// MARK: - STRUCT
// ==============
//

public struct LRUCache<T: Hashable>: Sequence {
    
    // MARK: - Init
    init(capacity: Int) {
        self.capacity = capacity
        self.list = DoublyLinkedList()
        self.count = 0
    }
    
    // MARK: - Properties
    public var capacity: Int
    public var count: Int
    public var peek: T? { return list.peek }
    private var list: DoublyLinkedList<T>

    // MARK: - Methods
    // Insert
    public mutating func insert(_ value: T) {
        // Add to head
        list.push(value)
        // Defer count incrementation (count property should never exceed capacity)
        defer { count += 1 }

        // Remove tail if capacity reached
        if count == capacity {
            list.popLast()
            count -= 1
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

//
// ==================
// MARK: - EXTENSIONS
// ==================
//

// MARK: - IteratorProtocol
extension LRUCache: IteratorProtocol {
    public mutating func next() -> T? {
        guard count > 0 else { return nil }
        defer { count -= 1 }
        return list[count - 1]
    }
}

// MARK: - CustomStringConvertible
extension LRUCache: CustomStringConvertible {
    public var description: String {
        return "\(self.list)"
    }
}

// MARK: - CustomDebugStringConvertible
extension LRUCache: CustomDebugStringConvertible {
    public var debugDescription: String {
        let description = """
            LRU CACHE:
              - list: \(self.list)
              - count: \(self.count)
              - capacity: \(self.capacity)
              - peek: \(self.peek == nil ? "nil" : String(describing: self.peek!))
            """
        return description
    }
}
