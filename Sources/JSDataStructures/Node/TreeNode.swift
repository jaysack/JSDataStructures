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
    public init(_ value: Value) {
        self.value = value
        self.children = []
    }
    
    // MARK: - Properties
    public var value: Value
    public var children: [Element]
    public weak var parent: Element?
    
    // MARK: - Mutation Methods
    // Add
    @discardableResult
    public func insert(_ child: Element) -> Bool {
        child.parent = self
        children.append(child)
        return true
    }
}
