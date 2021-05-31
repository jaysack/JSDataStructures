//
//  DoublyLinkedList.swift
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

public struct DoublyLinkedList<T: Equatable> {
    
    // MARK: Typealiases
    public typealias Element = T
    public typealias Index = Int
    
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
    public var hasSingleItem: Bool { return head === tail && !isEmpty }

    // MARK: - Push
    @discardableResult
    public mutating func push(_ value: T) -> Node<T> {

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
        
        // Return node
        return node
    }

    // MARK: - Append
    @discardableResult
    public mutating func append(_ value: T) -> Node<T> {

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
        
        // Return node
        return node
    }
    
    // MARK: - Insert at
    @discardableResult
    public mutating func insert(_ value: T, at index: Int) -> Bool {

        // Out of bounds case (including negative indexes)
        guard (index >= 0) && (index < count) else { return false }
        
        // Create node
        let node = Node(value)

        // Defer count incrementation
        defer { count += 1 }

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

        // Empty case
        guard !isEmpty else { return nil }

        // Defer count decrease
        defer { count -= 1 }

        // Solo case
        if hasSingleItem {
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
        
        // Empty case
        guard !isEmpty else { return nil }

        // Defer count decrease
        defer { count -= 1 }

        // Solo case
        if hasSingleItem {
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
    
    // MARK: - Eject node
    @discardableResult
    public mutating func eject(_ node: Node<T>) -> T? {
        
        // Empty case
        guard !isEmpty else { return nil }

        // Solo case
        guard !hasSingleItem else { return pop() }
        
        // Defer count decrease
        defer { count -= 1 }

        // Default case
        node.prev?.next = node.next
        node.next?.prev = node.prev
        
        // Return value
        return node.value
    }

    // MARK: - Node at
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
    public func contains(_ value: T) -> Index? {
        
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

//
// ==================
// MARK: - EXTENSIONS
// ==================
//

// MARK: - ExpressibleByArrayLiteral
extension DoublyLinkedList: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        self.init()
        for element in elements {
            self.append(element)
        }
    }
}

// MARK: - CustomStringConvertible
extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        return "\(self.isEmpty ? "[]" : String(describing: head!))"
    }
}

// MARK: - CustomDebugStringConvertible
extension DoublyLinkedList: CustomDebugStringConvertible {
    public var debugDescription: String {
        let description = """
            DOUBLY LINKED LIST
              - list: \(self)
              - count: \(self.count)
              - peek: \(self.peek == nil ? "nil" : String(describing: self.peek!))
              - head: \(self.head == nil ? "nil" : String(describing: self.head!.value))
              - tail: \(self.tail == nil ? "nil" : String(describing: self.tail!.value))
              - isEmpty: \(self.isEmpty)
              - hasSingleItem: \(self.hasSingleItem)
            """
        return description
    }
}

// MARK: - RandomAccessCollection
extension DoublyLinkedList: RandomAccessCollection {

    public var startIndex: Index { return 0 }
    public var endIndex: Index { return count }

    public func index(before i: Index) -> Index { return i - 1 }
    public func index(after i: Index) -> Index { return i + 1 }

    public subscript(position: Int) -> T {
        get {
            print("INDICES: ", indices)
            precondition(indices.contains(position), "Doubly Linked List \(String(describing: self)): index (\(position)) is out-of-bounds")
            return node(at: position)!.value
        }
    }
}
