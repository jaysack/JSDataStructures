// MARK: - Protocol
public protocol BinaryNodeProtocol: TreeNodeProtocol where Element: BinaryNodeProtocol {
    var left: Element? { get set }
    var right: Element? { get set }
}
