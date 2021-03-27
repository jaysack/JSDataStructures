
import XCTest
@testable import JSDataStructures

class QueueTests: XCTestCase {

    // mock: Andre <- Kate <- Bob <- Tajea
    var sut: Queue<String>!

    override func setUpWithError() throws {
        sut = Queue<String>()
        sut.enqueue("Andre")
        sut.enqueue("Kate")
        sut.enqueue("Bob")
        sut.enqueue("Tajea")
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testQueue_WhenEnqueuingItem_CountShouldIncrease() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut.enqueue("Kim")
        
        // Assert
        XCTAssertEqual(5, sut.count, "List count should have been increased to 5 but it was not")
    }
    
    func testQueue_WhenDequeuingItem_CountShouldDecrease() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        sut.dequeue()
        
        // Assert
        XCTAssertEqual(3, sut.count, "List count should have been decreased to 3 but it was not")
    }

    func testQueue_WhenDequeuing_ShouldReturnFirstItem() {
        // Arrange
        assert(sut.count == 4)
        
        // Act
        let person = sut.dequeue()
        
        // Assert
        XCTAssertEqual(person, "Andre", "Andre should have been dequeued but he was not")
    }

    func testQueue_BecauseOfSequenceProtocol_ShouldBeTraversableInReverseWithAForInLoop() {
        // Arrange
        var reversedLoopResult: [String] = []
        
        // Act
        for element in sut {
            reversedLoopResult.append(element)
        }
        
        // Assert
        XCTAssertEqual(reversedLoopResult.reversed(), sut.elements, "For loop should traverse the array in order but it did not")
    }
}
