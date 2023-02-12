//
//  BSTNode.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import Foundation

public class BSTNode<T: Comparable>: TraversableBinaryNode {

    // MARK: - Typealiases
    public typealias Value = T
    public typealias Element = BSTNode<T>

    // MARK: - Init
    public init(_ value: Value, left: Element? = nil, right: Element? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }

    // MARK: - Properties
    public var value: Value
    public weak var parent: Element?

    public var left: Element? {
        didSet { left?.parent = self }
    }

    public var right: Element? {
        didSet { right?.parent = self }
    }
    
    public var children: [Element] {
        return [left, right].compactMap { $0 }
    }

    // MARK: - Lookup Methods
    // Minimum
    public func minimum() -> Value {
        guard let left = self.left else { return value }
        return left.minimum()
    }

    // Maximum
    public func maximum() -> Value {
        guard let right = self.right else { return value }
        return right.maximum()
    }

    // Contains
    public func contains(_ element: Value) -> Bool {

        if element == value {
            return true

        } else if element < value {
            return left?.contains(element) ?? false
            
        } else if element > value {
            return right?.contains(element) ?? false
            
        } else {
            return false
        }
    }

    // MARK: - Mutating Methods
    // Insert
    func insert(_ value: T) {

        // Get node
        let node = Element(value)
        
        // Left side
        if value < self.value {

            // Update left node
            if let left = self.left {
                left.insert(value)

            // New left node
            } else {
                left = node
            }
        }

        // Right side
        if value > self.value {

            // Update right node
            if let right = self.right {
                right.insert(value)

            // New right node
            } else {
                right = node
            }
        }
        
    }
}

// MARK: - EXT. Custom String Convertible
extension BSTNode: CustomStringConvertible {

    public var description: String { return diagram(for: self) }
  
    private func diagram(for node: BSTNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {

        guard let node = node else { return root + "nil\n" }
        
        if node.left == nil && node.right == nil {
            return root + "\(node.value)\n"
        }

        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
            + root
            + "\(node.value)\n"
            + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
  }
}
