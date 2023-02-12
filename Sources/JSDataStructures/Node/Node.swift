//
//  Node.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import Foundation

//
// =============
// MARK: - CLASS
// =============
//

final public class Node<T>: LinkNodeProtocol {

    // MARK: Typealiases
    public typealias Element = Node<T>
    
    // MARK: - Init
    public init(_ value: T, prev: Element? = nil, next: Element? = nil) {
        self.value = value
        self.prev = prev
        self.next = next
    }
    
    // MARK: - Properties
    public var value: T
    public var prev: Element?
    public weak var next: Element?
}

//
// ==================
// MARK: - EXTENSIONS
// ==================
//

// MARK: - CustomStringConvertible
extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next)
    }
}
