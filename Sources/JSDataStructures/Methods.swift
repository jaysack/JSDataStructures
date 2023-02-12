//
//  Methods.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

import Foundation

public func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    
    func merge<U: Comparable>(_ left: [U], _ right: [U]) -> [U] {

        var result: [U] = []
        var leftIndex: Int = 0
        var rightIndex: Int = 0

        while leftIndex < left.count && rightIndex < right.count {
            
            let leftElement = left[leftIndex]
            let rightElement = right[rightIndex]

            if leftElement < rightElement {
                result.append(leftElement)
                leftIndex += 1

            } else if leftElement > rightElement {
                result.append(rightElement)
                rightIndex += 1

            } else {
                result.append(leftElement)
                leftIndex += 1
                result.append(rightElement)
                rightIndex += 1
            }
        }
        
        if leftIndex < left.count {
            result.append(contentsOf: left[leftIndex...])
        }

        if rightIndex < right.count {
            result.append(contentsOf: right[rightIndex...])
        }

        // Return
        return result
    }
    // Guard against not enough items
    guard array.count > 1 else { return array }

    // Get middle
    let middleIndex = array.count / 2
    
    // Sort each side
    let left = mergeSort(Array(array[..<middleIndex]))
    let right = mergeSort(Array(array[middleIndex...]))

    // Return sorted array
    return merge(left, right)
}
