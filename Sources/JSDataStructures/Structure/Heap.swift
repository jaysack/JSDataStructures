//
//  Heap.swift
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

public struct Heap<T: Equatable>: Sequence {
    
    // MARK: - Init
    public init(sort: @escaping (T, T) -> Bool) {
        self.sort = sort
        self.elements = []
    }
    
    // MARK: - Properties
    private var elements: [T]
    private let sort: (T, T) -> Bool
    public var isEmpty: Bool { elements.isEmpty }
    public var count: Int { elements.count }
    
    // MARK: Inspection Methods
    public func peek() -> T? {
        elements.first
    }

    // MARK: - Mutation Methods
    public mutating func insert(_ element: T) {
        elements.append(element)
        siftUp(from: count - 1)
    }

    @discardableResult
    public mutating func remove() -> T? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, count - 1)
        defer { siftDown(from: 0) }
        return elements.removeLast()
    }
}

//
// ==================
// MARK: - EXTENSIONS
// ==================
//

// MARK: - IteratorProtocol
extension Heap: IteratorProtocol {
    public mutating func next() -> T? {
        return remove()
    }
}

// MARK: - CustomStringConvertible
extension Heap: CustomStringConvertible {
    public var description: String {
        return "\(self.elements)"
    }
}

// MARK: - EXT. Indices Methods
private extension Heap {
    func childIndices(ofParentAt index: Int) -> (Int, Int) {
        return (leftChildIndex(ofParentAt: index), rightChildIndex(ofParentAt: parentIndex(ofChildAt: index)))
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
        return (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        return (2 * index) + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }
}

// MARK: - EXT. Helper Methpds
private extension Heap {
    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)

        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }

    mutating func siftDown(from index: Int) {
        var parent = index
        
        while true {
            let (left, right) = childIndices(ofParentAt: parent)
            
            
            var candidate = parent
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }

    func index(of element: T, startingAt i: Int) -> Int? {
        // Guard against out-of-bounds
        guard i < count else { return nil }

        if sort(element, elements[i]) {
            return nil
        }
        
        if element == elements[i] {
            return i
        }
        
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        return nil
    }

    mutating func remove(at index: Int) -> T? {
        // Guard against out-of-bounds
        guard index < count else { return nil }
        
        if index == count - 1 {
            return elements.removeLast()

        } else {
            elements.swapAt(index, count - 1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            return elements.removeLast()
        }
    }
}
