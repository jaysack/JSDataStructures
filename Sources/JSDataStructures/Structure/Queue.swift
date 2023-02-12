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
    public init(_ elements: [T]) {
        self.elements = elements
    }

    // MARK: - Properties
    private var elements: [T]
    public var count: Int { return elements.count }
    public var peek: Element? { return elements.first }
    public var isEmpty: Bool { return elements.isEmpty }

    // MARK: - Mutating Methods
    // Enqueue
    @discardableResult
    public mutating func enqueue(_ value: T) -> Bool {
        elements.append(value)
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
        return dequeue()
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
            """
        return description
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Queue: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}
