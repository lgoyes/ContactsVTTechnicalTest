//
//  CSVConversionStrategyTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class CSVConversionStrategyTests: XCTestCase {
    
    private struct DummyEncodable: Encodable {
        let name: String
        let age: Int
    }
    
    private var sut: CSVConversionStrategy!
    
    override func setUp() {
        super.setUp()
        sut = CSVConversionStrategy()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_convert_GIVEN_validEncodableObject_THEN_itShouldReturnCSVData() {
        let dummyObject = DummyEncodable(name: "John Doe", age: 30)
        
        let csvData = sut.convert(dummyObject)
        
        XCTAssertNotNil(csvData, "Should return non-nil CSV data")
    }
    
    func test_WHEN_convert_GIVEN_invalidEncodableObject_THEN_itShouldReturnNil() {
        let invalidObject = DummyEncodable(name: "John Doe", age: 30)
        
        let csvData = sut.convert([invalidObject])
        
        XCTAssertNil(csvData, "Should return nil for invalid Encodable object")
    }
}
