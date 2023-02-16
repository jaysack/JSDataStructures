//
//  DoublyLinkedListTests.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import XCTest
@testable import JSDataStructures

class DoublyLinkedListTests: XCTestCase {

    // mock: 3 -> 7 -> 8 -> 15
    var sut: DoublyLinkedList<Int>!

    override func setUpWithError() throws {
        // Instantiate
        sut = DoublyLinkedList<Int>()
        
        // Add nodes
        sut.append(3)
        sut.append(7)
        sut.append(8)
        sut.append(15)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - 'count' property tests
    func testDoublyLinkedList_WhenInsertingElement_ShouldIncreaseCount() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut.append(99)
        
        // Assert
        XCTAssertEqual(5, sut!.count, "Doubly Linked List count should have been increased to 5 but it was not")
    }

    func testDoublyLinkedList_WhenRemovingElement_ShouldDecreaseCount() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut.popLast()
        
        // Assert
        XCTAssertEqual(3, sut.count, "Doubly Linked List count should have been decreased to 3 but it was not")
    }
    
    func testDoublyLinkedList_WhenInsertingAtInvalidIndex_ShouldNotIncecreaseCount() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut.insert(1000, at: -1)
        
        // Assert
        XCTAssertEqual(4, sut.count, "Doubly Linked List count should NOT have been increased after attempting to insert at invalid index")
    }
    
    func testDoublyLinkedList_WhenPoppingOnEmptyList_ShouldNotDececreaseCount() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        
        // Act
        sut.pop()
        
        // Assert
        XCTAssertEqual(0, sut.count, "Doubly Linked List count should NOT have been decreased after attempting to pop on an empty list")
    }
    
    func testDoublyLinkedList_WhenPoppingLastOnEmptyList_ShouldNotDececreaseCount() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        
        // Act
        sut.popLast()
        
        // Assert
        XCTAssertEqual(0, sut.count, "Doubly Linked List count should NOT have been decreased after attempting to pop last item in an empty list")
    }
    
    // MARK: - 'hasSingleItem' property tests
    func testDoublyLinkedList_WhenCallingHasSoloItemOnEmptyList_ShouldReturnFalse() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        
        // Act
        // ..
        
        // Assert
        XCTAssertNotEqual(sut.count, 1, "Empty doubly linked list should not have a solo item but it is not the case")
    }
    
    func testDoublyLinkedList_GivenOneItem_ShouldReturnCorrectCount() {
        // Arrange
        sut = DoublyLinkedList<Int>()
        
        // Act
        sut.append(3)
        
        // Assert
        XCTAssertEqual(sut.count, 1, "Solo item list should have only 1 element")
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
        sut.append(200)
        
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
        assert(sut.count == 1)

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
        assert(sut.count == 1)

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

    func testDoublyLinkedList_WhenCheckingExistenceOfValidElement_ShouldElementIndex() {
        // Arrange
        // ...

        // Act
        let index = sut.contains(8)
        
        // Assert
        XCTAssertEqual(index, 2, "Element (8) is located at index 2 but another index was returned")
    }

    func testDoublyLinkedList_WhenCheckingExistenceOfInvalidElement_ShouldReturnNil() {
        // Arrange
        // ...

        // Act
        let index = sut.contains(80)
        
        // Assert
        XCTAssertNil(index, "Element (80) is not part of the doubly linked list but yet still return an index while it's not possible")
    }

    // MARK: - 'Sequence' protocol tests
    func testDoublyLinkedList_SequenceProtocol_ShouldBeTraversableWithAForInLoop() {
        // Arrange
        var result: [Int] = []
        
        // Act
        for element in sut {
            result.append(element)
        }
        
        // Assert
        XCTAssertEqual(result, [3, 7, 8, 15], "For in loop should traverse the sequence in top to bottom order but it did not")
    }

    // MARK: - 'ArrayLiteral' protocol tests
    func testDoublyLinkedList_ArrayLiteralProtocol_ShouldBeInitiableUsingAnArray() {
        // Arrange
        // ...
        
        // Act
        sut = [1, 2, 3, 4]
        
        // Assert
        XCTAssertEqual(sut.head?.value, 1, "List peek should be 4 but it is not")
    }
    
    // MARK: - 'RandomAccessCollection' protocol tests
    func testDoublyLinkedList_WhenAccessingItemFromInvalidSubscript_ShouldFailPrecondition() {
        // Arrange
        // ...
        
        // Act
        let itemAtSubscript = sut[2]
        
        // Assert
        XCTAssertEqual(itemAtSubscript, 8, "Subscript at index '2' should be 8 but it is not")
    }
}
