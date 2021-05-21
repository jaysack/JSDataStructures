//
//  TreeNodeProtocol.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

// MARK: - Protocol
public protocol TreeNodeProtocol: AnyObject {

    associatedtype Value
    associatedtype Element: TreeNodeProtocol

    var value: Value { get }
    var children: [Element] { get }
    func isLeaf() -> Bool
    func depth() -> Int
}

// MARK: - EXT. Default Implementation
public extension TreeNodeProtocol {

    func isLeaf() -> Bool { return children.isEmpty }

    func depth() -> Int {
        // Leaf case
        guard !isLeaf() else { return 1 }

        // Default case
        let childrenDepth = children.map { $0.depth() }
        return 1 + (childrenDepth.max() ?? 0)
    }
}
