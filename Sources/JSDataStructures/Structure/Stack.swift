//
//  Stack.swift
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

public struct Stack<T>: Sequence {

    // MARK: - Init
    public init(_ elements: [T] = []) {
        self.elements = elements.reversed()
    }

    // MARK: - Properties
    public private(set) var elements: [T]
    public var count: Int { elements.count }
    public var peek: Element? { elements.last }
    public var isEmpty: Bool { elements.isEmpty }
    
    // MARK: - Mutating Methods
    // Push
    public mutating func push(_ value: T) {
        elements.append(value)
    }

    // Pop
    @discardableResult
    public mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        return elements.popLast()
    }
}

//
// ==================
// MARK: - EXTENSIONS
// ==================
//

// MARK: - IteratorProtocol
extension Stack: IteratorProtocol {
    public mutating func next() -> T? {
        return pop()
    }
}

// MARK: - CustomStringConvertible
extension Stack: CustomStringConvertible {
    public var description: String {
        return "\(reversed())"
    }
}

// MARK: - CustomDebugStringConvertible
extension Stack: CustomDebugStringConvertible {
    public var debugDescription: String {
        let description = """
            STACK: \(self.description)
              - count: \(self.count)
              - peek: \(self.peek == nil ? "nil" : String(describing: self.peek!))
            """
        return description
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Stack: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}
