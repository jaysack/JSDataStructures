
import XCTest
@testable import JSDataStructures

class BSTNodeTests: XCTestCase {

    /*
            4
          /   \
         2     9
        / \   / \
       1   3 7  12
     */
    var root: BSTNode<Int>!
    
    var one:    BSTNode<Int>!
    var two:    BSTNode<Int>!
    var three:  BSTNode<Int>!
    var four:   BSTNode<Int>!
    var seven:  BSTNode<Int>!
    var nine:   BSTNode<Int>!
    var twelve: BSTNode<Int>!
    
    override func setUpWithError() throws {
        
        // Root
        root = BSTNode<Int>(4)
        
        // Level #1
        two = BSTNode<Int>(2)
        nine = BSTNode<Int>(9)
        
        root.left = two
        root.right = nine
        
        // Level #2
        one = BSTNode<Int>(1)
        three = BSTNode<Int>(3)
        seven = BSTNode<Int>(7)
        twelve = BSTNode<Int>(12)
        
        two.left = one
        two.right = three
        
        nine.left = seven
        nine.right = twelve
    }

    override func tearDownWithError() throws {
        twelve = nil
        nine = nil
        seven = nil
        four = nil
        three = nil
        two = nil
        one = nil
        root = nil
    }

    func testBSTNode_WhenTraversingInOrder_ShouldReturnCollectionInOrder() {
        // Arrange
        let validOrder: [Int] = [1, 2, 3, 4, 7, 9, 12]

        // Act
        var inOrder: [Int] = []
        root.forEachInOrder { inOrder.append($0.value) }

        // Assert
        XCTAssertEqual(inOrder, validOrder, "In-order traversal should return a collection in order")
    }
    
    func testBSTNode_WhenTraversingPreOrder_ShouldReturnCollectionPreOrder() {
        // Arrange
        let validOrder: [Int] = [4, 2, 1, 3, 9, 7, 12]

        // Act
        var preOrder: [Int] = []
        root.forEachPreOrder { preOrder.append($0.value) }

        // Assert
        XCTAssertEqual(preOrder, validOrder, "Pre-order traversal should return a collection pre order")
    }

    func testBSTNode_WhenTraversingPostOrder_ShouldReturnCollectionPostOrder() {
        // Arrange
        let validOrder: [Int] = [1, 3, 2, 7, 12, 9, 4]

        // Act
        var postOrder: [Int] = []
        root.forEachPostOrder { postOrder.append($0.value) }

        // Assert
        XCTAssertEqual(postOrder, validOrder, "Post-order traversal should return a collection post order")
    }

}
