
import Foundation

public class BSTNode<T>: TreeNode<T> {

    // MARK: - Init
    public override init(_ value: T) {
        super.init(value)
    }

    // MARK: - Properties
    public var left: BSTNode<T>?
    public var right: BSTNode<T>?
    override public var children: [TreeNode<T>] { return [left, right].compactMap { $0 } }
    
    // MARK: - Traversal Methods
    // In order
    public func forEachInOrder(completion: (TreeNode<T>) -> Void) {
        left?.forEachInOrder(completion: completion)
        completion(self)
        right?.forEachInOrder(completion: completion)
    }

    // Pre order
    public func forEachPreOrder(completion: (TreeNode<T>) -> Void) {
        self.forEachDepthFirst(completion: completion)
    }
    
    // Post order
    public func forEachPostOrder(completion: (TreeNode<T>) -> Void) {
        [left, right].forEach { $0?.forEachPostOrder(completion: completion) }
        completion(self)
    }
}

// MARK: - EXT. Custom String Convertible
extension BSTNode: CustomStringConvertible {

    public var description: String { return diagram(for: self) }
  
    private func diagram(for node: BSTNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {

        guard let node = node else { return root + "nil\n" }
        
        if node.left == nil && node.right == nil {
            return root + "\(node.value)\n"
        }

        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
            + root
            + "\(node.value)\n"
            + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
  }
}
