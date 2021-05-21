//
//  BinaryNodeProtocol.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

// MARK: - Protocol
public protocol BinaryNodeProtocol: TreeNodeProtocol where Element: BinaryNodeProtocol {
    var left: Element? { get set }
    var right: Element? { get set }
}
