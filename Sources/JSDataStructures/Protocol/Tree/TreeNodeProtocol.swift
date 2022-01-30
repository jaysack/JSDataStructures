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
    var isLeaf: Bool { get }
    var height: Int { get }
}

// MARK: - EXT. Default Implementation
public extension TreeNodeProtocol {

    var isLeaf: Bool {
        return children.isEmpty
    }
    
    var height: Int {
        // Leaf case
        guard !isLeaf else { return 0 }
        
        // Default case
        let childrenDepth = children.map { $0.height }
        return 1 + (childrenDepth.max() ?? 0)
    }
}
