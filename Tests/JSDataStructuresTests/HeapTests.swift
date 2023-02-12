//
//  HeapTests.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import XCTest
@testable import JSDataStructures

class HeapTests: XCTestCase {

    var sut: Heap<Int>!

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Peek tests
    func testHeap_GivenAnEmptyCollection_ShouldReturnPeekAsNil() {
        // Arrange
        sut = Heap(sort: >)
        
        // Act
        let peek = sut.peek()
        
        // Assert
        XCTAssertNil(peek, "Peek should be nil when Heap is empty")
    }

    func testHeap_GivenANonEmptyCollection_ShouldReturnPeek() {
        // Arrange
        sut = Heap(sort: >)
        [14, 31, 12, 28, 21].forEach { sut.insert($0) }
        
        // Act
        let peek = sut.peek()
        
        // Assert
        XCTAssertNotNil(peek, "Peek should not be nil when Heap is not empty")
    }

    // MARK: Insert tests
    func testHeap_WhenInsertingItem_ShouldIncrementCount() {
        // Arrange
        sut = Heap(sort: <)
        [12, 23].forEach { sut.insert($0) }
        
        // Act
        sut.insert(9)
        let count = sut.count
        
        // Assert
        XCTAssertEqual(count, 3, "Heap's count should increase after insertion")
    }

    func testHeap_GivenMaxHeapAndInsertingMaxItem_PeekShouldBeTheMaxItem() {
        // Arrange
        sut = Heap(sort: >)
        [12, 23].forEach { sut.insert($0) }
        
        // Act
        sut.insert(25)
        let peek = sut.peek()
        
        // Assert
        XCTAssertEqual(peek, 25, "Peek should always be the max item in a Max Heap")
    }

    // MARK: 'Remove' tests
    func testHeap_WhenRemovingItem_ShouldDecreseaseCount() {
        // Arrange
        sut = Heap(sort: <)
        [12, 23].forEach { sut.insert($0) }
        
        // Act
        sut.remove()
        let count = sut.count
        
        // Assert
        XCTAssertEqual(count, 1, "Heap's count should decrease after deletion")
    }

    func testHeap_GivenEmptyHeap_RemovingItemShouldReturnNil() {
        // Arrange
        sut = Heap(sort: <)
        assert(sut.count == 0)
        
        // Act
        let removedItem = sut.remove()
        
        // Assert
        XCTAssertNil(removedItem, "Nil should be returned when attempting to remove from empty heap")
    }

    // MARK: Sequence Tests
    func testHeap_GivenMaxHeapAndSequenceProtocol_ReturnItems_InMaxOrder() {
        // Arrange
        sut = Heap(sort: >)
        [14, 31, 12, 28, 21].forEach { sut.insert($0) }

        var result: [Int] = []
        
        // Act
        for item in sut {
            result.append(item)
        }
        
        // Assert
        XCTAssertEqual(result, [31, 28, 21, 14, 12], "Max Heap sequence should follow max heap sort pattern")
    }

    func testHeap_GivenMinHeapAndSequenceProtocol_ReturnItems_InMinOrder() {
        // Arrange
        sut = Heap(sort: <)
        [24, 20, 25, 22, 21].forEach { sut.insert($0) }

        var result: [Int] = []
        
        // Act
        for item in sut {
            result.append(item)
        }
        
        // Assert
        XCTAssertEqual(result, [20, 21, 22, 24, 25], "Min Heap sequence should follow min heap sort pattern")
    }
}
