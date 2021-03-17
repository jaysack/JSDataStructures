// MARK: - Protocol
public protocol TraversableBinaryNode: BinaryNodeProtocol where Element: TraversableBinaryNode {
    func forEachInOrder(completion: (Element) -> Void)
    func forEachPreOrder(completion: (Element) -> Void)
    func forEachPostOrder(completion: (Element) -> Void)
}

// MARK: - EXT. Default Implementation
public extension TraversableBinaryNode where Self == Element {

    // In-order
    func forEachInOrder(completion: (Element) -> Void) {
        left?.forEachInOrder(completion: completion)
        completion(self)
        right?.forEachInOrder(completion: completion)
    }

    // Pre-order (aka depth first)
    func forEachPreOrder(completion: (Element) -> Void) {
        completion(self)
        children.forEach { $0.forEachPreOrder(completion: completion) }
    }
    
    // Post-order
    func forEachPostOrder(completion: (Element) -> Void) {
        children.forEach { $0.forEachPostOrder(completion: completion) }
        completion(self)
    }
}
