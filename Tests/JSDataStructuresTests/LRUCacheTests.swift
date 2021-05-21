//
//  LRUCacheTests.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import XCTest
@testable import JSDataStructures

class LRUCacheTests: XCTestCase {

    // mock: 3 -> 7 -> 8 -> 15
    var sut: LRUCache<Int>!
    let MAX_CAPACITY: Int = 5

    override func setUpWithError() throws {
        // Instantiate
        sut = LRUCache<Int>(capacity: MAX_CAPACITY)
        
        // Add nodes
        sut.insert(3)
        sut.insert(7)
        sut.insert(8)
        sut.insert(15)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - 'insert' property tests
    func testLRUCache_WhenInsertingElement_ShouldReplacePeekValue() {
        // Arrange
        let oldPeek = sut.peek

        // Act
        sut.insert(99)

        // Assert
        XCTAssertNotEqual(oldPeek, sut.peek, "Peek should have been replaced after insertion but it was not")
    }

    func testLRUCache_WhenInsertingElement_ShouldIncreaseCount() {
        // Arrange
        assert(sut.count == 4)

        // Act
        sut.insert(99)

        // Assert
        XCTAssertEqual(5, sut.count, "LRU Cache count should have been increased to 5 but it was not")
    }

    func testLRUCache_WhenInsertingElementAtMaxCapacity_ShouldNotIncreaseCount() {
        // Arrange
        sut.insert(99)
        assert(sut.count == MAX_CAPACITY)

        // Act
        sut.insert(12)

        // Assert
        XCTAssertEqual(5, MAX_CAPACITY, "LRU Cache count should NOT increase beyond max capacity")
    }

    // MARK: - 'contains' property tests
    func testLRUCache_WhenCheckingForValidElement_ShouldUpdatePeekValue() {
        // Arrange
        let oldPeekValue = sut.peek

        // Act
        _ = sut.contains(8)

        // Assert
        XCTAssertNotEqual(8, oldPeekValue, "Peek value should have been updated after calling 'contains()' method but it was not")
    }

    func testLRUCache_WhenCheckingForInvalidElement_ShouldNotUpdatePeekValue() {
        // Arrange
        let oldPeekValue = sut.peek

        // Act
        _ = sut.contains(-8)

        // Assert
        XCTAssertEqual(oldPeekValue, sut.peek, "Peek value should NOT have been updated after checking for invalid item")
    }

    func testLRUCache_WhenCheckingForValidElement_ShouldReturnTrue() {
        // Arrange

        // Act
        let boolean = sut.contains(8)

        // Assert
        XCTAssertTrue(boolean, "Checking valid item should return true but it returned false")
    }

    func testLRUCache_WhenCheckingForInvalidElement_ShouldReturnFalse() {
        // Arrange

        // Act
        let boolean = sut.contains(-8)

        // Assert
        XCTAssertFalse(boolean, "Checking invalid item should return false but it returned true")
    }
}
