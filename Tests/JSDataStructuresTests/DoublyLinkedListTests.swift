
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
    
    // MARK: - 'count' property tests
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
    
    // MARK: - 'hasSoloItem' property tests
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

    // MARK: - 'push' method tests
    func testDoublyLinkedList_WhenPushingAnElement_ShouldUpdateHead() {
        // Arrange
        let oldHead = sut.node(at: 0)
        
        // Act
        sut.push(100)
        
        // Assert
        XCTAssertFalse(oldHead === sut.node(at: 0), "Head node should have been updated after pushing a new element")
    }

    // MARK: - 'append' method tests
    func testDoublyLinkedList_WhenAppendingAnElement_ShouldUpdateTail() {
        // Arrange
        let endIndex = sut.count - 1
        let oldTail = sut.node(at: endIndex)
        
        // Act
        sut?.append(200)
        
        // Assert
        XCTAssertFalse(oldTail === sut.node(at: sut.count - 1), "Old tail node should have been updated after appending a new element")
    }
    
    // MARK: - 'insertAt' method tests
    func testDoublyLinkedList_WhenInsertingAtValidIndex_ShouldReturnTrue() {
        // Arrange
        assert(sut.count > 2)

        // Act
        let insertionResult = sut.insert(300, at: 2)
        
        // Assert
        XCTAssertTrue(insertionResult, "Only valid index insertions can return true")
    }

    func testDoublyLinkedList_WhenInsertingAtInvalidIndex_ShouldReturnFalse() {
        // Arrange
        let invalidIndex = -3

        // Act
        let insertionResult = sut.insert(400, at: invalidIndex)
        
        // Assert
        XCTAssertFalse(insertionResult, "Invalid index insertion should return false")
    }

    // MARK: - 'pop' method tests
    func testDoublyLinkedList_WhenPoppingOnAnEmptyList_ShouldReturnNil() {
        // Arrange
        sut = DoublyLinkedList<Int>()

        // Act
        let poppedItem = sut.pop()
        
        // Assert
        XCTAssertNil(poppedItem, "Popped item from empty list should yield 'nil' but it did not")
    }

    func testDoublyLinkedList_WhenPoppingOnNonEmptyList_ShouldReturnHead() {
        // Arrange
        assert(!sut.isEmpty)
        let head = sut.node(at: 0)

        // Act
        let poppedValue = sut.pop()
        
        // Assert
        XCTAssertEqual(head?.value, poppedValue, "Head should be popped first but it was not the case")
    }

    func testDoublyLinkedList_WhenPoppingOnASingleItemList_ShouldReturnTail() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        sut.append(4)
        assert(sut.hasSoloItem)

        // Act
        let endIndex = sut.count - 1
        let tail = sut.node(at: endIndex)
        let poppedValue = sut.pop()
        
        // Assert
        XCTAssertEqual(tail?.value, poppedValue, "Tail should be popped first but it was not the case")
    }
    
    func testDoublyLinkedList_WhenPoppingLastOnAnEmptyList_ShouldReturnNil() {
        // Arrange
        sut = DoublyLinkedList<Int>()

        // Act
        let poppedItem = sut.popLast()
        
        // Assert
        XCTAssertNil(poppedItem, "Popped Last item from empty list should yield 'nil' but it did not")
    }

    func testDoublyLinkedList_WhenPoppingLastOnNonEmptyList_ShouldReturnTail() {
        // Arrange
        assert(!sut.isEmpty)

        // Act
        let endIndex = sut.count - 1
        let tail = sut.node(at: endIndex)
        let poppedValue = sut.popLast()
        
        // Assert
        XCTAssertEqual(tail?.value, poppedValue, "Tail should be last-popped first but it was not the case")
    }

    func testDoublyLinkedList_WhenPoppingLastOnSingleItemList_ShouldReturnTail() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        sut.append(4)
        assert(sut.hasSoloItem)

        // Act
        let endIndex = sut.count - 1
        let tail = sut.node(at: endIndex)
        let poppedValue = sut.pop()
        
        // Assert
        XCTAssertEqual(tail?.value, poppedValue, "Tail should be last-popped first but it was not the case")
    }
    
    // MARK: - 'removeAt' method tests
    func testDoublyLinkedList_WhenRemovingElementAtInvalidIndex_ShouldReturnNil() {
        // Arrange
        let validRange = 0 ..< sut.count
        let invalidIndex = 1000
        assert(!validRange.contains(invalidIndex))

        // Act
        let removedNode = sut.remove(at: invalidIndex)
        
        // Assert
        XCTAssertNil(removedNode, "Removing node at invalid index should return nil but it did not")
    }

    func testDoublyLinkedList_WhenRemovingElementAtValidIndex_ShouldReturnNodeAtIndex() {
        // Arrange
        let validRange = 0 ..< sut.count
        let validIndex = 2
        assert(validRange.contains(validIndex))

        // Act
        let removedNode = sut.remove(at: validIndex)
        
        // Assert
        XCTAssertNotNil(removedNode, "Removing nove at valid index should not return nil")
    }

    // MARK: - 'contains' method tests
    func testDoublyLinkedList_WhenCallingContainsOnEmptyList_ShouldReturnFalse() {
        // Arrange
        sut = DoublyLinkedList<Int>()

        // Act
        let number = sut.contains(10)
        
        // Assert
        XCTAssertNil(number, "Empty list should not contain any item")
    }
}
