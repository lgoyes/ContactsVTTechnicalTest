//
//  CSVReversionStrategyTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class CSVReversionStrategyTests: XCTestCase {
    
    private struct DummyDecodable: Decodable, Equatable {
        let name: String
        let age: Int
    }
    
    private struct Stub {
        static let validJSONData = """
        name,age
        John Doe,30
        """.data(using: .utf8)!
        static let invalidCSVData = "Invalid CSV Data".data(using: .utf8)!
    }
    
    private var sut: CSVReversionStrategy!
    
    override func setUp() {
        super.setUp()
        sut = CSVReversionStrategy()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_revert_GIVEN_someValidData_someReturnTypeAsArray_THEN_itShouldReturnSomeValidDecodable() {
        let result: DummyDecodable? = sut.revert(Stub.validJSONData)
        XCTAssertNotNil(result, "Decoding valid CSV should result in a non-nil object.")
    }
    
    func test_WHEN_revert_GIVEN_someInvalidData_someReturnTypeAsArray_THEN_itShouldReturnNil() {
        let result: DummyDecodable? = sut.revert(Stub.invalidCSVData)
        XCTAssertNil(result, "Decoding invalid CSV should result in a nil object.")
    }
}
