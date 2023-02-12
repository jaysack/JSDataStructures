//
//  StackTests.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import XCTest
@testable import JSDataStructures

class StackTests: XCTestCase {

    var sut: Stack<Int>!

    override func setUpWithError() throws {
        sut = Stack<Int>()
        sut.push(4)
        sut.push(8)
        sut.push(9)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStack_whenPushingAnElement_ShouldUpdatePeek() {
        // Arrange
        assert(sut.peek != 5)
        
        // Act
        sut.push(5)
        
        // Assert
        XCTAssertEqual(5, sut.peek, "Popped item should have been 9 but it is not")
    }

    func testStack_whenPoppingValue_ShouldReturnLastItem() {
        // Arrange
        assert(sut.count == 3)
        
        // Act
        let item = sut.pop()
        
        // Assert
        XCTAssertEqual(item, 9, "Popped item should have been 9 but it is not")
    }

    func testStack_whenPoppingValueOnEmptyStack_ShouldReturnNil() {
        // Arrange
        sut = Stack<Int>()
        
        // Act
        let item = sut.pop()
        
        // Assert
        XCTAssertNil(item, "Return item should be nil but it is not")
    }

    func testStack_WhenPoppingElement_CountShouldDecrease() {
        // Arrange
        assert(sut.count == 3)
        
        // Act
        sut.pop()
        
        // Assert
        XCTAssertEqual(2, sut.count, "Stack count should have been decrease to 2 after popping an element")
    }

    func testStack_GivenAnEmptyStackWhenPoppingElement_CountShouldNotDecrease() {
        // Arrange
        sut = Stack<Int>()
        assert(sut.count == 0)
        
        // Act
        sut.pop()
        
        // Assert
        XCTAssertEqual(0, sut.count, "Stack count should have NOT been decrease when popping an element in an empty stack")
    }
    
    func testStack_WhenPushingElement_CountShouldIncrease() {
        // Arrange
        assert(sut.count == 3)
        
        // Act
        sut.push(99)
        
        // Assert
        XCTAssertEqual(4, sut.count, "Stack count should have been increased to 4 after pushing element but it was not")
    }

    func testStack_BecauseOfSequenceProtocol_ShouldBeTraversableInReverseWithAForInLoop() {
        // Arrange
        var reversedLoopResult: [Int] = []
        
        // Act
        for element in sut {
            reversedLoopResult.append(element)
        }
        
        // Assert
        XCTAssertEqual(reversedLoopResult.reversed(), sut.elements, "For loop should traverse the sequence in reversed order but it did not")
    }

    func testStack_BecauseOfArrayLiteralProtocol_ShouldBeInitiableUsingAnArray() {
        // Arrange
        // ...
        
        // Act
        sut = [4, 8, 9]
        
        // Assert
        XCTAssertEqual([4, 8, 9], sut.elements.reversed(), "Elements should be initiated from array literal but it did not work")
    }

    func testStack_BecauseOfArrayLiteralProtocol_ShouldPlaceArrayFirstElementOnTop() {
        // Arrange
        // ...
        
        // Act
        sut = [4, 8, 9]
        
        // Assert
        XCTAssertEqual(4, sut.peek, "Peek should be 4 but it is not")
    }
}
