//
//  DataReversionStrategyFactoryTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DataReversionStrategyFactoryTests: XCTestCase {
    
    private var sut: DataReversionStrategyFactory!
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getReversionStrategy_GIVEN_csvTypeSelected_THEN_itShouldReturnCSVReversionStrategy() {
        sut = DataReversionStrategyFactory(reversionType: .csv)
        
        let strategy = sut.getReversionStrategy()
        
        XCTAssertTrue(strategy is CSVReversionStrategy, "Should return a CSVReversionStrategy instance")
    }
    
    func test_WHEN_getReversionStrategy_GIVEN_jsonTypeSelected_THEN_itShouldReturnJSONReversionStrategy() {
        sut = DataReversionStrategyFactory(reversionType: .json)
        
        let strategy = sut.getReversionStrategy()
        
        XCTAssertTrue(strategy is JSONReversionStrategy, "Should return a JSONReversionStrategy instance")
    }
}
