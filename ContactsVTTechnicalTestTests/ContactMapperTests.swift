//
//  ContactMapperTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactMapperTests: XCTestCase {
    
    private struct Stub {
        static let validDataContact = DataContact(name: "John", lastname: "Doe", phone: "1234567890", email: "john@example.com", id: UUID())
        static let invalidPhoneDataContact = DataContact(name: "Valid", lastname: "Valid", phone: "invalid-phone", email: "validemail@test.com", id: UUID())
        static let invalidEmailDataContact = DataContact(name: "Valid", lastname: "Valid", phone: "1234567890", email: "validemailtest.com", id: UUID())
        static let invalidNameDataContact = DataContact(name: "Valid Valid Valid", lastname: "Valid", phone: "1234567890", email: "validemailtest.com", id: UUID())
    }
    
    var sut: ContactMapper!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_map_GIVEN_ValidDataContact_THEN_itShouldMapToContact() {
        // Arrange
        sut = ContactMapper(dataContact: Stub.validDataContact)
        
        // Act
        let result = try? sut.map()
        
        // Assert
        XCTAssertNotNil(result, "Result should not be nil")
        XCTAssertEqual(result?.getName(), Stub.validDataContact.name, "Name should match")
        XCTAssertEqual(result?.getLastname(), Stub.validDataContact.lastname, "Lastname should match")
        XCTAssertEqual(result?.getPhoneNumber(), Stub.validDataContact.phone, "Phone number should match")
        XCTAssertEqual(result?.getEmailAddress(), Stub.validDataContact.email, "Email address should match")
        XCTAssertEqual(result?.id, Stub.validDataContact.id, "ID should match")
    }
    
    func test_WHEN_map_GIVEN_invalidPhoneNumber_THEN_itShouldThrowInvalidFormatError() {
        sut = ContactMapper(dataContact: Stub.invalidPhoneDataContact)
        
        XCTAssertThrowsError(try sut.map()) { error in
            XCTAssertEqual(error as? ContactMapper.Error, ContactMapper.Error.invalidFormat("Invalid phone format"), "Should throw invalidFormat error with specific message")
        }
    }
    
    func test_WHEN_map_GIVEN_invalidName_THEN_itShouldThrowInvalidFormatError() {
        sut = ContactMapper(dataContact: Stub.invalidNameDataContact)
        
        XCTAssertThrowsError(try sut.map()) { error in
            XCTAssertEqual(error as? ContactMapper.Error, ContactMapper.Error.invalidFormat("Invalid name format"), "Should throw invalidFormat error with specific message")
        }
    }
    
    func test_WHEN_map_GIVEN_invalidEmail_THEN_itShouldThrowInvalidFormatError() {
        sut = ContactMapper(dataContact: Stub.invalidEmailDataContact)
        
        XCTAssertThrowsError(try sut.map()) { error in
            XCTAssertEqual(error as? ContactMapper.Error, ContactMapper.Error.invalidFormat("Invalid email format"), "Should throw invalidFormat error with specific message")
        }
    }
}
