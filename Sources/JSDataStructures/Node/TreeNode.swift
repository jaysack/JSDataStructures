//
//  TreeNode.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import Foundation

final public class TreeNode<T>: TraversableTreeNode {

    // MARK: - Typealiases
    public typealias Value = T
    public typealias Element = TreeNode<T>
    
    // MARK: - Init
    public init(_ value: Value, weight: Int = 0, children: [Element] = []) {
        self.value = value
        self.weight = weight
        self.children = children
    }
    
    // MARK: - Properties
    public var value: Value
    public var children: [Element]
    public weak var parent: Element?
    public private(set) var weight: Int
    
    // MARK: - Mutation Methods
    // Add
    @discardableResult
    public func insert(_ child: Element) -> Bool {
        child.parent = self
        children.append(child)
        weight += child.weight
        return true
    }
}

// MARK: EXT. Value == Equatable
public extension TreeNode where Value: Equatable {
    // Remove
    @discardableResult
    func removeFirst(_ child: Element) -> Bool {
        if let index = children.firstIndex(where: { $0.value == child.value }) {
            children.remove(at: index)
            return true
        }
        return false
    }
    
    // Remove all
    @discardableResult
    func removeAll(_ child: Element) -> Bool {
        let childrenCount = children.count
        children.removeAll(where: { $0.value == child.value })
        let updatedChildrenCount = children.count
        return updatedChildrenCount < childrenCount
    }
}
