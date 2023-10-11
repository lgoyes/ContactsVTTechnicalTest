//
//  ContactDirectoryTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactDirectoryTests: XCTestCase {
    
    private struct Stub {
        static let contact1 = Contact(name: try! ContactName(name: "John", lastname: "Doe"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"))
        static let contact2 = Contact(name: try! ContactName(name: "Jane", lastname: "Smith"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "9876543210"), emailAddress: try! ContactEmailAddress(emailAddress: "jane@example.com"))
    }
    
    private var sut: ContactDirectory!
    
    override func setUp() {
        super.setUp()
        sut = ContactDirectory()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_WHEN_add_GIVEN_contact_THEN_itShouldContainContact() async throws {
        let contact = Stub.contact1
        
        try await sut.add(contact: contact)
        
        XCTAssertTrue(sut.contacts.contains(where: { $0.value == contact }), "Should contain the added contact")
    }
    
    func test_WHEN_remove_GIVEN_existingContact_THEN_itShouldNotContainContact() async throws {
        let contact = Stub.contact1
        try await sut.add(contact: contact)
        
        try await sut.remove(contact: contact)
        
        XCTAssertFalse(sut.contacts.contains(where: { $0.value == contact }), "Should not contain the removed contact")
    }
    
    func test_WHEN_remove_GIVEN_nonExistingContact_THEN_itShouldThrowNonExistingContactError() async throws {
        let contact = Stub.contact1
        
        do {
            try await sut.remove(contact: contact)
        } catch {
            XCTAssertEqual(error as? ContactDirectory.Error, ContactDirectory.Error.nonExistingContact, "Should throw nonExistingContact error")
        }
    }
    
    func test_WHEN_list_GIVEN_contactsExist_THEN_itShouldReturnArrayOfContacts() async throws {
        try? await sut.add(contact: Stub.contact1)
        try? await sut.add(contact: Stub.contact2)
        
        let result = try? await sut.list()
        
        XCTAssertNotNil(result, "Result should not be nil")
        XCTAssertEqual(result?.count, 2, "Should return an array with 2 contacts")
    }
    
    func test_WHEN_update_GIVEN_existingContact_THEN_itShouldContainUpdatedContact() async throws {
        try? await sut.add(contact: Stub.contact1)

        let updatedContact = Contact(name: try! ContactName(name: "Updated", lastname: "Name"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"), id: Stub.contact1.id)
        
        try? await sut.update(contact: updatedContact)
        
        XCTAssertTrue(sut.contacts.contains(where: { $0.value == updatedContact }), "Should contain the updated contact")
    }
}
