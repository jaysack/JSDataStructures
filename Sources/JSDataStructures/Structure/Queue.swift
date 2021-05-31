//
//  Queue.swift
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

public struct Queue<T>: Sequence {
    
    // MARK: - Init
    public init() {
        self.elements = []
        self.count = 0
    }

    // MARK: - Properties
    public private(set) var elements: [T]
    public private(set) var count: Int
    public var peek: Element? { return elements.first }
    public var isEmpty: Bool { return elements.isEmpty }

    // MARK: - Mutating Methods
    // Enqueue
    @discardableResult
    public mutating func enqueue(_ value: T) -> Bool {
        elements.append(value)
        defer { count += 1 }
        return true
    }
    
    // Dequeue
    @discardableResult
    public mutating func dequeue() -> T? {
        // Empty case
        guard !isEmpty else { return nil }

        // Default case
        guard let head = elements.first else { return nil }
        elements = Array(elements.dropFirst())

        // Update count
        defer { count -= 1 }

        // Return head
        return head
    }
}

//
// ==================
// MARK: - EXTENSIONS
// ==================
//

// MARK: - IteratorProtocol
extension Queue: IteratorProtocol {
    public mutating func next() -> T? {
        guard count > 0 else { return nil }
        defer { count -= 1 }
        return elements[count - 1]
    }
}

// MARK: - CustomStringConvertible
extension Queue: CustomStringConvertible {
    public var description: String {
        return "\(self.elements)"
    }
}

// MARK: - CustomDebugStringConvertible
extension Queue: CustomDebugStringConvertible {
    public var debugDescription: String {
        let description = """
            QUEUE: \(self)
              - count: \(self.count)
              - peek: \(self.peek == nil ? "nil" : String(describing: self.peek!))
              - isEmpty: \(self.isEmpty)
            """
        return description
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Queue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        self.init()
        for element in elements {
            self.enqueue(element)
        }
    }
}
