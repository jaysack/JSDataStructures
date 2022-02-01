//
//  TreeNodeTests.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import XCTest
@testable import JSDataStructures

class TreeNodeTests: XCTestCase {

    // MARK: - Properties
    var root: TreeNode<Int>!
    var one: TreeNode<Int>!
    var two: TreeNode<Int>!
    var three: TreeNode<Int>!
    var seven: TreeNode<Int>!
    var nine: TreeNode<Int>!
    var ten: TreeNode<Int>!
    var twelve: TreeNode<Int>!
    
    // MARK: - Set Up
    override func setUpWithError() throws {
        //       GRAPH
        //
        //         4
        //       / | \
        //      1  7  9
        //     /     /  \
        //    2     3    12
        //         /
        //        10
        //

        // Root
        root = TreeNode<Int>(4)
        
        // Children
        one = TreeNode<Int>(1)
        seven = TreeNode<Int>(7)
        nine = TreeNode<Int>(9)
        
        root.insert(one)
        root.insert(seven)
        root.insert(nine)
        
        // Other levels
        two = TreeNode<Int>(2)
        twelve = TreeNode<Int>(12)
        three = TreeNode<Int>(3)
        ten = TreeNode<Int>(10)
        
        one.insert(two)
        nine.insert(twelve)
        nine.insert(three)
        
        three.insert(ten)
    }

    // MARK: - Tear Down
    override func tearDownWithError() throws {
        root = nil
        one = nil
        two = nil
        three = nil
        seven = nil
        nine = nil
        ten = nil
        twelve = nil
    }

    // MARK: - Traversal Tests
    func testTreeNode_WhenTraversingDepthFirst_ShouldReturnCorrectDepthFirstOrder() {
        // Arrange
        let validOrder: [Int] = [4, 1, 2, 7, 9, 12, 3, 10]
        // Act
        var depthFirstOrder: [Int] = []
        root.forEachDepthFirst { depthFirstOrder.append($0.value) }
        // Assert
        XCTAssertEqual(depthFirstOrder, validOrder, "Depth first traversal returned an invalid order")
    }
    
    func testTreeNode_WhenTraversingLevelOrder_ShouldReturnCorrectLevelOrder() {
        // Arrange
        let validOrder: [Int] = [4, 1, 7, 9, 2, 12, 3, 10]
        // Act
        var levelOrder: [Int] = []
        root.forEachLevelOrder { levelOrder.append($0.value) }
        // Assert
        XCTAssertEqual(levelOrder, validOrder, "Depth first traversal returned an invalid order")
    }

    // MARK: - Filtering Tests
    func testTreeNode_WhenFilteringDepthFirst_ShouldReturnFilteredDepthFirstOrder() {
        // Arrange
        let validOrder1: [Int] = [9, 12, 10]
        let validOrder2: [Int] = [2, 7, 12, 10]
        // Act
        let depthFirstOrder1: [TreeNode<Int>] = root.filterDepthFirst { $0.value > 8 }
        let depthFirstOrder2: [TreeNode<Int>] = root.filterDepthFirst { $0.isLeaf }
        // Assert
        precondition(validOrder1.count == depthFirstOrder1.count)
        precondition(validOrder2.count == depthFirstOrder2.count)
        validOrder1.indices.forEach { XCTAssertEqual(validOrder1[$0], depthFirstOrder1[$0].value) }
        validOrder2.indices.forEach { XCTAssertEqual(validOrder2[$0], depthFirstOrder2[$0].value) }
    }
    
    func testTreeNode_WhenFilteringLevelOrder_ShouldReturnFilteredLevelOrder() {
        // Arrange
        let validOrder1: [Int] = [4, 1, 7, 2, 3]
        let validOrder2: [Int] = [4, 1, 9, 3]
        // Act
        let levelOrder1: [TreeNode<Int>] = root.filterLevelOrder { $0.value < 8 }
        let levelOrder2: [TreeNode<Int>] = root.filterLevelOrder { !$0.isLeaf }
        // Assert
        precondition(validOrder1.count == levelOrder1.count)
        precondition(validOrder2.count == levelOrder2.count)
        validOrder1.indices.forEach { XCTAssertEqual(validOrder1[$0], levelOrder1[$0].value) }
        validOrder2.indices.forEach { XCTAssertEqual(validOrder2[$0], levelOrder2[$0].value) }
    }

    // MARK: - Map Tests
    func testTreeNode_WhenMappingDepthFirst_ShouldReturnCorrectMappedDepthFirstOrder() {
        // Arrange
        let validOrder: [Int] = [40, 10, 20, 70, 90, 120, 30, 100]
        // Act
        let depthFirstOrder: [Int] = root.mapDepthFirst { $0.value * 10 }
        // Assert
        XCTAssertEqual(depthFirstOrder, validOrder, "Map depth first traversal should returned mapped values in depth first order")
    }

    func testTreeNode_WhenMappingLevelOrder_ShouldReturnCorrectMappedLevelOrder() {
        // Arrange
        let validOrder: [Int] = [400, 100, 700, 900, 200, 1200, 300, 1000]
        // Act
        let levelOrder: [Int] = root.mapLevelOrder { $0.value * 100 }
        // Assert
        XCTAssertEqual(levelOrder, validOrder, "Map level order traversal should returned mapped values in level order")
    }

    // MARK: - Height Tests
    func testTreeNode_WhenGettingHeightOfLeafNode_ShouldReturnZero() {
        // Arrange
        assert(two.isLeaf)
        // Act
        let height = two.height
        // Assert
        XCTAssertEqual(height, 0, "Height of leaf node should be 0 but it is not")
    }
    
    func testTreeNode_WhenGettingHeightOfNonLeafNode_ShouldReturnCorrectHeightValue() {
        // Arrange
        assert(!root.isLeaf)
        // Act
        let height = root.height
        // Assert
        XCTAssertEqual(height, 3, "Depth of root node should be 3 but it is not")
    }

    // MARK: - Depth Tests
    func testTreeNode_WhenGettingDepthOfRootNode_ShouldReturnZero() {
        // Arrange
        assert(root.parent == nil)
        // Act
        let depth = root.depth
        // Assert
        XCTAssertEqual(depth, 0, "Depth of root node should be 0 but it is not")
    }
    
    func testTreeNode_WhenGettingHeightOfNonRootNode_ShouldReturnCorrectDepthValue() {
        // Arrange
        assert(twelve.parent != nil)
        // Act
        let depth = twelve.depth
        // Assert
        XCTAssertEqual(depth, 2, "Depth of node twelve should be 2 but it is not")
    }

}
