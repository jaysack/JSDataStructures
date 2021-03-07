
import Foundation

public class TreeNode<T> {
    
    // MARK: - Init
    public init(_ value: T) {
        self.value = value
        self.elements = []
    }
    
    // MARK: - Properties
    public var value: T
    public var isLeaf: Bool { return children.isEmpty }
    public var depth: Int { return getDepth() }
    private var elements: [TreeNode<T>]
    open var children: [TreeNode<T>] { return elements }
    
    // MARK: - Traversal Methods
    // For Each Depth First
    public func forEachDepthFirst(completion: (TreeNode<T>) -> Void) {
        completion(self)
        children.forEach { $0.forEachDepthFirst(completion: completion) }
    }
    
    // For Each Level Order
    public func forEachLevelOrder(completion: (TreeNode<T>) -> Void) {

        var queue = Queue<TreeNode<T>>()
        queue.enqueue(self)
        
        while let node = queue.dequeue() {
            completion(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
    
    // MARK: - Mutation Methods
    // Add
    @discardableResult
    public func insert(_ child: TreeNode<T>) -> Bool {
        elements.append(child)
        return true
    }

    // MARK: - Helper Methods
    // Depth
    private func getDepth() -> Int {
        
        // Leaf case
        guard !isLeaf else { return 1 }
        
        // Default case
        let childrenDepth = children.map { $0.getDepth() }
        return 1 + (childrenDepth.max() ?? 0)
    }
}
