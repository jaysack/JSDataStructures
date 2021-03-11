
import Foundation

final public class AVLNode<T>: BSTNode<T> {

    // MARK: - Init
    public override init(_ value: T) {
        super.init(value)
    }

    // MARK: - Properties
    public var isBalanced: Bool { return abs(balance) < 2 }
    public var balance: Int { return (right?.depth ?? 0) - (left?.depth ?? 0) }
}
