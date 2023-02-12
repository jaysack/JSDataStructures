//
//  MethodsTests.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import XCTest
@testable import JSDataStructures

final class MethodsTests: XCTestCase {

    func testMergeSort() {
        // Arrange
        let integers: [Int] = [19, 20, 15, 14]
        let characters: [Character] = ["d", "a", "c", "b"]
        
        // Act
        let sortedIntegers: [Int] = mergeSort(integers)
        let sortedCharacters: [Character] = mergeSort(characters)
        
        // Assert
        XCTAssertEqual(sortedIntegers, [14, 15, 19, 20], "Merge sort should sort the array in order")
        XCTAssertEqual(sortedCharacters, ["a", "b", "c", "d"], "Merge sort should sort the array in order")
    }
}
