//
//  JSONConversionStrategyTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class JSONConversionStrategyTests: XCTestCase {
    
    private struct Stub: Encodable {
        let name: String
        let age: Int
    }
    
    private var sut: JSONConversionStrategy!
    
    override func setUp() {
        super.setUp()
        sut = JSONConversionStrategy()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testConvert_GivenValidObject_ItShouldReturnJSONData() {
        let object = Stub(name: "John Doe", age: 30)
        
        let jsonData = sut.convert(object)
        
        XCTAssertNotNil(jsonData, "JSON data should not be nil")
    }
}
