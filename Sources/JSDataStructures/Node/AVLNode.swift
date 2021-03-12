
import Foundation

final public class AVLNode<T>: BSTNode<T> {

    // MARK: - Init
    public override init(_ value: T) {
        super.init(value)
    }

    // MARK: - Properties
    public var isBalanced: Bool { return abs(balance) < 2 }
    public var balance: Int { return (right?.depth ?? 0) - (left?.depth ?? 0) }

    // MARK: - Methods
    // ⬅️
    public func rotateLeft<T>() -> BSTNode<T>? {
        
        // Select pivot
        guard let pivot = self.right else { return nil }
        
        // Adopt pivot's opposite child
        self.right = pivot.left
        
        // Use pivot's rotation side to add self
        pivot.left = self
        
        // Return pivot
        return pivot as? BSTNode<T>
    }

    // ➡️
    public func rotateRight<T>() -> BSTNode<T>? {
        
        // Select pivot
        guard let pivot = self.left else { return nil }
        
        // Adopt pivot's opposite child
        self.left = pivot.right
        
        // Use pivot's rotation side to add self
        pivot.right = self
        
        // Return pivot
        return pivot as? BSTNode<T>
    }
    
    // ⬅️ ➡️
    public func rotateLeftRight<T>() -> BSTNode<T>? {
        
        // Unwrap
        guard let BSTSelf = self as? BSTNode<T> else { return nil }
        guard let leftChild = left as? AVLNode<T> else { return BSTSelf }
        
        // Rotations
        left = leftChild.rotateLeft()
        return self.rotateRight()
    }
    
    // ➡️ ⬅️
    public func rotateRightLeft<T>() -> BSTNode<T>? {

        // Unwrap
        guard let BSTSelf = self as? BSTNode<T> else { return nil }
        guard let rightChild = right as? AVLNode<T> else { return BSTSelf }

        // Rotations
        right = rightChild.rotateRight()
        return self.rotateLeft()
    }
}
