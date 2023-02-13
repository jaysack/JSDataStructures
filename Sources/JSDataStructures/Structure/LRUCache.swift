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
    public init(capacity: Int) {
        self.capacity = capacity
        self.list = DoublyLinkedList()
        self.hashTable = [: ]
        self.count = 0
    }
    
    // MARK: - Properties
    // Public
    public var isEmpty: Bool { count == 0 }
    public private(set) var capacity: Int
    public private(set) var count: Int {
        didSet {
            if count > capacity { fatalError("LRU Cache Error: count did exceed capacity") }
        }
    }
    // Private
    private var list: DoublyLinkedList<T>
    private var hashTable: [T: Node<T>]

    // MARK: - Methods
    // Peek
    public func peek() -> T? {
        return list.peek
    }

    // Insert
    public mutating func insert(_ value: T) {
        // Add to head and save
        let node = list.push(value)
        hashTable[value] = node

        // Defer count incrementation (count property should never exceed capacity)
        defer { count += 1 }

        // Remove tail if capacity reached
        if count == capacity, let lruValue = list.popLast() {
            hashTable[lruValue] = nil
            count -= 1
        }
    }
   
    // Contains
    public mutating func contains(_ value: T) -> Bool {
        // Get old node
        guard let node = hashTable[value] else { return false }

        // Eject old node from DLL storage
        list.eject(node)
        
        // Insert new node at head
        hashTable[value] = list.push(node.value)

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
        guard let item = list.pop() else { return nil }
        defer { count -= 1 }
        return item
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
              - peek: \(self.peek() == nil ? "nil" : String(describing: self.peek()!))
            """
        return description
    }
}
