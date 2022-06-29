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
    public init() {
        self.elements = []
        self.count = 0
    }

    // MARK: - Properties
    public private(set) var elements: [T]
    public private(set) var count: Int
    public var peek: Element? { return elements.last }
    public var isEmpty: Bool { return elements.isEmpty }
    
    // MARK: - Mutating Methods
    // Push
    public mutating func push(_ value: T) {
        defer { count += 1 }
        elements.append(value)
    }

    // Pop
    @discardableResult
    public mutating func pop() -> T? {
        defer { count -= 1 }
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
        guard count > 0 else { return nil }
        defer { count -= 1 }
        return elements[count - 1]
    }
}

// MARK: - CustomStringConvertible
extension Stack: CustomStringConvertible {
    public var description: String {
        return "\(self.elements.reversed())"
    }
}

// MARK: - CustomDebugStringConvertible
extension Stack: CustomDebugStringConvertible {
    public var debugDescription: String {
        let description = """
            STACK: \(self.reversed())
              - count: \(self.count)
              - peek: \(self.peek == nil ? "nil" : String(describing: self.peek!))
              - isEmpty: \(self.isEmpty)
            """
        return description
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Stack: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = T
    public init(arrayLiteral elements: T...) {
        self.init()
        for element in elements.reversed() {
            self.push(element)
        }
    }
}
