//
//  ContactNameTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactNameTests: XCTestCase {
    
    private var sut: ContactName!
    
    override func setUp() {
        super.setUp()
        sut = try! ContactName(name: "John", lastname: "Doe")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getFullname_THEN_itShouldReturnFullname() {
        let fullname = sut.getFullname()
        
        XCTAssertEqual(fullname, "John Doe", "Should return the full name")
    }
    
    func test_WHEN_getName_THEN_itShouldReturnFirstName() {
        let name = sut.getName()
        
        XCTAssertEqual(name, "John", "Should return the first name")
    }
    
    func test_WHEN_getLastname_THEN_itShouldReturnLastname() {
        let lastname = sut.getLastname()
        
        XCTAssertEqual(lastname, "Doe", "Should return the last name")
    }
    
    func test_WHEN_init_GIVEN_NameExceedsMaxLength_THEN_itShouldThrowMaxLengthExceededError() {
        let longName = String(repeating: "A", count: ContactName.Constant.maxLength + 1)
        
        XCTAssertThrowsError(try ContactName(name: longName, lastname: "Doe")) { error in
            XCTAssertEqual(error as? ContactName.Error, ContactName.Error.maxLengthExceeded, "Should throw maxLengthExceeded error")
        }
    }
    
    func test_WHEN_init_GIVEN_LastnameExceedsMaxLength_THEN_itShouldThrowMaxLengthExceededError() {
        let longLastname = String(repeating: "B", count: ContactName.Constant.maxLength + 1)
        
        XCTAssertThrowsError(try ContactName(name: "John", lastname: longLastname)) { error in
            XCTAssertEqual(error as? ContactName.Error, ContactName.Error.maxLengthExceeded, "Should throw maxLengthExceeded error")
        }
    }
}
