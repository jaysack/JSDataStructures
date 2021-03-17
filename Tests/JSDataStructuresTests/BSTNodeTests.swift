
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
    
    let MIN_VALUE: Int = 1
    let MAX_VALUE: Int = 12
    
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

    // MARK: - 'traversal' tests
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

    // MARK: - 'lookup' methods tests
    func testBSTNode_WhenCheckingMinimum_ShouldReturnMostLeftValue() {
        // Arrange
        let min = MIN_VALUE

        // Act
        let minimum = root.minimum()

        // Assert
        XCTAssertEqual(min, minimum, "Minimum should return most left node but it did not")
    }

    func testBSTNode_WhenCheckingMaximum_ShouldReturnMostRightValue() {
        // Arrange
        let max = MAX_VALUE
        
        // Act
        let maximum = root.maximum()

        // Assert
        XCTAssertEqual(max, maximum, "Maximum should return most right node but it did not")
    }

    func testBSTNode_WhenCheckingValidElement_ShouldReturnTrue() {
        // Arrange

        // Act
        let doesExist = root.contains(9)

        // Assert
        XCTAssertTrue(doesExist, "Contains should return true for existing elements but it returned false")
    }

    func testBSTNode_WhenCheckingInvalidElement_ShouldReturnFalse() {
        // Arrange

        // Act
        let doesExist = root.contains(100)

        // Assert
        XCTAssertFalse(doesExist, "Contains should return false for non-existing elements but it returned true")
    }

    // MARK: - 'mutating' methods tests
    func testBSTNode_WhenInsertingSmallerValueOnLeftLeafedNode_ShouldUpdateLeftChild() {
        // Arrange
        assert(one.children.isEmpty)

        // Act
        one.insert(0)

        // Assert
        XCTAssertNotNil(one.left, "Left node should have been updated after inserting smaller value on left-leafed node")
    }

    func testBSTNode_WhenInsertingHigherValueOnRightLeafedNode_ShouldUpdateRightChild() {
        // Arrange
        assert(twelve.children.isEmpty)

        // Act
        twelve.insert(13)

        // Assert
        XCTAssertNotNil(twelve.right, "Right node should have been updated after inserting higher value on right-leafed node")
    }
}
