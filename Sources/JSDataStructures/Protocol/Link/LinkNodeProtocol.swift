//
//  LinkNodeProtocol.swift
//  JSDataStructures
//
//  Created by Jonathan Sack.
//  Copyright © Jonathan Sack. All rights reserved.
//

// MARK: - Protocol
public protocol LinkNodeProtocol: AnyObject {

    associatedtype Value
    associatedtype Element: LinkNodeProtocol

    var value: Value { get set }
    var next: Element? { get set }
}
