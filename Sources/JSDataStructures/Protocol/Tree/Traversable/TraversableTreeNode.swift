//
//  TraversableTreeNode.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

// MARK: - Protocol
public protocol TraversableTreeNode: TreeNodeProtocol where Element: TraversableTreeNode {
    @inlinable func forEachDepthFirst(completion: (Element) throws -> Void) rethrows
    @inlinable func forEachLevelOrder(completion: (Element) throws -> Void) rethrows
    @inlinable func filterDepthFirst(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element]
    @inlinable func filterLevelOrder(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element]
    @inlinable func mapDepthFirst<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    @inlinable func mapLevelOrder<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    @inlinable func findDepthFirst(_ isIncluded: (Element) throws -> Bool) rethrows -> Element?
    @inlinable func findLevelOrder(_ isIncluded: (Element) throws -> Bool) rethrows -> Element?
}

// MARK: - EXT. Traversal Methods
public extension TraversableTreeNode where Self == Element {

    // MARK: - Depth First (Pre-Order)
    // For Each
    @inlinable func forEachDepthFirst(completion: (Element) throws -> Void) rethrows {
        try completion(self)
        try children.forEach { try $0.forEachDepthFirst(completion: completion) }
    }

    // Filter
    @inlinable func filterDepthFirst(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        var result: [Element] = []
        try forEachDepthFirst {
            guard try isIncluded($0) else { return }
            result.append($0)
        }
        return result
    }

    // Find
    @inlinable func findDepthFirst(_ isIncluded: (Element) throws -> Bool) rethrows -> Element? {
        if try isIncluded(self) { return self }
        for child in children {
            if let found = try child.findDepthFirst(isIncluded) {
                return found
            }
        }
        return nil
    }

    // Map
    @inlinable func mapDepthFirst<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result: [T] = []
        try forEachDepthFirst {
            let transformedElement = try transform($0)
            result.append(transformedElement)
        }
        return result
    }

    // MARK: - Level Order
    // For Each
    @inlinable func forEachLevelOrder(completion: (Element) throws -> Void) rethrows {

        var queue = Queue<Element>()
        queue.enqueue(self)

        while let node = queue.dequeue() {
            try completion(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
    
    // Filter
    @inlinable func filterLevelOrder(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        var result: [Element] = []
        try forEachLevelOrder {
            guard try isIncluded($0) else { return }
            result.append($0)
        }
        return result
    }
    
    // Map
    @inlinable func mapLevelOrder<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result: [T] = []
        try forEachLevelOrder {
            let transformedElement = try transform($0)
            result.append(transformedElement)
        }
        return result
    }

    // Find
    @inlinable func findLevelOrder(_ isIncluded: (Element) throws -> Bool) rethrows -> Element? {
        var queue = Queue<Element>()
        queue.enqueue(self)
        while let node = queue.dequeue() {
            if try isIncluded(node) { return node }
            node.children.forEach { queue.enqueue($0) }
        }
        return nil
    }
}
