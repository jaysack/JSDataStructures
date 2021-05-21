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

    var root: TreeNode<Int>!
    
    override func setUpWithError() throws {
        
        // Root
        root = TreeNode<Int>(4)
        
        // Children
        let one = TreeNode<Int>(1)
        let seven = TreeNode<Int>(7)
        let nine = TreeNode<Int>(9)
        
        root.insert(one)
        root.insert(seven)
        root.insert(nine)
        
        // Other levels
        let two = TreeNode<Int>(2)
        let twelve = TreeNode<Int>(12)
        let three = TreeNode<Int>(3)
        let ten = TreeNode<Int>(10)
        
        one.insert(two)
        nine.insert(twelve)
        nine.insert(three)
        
        three.insert(ten)
    }

    override func tearDownWithError() throws {
        root = nil
    }

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

    func testTreeNode_WhenGettingDepthForLeafNode_ShouldReturnOne() {
        // Arrange
        root = TreeNode<Int>(5)
        
        // Act
        let depth = root.depth()
        
        // Assert
        XCTAssertEqual(depth, 1, "Depth of leaf node should be 1 but it is not")
    }
    
    func testTreeNode_WhenGettingDepth_ShouldReturnCorrectDepthValue() {
        // Arrange
        assert(root.children.count == 3)
        
        // Act
        let depth = root.depth()
        
        // Assert
        XCTAssertEqual(depth, 4, "Depth of root node should be 4 but it is not")
    }

}
