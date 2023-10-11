//
//  ContactTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactTests: XCTestCase {
    
    private struct Stub {
        static let name = try! ContactName(name: "John", lastname: "Doe")
        static let phoneNumber = try! ContactPhoneNumber(phoneNumber: "1234567890")
        static let emailAddress = try! ContactEmailAddress(emailAddress: "john@example.com")
    }
    
    private var sut: Contact!
    
    override func setUp() {
        super.setUp()
        sut = Contact(name: Stub.name, phoneNumber: Stub.phoneNumber, emailAddress: Stub.emailAddress)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_getFullname_THEN_itShouldReturnFullname() {
        let fullname = sut.getFullname()
        
        XCTAssertEqual(fullname, "John Doe", "Should return the full name")
    }
    
    func test_WHEN_getPhoneNumber_THEN_itShouldReturnPhoneNumber() {
        let phoneNumber = sut.getPhoneNumber()
        
        XCTAssertEqual(phoneNumber, "1234567890", "Should return the phone number")
    }
    
    func test_WHEN_getEmailAddress_THEN_itShouldReturnEmailAddress() {
        let emailAddress = sut.getEmailAddress()
        
        XCTAssertEqual(emailAddress, "john@example.com", "Should return the email address")
    }
    
    func test_WHEN_getName_THEN_itShouldReturnFirstName() {
        let name = sut.getName()
        
        XCTAssertEqual(name, "John", "Should return the first name")
    }
    
    func test_WHEN_getLastname_THEN_itShouldReturnLastname() {
        let lastname = sut.getLastname()
        
        XCTAssertEqual(lastname, "Doe", "Should return the last name")
    }
}
