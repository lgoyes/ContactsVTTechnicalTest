//
//  ContactEmailAddressTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactEmailAddressTests: XCTestCase {

    func test_WHEN_init_GIVEN_ValidEmailAddress_THEN_itShouldNotThrowError() {
        let validEmailAddress = "john@example.com"
        
        XCTAssertNoThrow(try ContactEmailAddress(emailAddress: validEmailAddress), "Should not throw an error for a valid email address")
    }
    
    func test_WHEN_init_GIVEN_InvalidFormatEmailAddress_THEN_itShouldThrowInvalidFormatError() {
        let invalidEmailAddress = "invalid_email"
        
        XCTAssertThrowsError(try ContactEmailAddress(emailAddress: invalidEmailAddress)) { error in
            XCTAssertEqual(error as? ContactEmailAddress.Error, ContactEmailAddress.Error.invalidFormat, "Should throw invalidFormat error for an invalid email address format")
        }
    }
    
    func test_WHEN_getEmailAddress_THEN_itShouldReturnEmailAddress() {
        let emailAddress = "john@example.com"
        let sut = try! ContactEmailAddress(emailAddress: emailAddress)
        
        let result = sut.getEmailAddress()
        
        XCTAssertEqual(result, emailAddress, "Should return the email address")
    }
}
