//
//  DataConversionStrategyFactoryTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DataConversionStrategyFactoryTests: XCTestCase {
    
    private var sut: DataConversionStrategyFactory!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getConversionStrategy_GIVEN_CSVTypeSelected_THEN_itShouldReturnCSVConversionStrategy() {
        sut = DataConversionStrategyFactory(conversionType: .csv)
        
        let strategy = sut.getConversionStrategy()
        
        XCTAssertTrue(strategy is CSVConversionStrategy, "Should return a CSVConversionStrategy instance")
    }
    
    func test_WHEN_getConversionStrategy_GIVEN_JSONTypeSelected_THEN_itShouldReturnJSONConversionStrategy() {
        sut = DataConversionStrategyFactory(conversionType: .json)
        
        let strategy = sut.getConversionStrategy()
        
        XCTAssertTrue(strategy is JSONConversionStrategy, "Should return a JSONConversionStrategy instance")
    }
    
}
