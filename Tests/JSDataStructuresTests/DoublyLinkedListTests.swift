
import XCTest
@testable import JSDataStructures

class DoublyLinkedListTests: XCTestCase {

    // mock: 3 -> 7 -> 8 -> 15
    var sut: DoublyLinkedList<Int>!

    override func setUpWithError() throws {
        // Instantiate
        sut = DoublyLinkedList<Int>()
        
        // Add nodes
        sut?.append(3)
        sut?.append(7)
        sut?.append(8)
        sut?.append(15)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testDoublyLinkedList_WhenInsertingElement_ShouldIncreaseCount() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut!.append(99)
        
        // Assert
        XCTAssertEqual(5, sut!.count, "Doubly Linked List count should have been increased to 5 but it was not")
    }

    func testDoublyLinkedList_WhenRemovingElement_ShouldDecreaseCount() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut!.popLast()
        
        // Assert
        XCTAssertEqual(3, sut.count, "Doubly Linked List count should have been decreased to 3 but it was not")
    }
    
    func testDoublyLinkedList_WhenCallingHasSoloItemOnEmptyList_ShouldReturnFalse() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        
        // Act
        let boolean = sut.hasSoloItem
        
        // Assert
        XCTAssertEqual(boolean, false, "Empty doubly linked list should not have a solo item but it is not the case")
    }
    
    func testDoublyLinkedList_WhenCallingHasSoloItemOnNonEmptyList_ShouldReturnFalse() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        let boolean = sut.hasSoloItem
        
        // Assert
        XCTAssertEqual(boolean, false, "Non empty doubly linked list should have more than 1 solo item")
    }
    
    func testDoublyLinkedList_WhenCallingHasSoloItemOnSingleItemList_ShouldReturnTrue() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        sut.append(3)
        
        // Act
        let boolean = sut.hasSoloItem
        
        // Assert
        XCTAssertEqual(boolean, true, "Solo item list should have only 1 element")
    }

    func testDoublyLinkedList_WhenPushingAnElement_ShouldUpdateHead() {
        // Arrange
        let oldHead = sut.node(at: 0)
        
        // Act
        sut.push(100)
        
        // Assert
        XCTAssertFalse(oldHead === sut.node(at: 0), "Head node should have been updated after pushing a new element")
    }

    func testDoublyLinkedList_WhenAppendingAnElement_ShouldUpdateTail() {
        // Arrange
        let oldTail = sut.node(at: sut.count - 1)
        
        // Act
        sut?.append(200)
        
        // Assert
        XCTAssertFalse(oldTail === sut.node(at: sut.count - 1), "Old tail node should have been updated after appending a new element")
    }
    
    func testDoublyLinkedList_WhenInsertingAtValidIndex_ShouldReturnTrue() {
        // Arrange
        assert(sut.count > 2)

        // Act
        let insertionResult = sut.insert(300, at: 2)
        
        // Assert
        XCTAssertTrue(insertionResult, "Only valid index insertions can return true")
    }

    func testDoublyLinkedList_WhenInsertingAtInvalidIndex_ShouldReturnTrue() {
        
    }

    func testDoublyLinkedList_WhenPoppingOnAnEmptyList_ShouldReturnNil() {
        
    }

    func testDoublyLinkedList_WhenPoppingOnNonEmptyList_ShouldReturnHead() {
        
    }

    func testDoublyLinkedList_WhenPoppingOnASingleItemList_ShouldReturnTail() {
        
    }
    
    func testDoublyLinkedList_WhenPoppingLastOnAnEmptyList_ShouldReturnNil() {
        
    }

    func testDoublyLinkedList_WhenPoppingLastOnNonEmptyList_ShouldReturnTail() {
        
    }

    func testDoublyLinkedList_WhenPoppingLastOnSingleItemList_ShouldReturnTail() {
        
    }
    
    func testDoublyLinkedList_WhenRemovingElementAtInvalidIndex_ShouldReturnNil() {
        
    }

    func testDoublyLinkedList_WhenRemovingElementAtValidIndex_ShouldReturnNodeAtIndex() {
        
    }

    func testDoublyLinkedList_WhenCallingNodeAtValidIndex_ShouldReturnNodeAtIndex() {
        
    }

    func testDoublyLinkedList_WhenCallingNodeAtInvalidIndex_ShouldReturnNil() {
        
    }

    func testDoublyLinkedList_WhenCallingContainsOnEmptyList_ShouldReturnFalse() {
        
    }
}
