//
//  ContactPhoneNumberTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactPhoneNumberTests: XCTestCase {
    
    func test_WHEN_init_GIVEN_ValidPhoneNumber_THEN_itShouldNotThrowError() {
        let validPhoneNumber = "1234567890"
        
        XCTAssertNoThrow(try ContactPhoneNumber(phoneNumber: validPhoneNumber), "Should not throw an error for a valid phone number")
    }
    
    func test_WHEN_init_GIVEN_InvalidLengthPhoneNumber_THEN_itShouldThrowInvalidLengthError() {
        let invalidPhoneNumber = "12345"
        
        XCTAssertThrowsError(try ContactPhoneNumber(phoneNumber: invalidPhoneNumber)) { error in
            XCTAssertEqual(error as? ContactPhoneNumber.Error, ContactPhoneNumber.Error.invalidLength, "Should throw invalidLength error for an invalid length phone number")
        }
    }
    
    func test_WHEN_init_GIVEN_InvalidFormatPhoneNumber_THEN_itShouldThrowUnexpectedFormatError() {
        let invalidPhoneNumber = "1234abc567"
        
        XCTAssertThrowsError(try ContactPhoneNumber(phoneNumber: invalidPhoneNumber)) { error in
            XCTAssertEqual(error as? ContactPhoneNumber.Error, ContactPhoneNumber.Error.unexpectedFormat, "Should throw unexpectedFormat error for an invalid format phone number")
        }
    }
    
    func test_WHEN_getPhoneNumber_THEN_itShouldReturnPhoneNumber() {
        let phoneNumber = "1234567890"
        let sut = try! ContactPhoneNumber(phoneNumber: phoneNumber)
        
        let result = sut.getPhoneNumber()
        
        XCTAssertEqual(result, phoneNumber, "Should return the phone number")
    }
}
