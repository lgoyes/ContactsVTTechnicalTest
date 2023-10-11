//
//  ContactDirectoryDelayedDecoratorTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ContactDirectoryDelayedDecoratorTests: XCTestCase {
    
    private class ContactDirectoryMock: ContactDirectoryProtocol {
        var addCalled = false
        var removeCalled = false
        var listCalled = false
        var updateCalled = false
        var contacts = [Contact]()
        
        func add(contact: Contact) async throws {
            addCalled = true
        }
        
        func remove(contact: Contact) async throws {
            removeCalled = true
        }
        
        func list() async throws -> [Contact] {
            listCalled = true
            return contacts
        }
        
        func update(contact: Contact) async throws {
            updateCalled = true
        }
    }
    
    private struct Stub {
        static let contact1 = Contact(name: try! ContactName(name: "John", lastname: "Doe"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"))
        static let contact2 = Contact(name: try! ContactName(name: "Jane", lastname: "Smith"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "9876543210"), emailAddress: try! ContactEmailAddress(emailAddress: "jane@example.com"))
    }
    
    private var sut: ContactDirectoryDelayedDecorator!
    private var decoratedDirectory: ContactDirectoryMock!
    
    override func setUp() {
        super.setUp()
        decoratedDirectory = ContactDirectoryMock()
        sut = ContactDirectoryDelayedDecorator(decoratedDirectory: decoratedDirectory)
    }
    
    override func tearDown() {
        sut = nil
        decoratedDirectory = nil
        super.tearDown()
    }
    
    func test_WHEN_add_GIVEN_contact_THEN_itShouldContainContact() async throws {
        let contact = Stub.contact1
        
        try await sut.add(contact: contact)
        
        XCTAssertTrue(decoratedDirectory.addCalled, "Should invoke add on mock")
    }
    
    func test_WHEN_remove_GIVEN_contact_THEN_itShouldNotContainContact() async throws {
        let contact = Stub.contact1
        try await sut.add(contact: contact)
        
        try await sut.remove(contact: contact)
        
        XCTAssertTrue(decoratedDirectory.removeCalled, "Should invoke remove on mock")
    }
    
    func test_WHEN_list_GIVEN_contactsExist_THEN_itShouldReturnArrayOfContacts() async throws {
        let _ = try? await sut.list()
        
        XCTAssertTrue(decoratedDirectory.listCalled, "Should invoke list on mock")
    }
    
    func test_WHEN_update_GIVEN_existingContact_THEN_itShouldContainUpdatedContact() async throws {
        let contact = Stub.contact1
        try? await sut.update(contact: contact)
        
        XCTAssertTrue(decoratedDirectory.updateCalled, "Should invoke update on mock")
    }
}
