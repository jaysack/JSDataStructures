// MARK: - Protocol
public protocol TraversableTreeNode: TreeNodeProtocol where Element: TraversableTreeNode {
    func forEachDepthFirst(completion: (Element) -> Void)
    func forEachLevelOrder(completion: (Element) -> Void)
}

// MARK: - EXT. Traversal Methods
public extension TraversableTreeNode where Self == Element {

    // For Each Depth First (aka pre-order)
    func forEachDepthFirst(completion: (Element) -> Void) {
        completion(self)
        children.forEach { $0.forEachDepthFirst(completion: completion) }
    }

    // For Each Level Order
    func forEachLevelOrder(completion: (Element) -> Void) {

        var queue = Queue<Element>()
        queue.enqueue(self)

        while let node = queue.dequeue() {
            completion(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}
