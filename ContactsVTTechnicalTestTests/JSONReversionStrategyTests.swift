//
//  JSONReversionStrategyTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class JSONReversionStrategyTests: XCTestCase {
    
    private struct DummyDecodable: Decodable {
        let name: String
        let age: Int
    }
    
    private struct Stub {
        static let validJSONData = """
        {
            "name": "John Doe",
            "age": 30
        }
        """.data(using: .utf8)!
        static let invalidJSONData = "Invalid JSON Data".data(using: .utf8)!
    }

    private var sut: JSONReversionStrategy!
    
    override func setUp() {
        super.setUp()
        sut = JSONReversionStrategy()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_WHEN_revert_GIVEN_someValidData_THEN_itShouldReturnSomeValidDecodable() {
        let result: DummyDecodable? = sut.revert(Stub.validJSONData)
        XCTAssertNotNil(result, "Decoding valid JSON should result in a non-nil object.")
    }

    func test_WHEN_revert_GIVEN_someInvalidData_THEN_itShouldReturnNil() {
        let result: DummyDecodable? = sut.revert(Stub.invalidJSONData)
        XCTAssertNil(result, "Decoding invalid JSON should result in a nil object.")
    }
}
