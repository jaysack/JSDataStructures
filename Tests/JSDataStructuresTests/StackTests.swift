
import XCTest
@testable import JSDataStructures

class StackTests: XCTestCase {

    var sut: Stack<Int>?

    override func setUpWithError() throws {
        sut = Stack<Int>()
        sut?.push(4)
        sut?.push(8)
        sut?.push(9)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStack_whenPoppingValue_ShouldReturnLastItem() {
        // Arrange
        assert(sut?.count == 3)
        
        // Act
        let item = sut?.pop()
        
        // Assert
        XCTAssertEqual(item, 9, "Popped item should have been 9 but it is not")
    }

    func testStack_whenPoppingValueOnEmptyStack_ShouldReturnNil() {
        // Arrange
        sut = Stack<Int>()
        
        // Act
        let item = sut?.pop()
        
        // Assert
        XCTAssertNil(item, "Return item should be nil but it is not")
    }
}
