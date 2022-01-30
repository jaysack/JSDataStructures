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
    var one: TreeNode<Int>!
    var two: TreeNode<Int>!
    var three: TreeNode<Int>!
    var seven: TreeNode<Int>!
    var nine: TreeNode<Int>!
    var ten: TreeNode<Int>!
    var twelve: TreeNode<Int>!
    
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

    func testTreeNode_WhenGettingHeightOfLeafNode_ShouldReturnZero() {
        // Arrange
        assert(two.isLeaf)
        
        // Act
        let height = two.height
        
        // Assert
        XCTAssertEqual(height, 0, "Height of leaf node should be 0 but it is not")
    }
    
    func testTreeNode_WhenGettingHeight_ShouldReturnCorrectDepthValue() {
        // Arrange
        assert(!root.isLeaf)
        
        // Act
        let height = root.height

        // Assert
        XCTAssertEqual(height, 3, "Depth of root node should be 3 but it is not")
    }

}
