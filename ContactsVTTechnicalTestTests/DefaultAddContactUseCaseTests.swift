//
//  DefaultAddContactUseCaseTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DefaultAddContactUseCaseTests: XCTestCase {
    
    enum Error: Swift.Error {
        case anyError
    }
    
    private class ContactDirectoryStoreOperationMock: ContactDirectoryStoreOperation {
        var addedContact: Contact?
        var addCalled = false
        var errorToThrow: Error?
        
        func add(contact: Contact) async throws {
            addCalled = true
            if let errorToThrow {
                throw errorToThrow
            }
            addedContact = contact
        }
    }
    
    private struct Stub {
        static let validContact = Contact(name: try! ContactName(name: "John", lastname: "Doe"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"))
    }
    
    private var sut: DefaultAddContactUseCase!
    private var contactDirectoryStoreOperationMock: ContactDirectoryStoreOperationMock!
    
    override func setUp() {
        super.setUp()
        contactDirectoryStoreOperationMock = ContactDirectoryStoreOperationMock()
        sut = DefaultAddContactUseCase(contactDirectory: contactDirectoryStoreOperationMock)
    }
    
    override func tearDown() {
        sut = nil
        contactDirectoryStoreOperationMock = nil
        super.tearDown()
    }
    
    func test_WHEN_setContact_GIVEN_validContact_THEN_itShouldSetContact() {
        let contact = Stub.validContact
        
        sut.set(param: contact)
        
        XCTAssertEqual(sut.contact, contact, "Should set the contact")
    }
    
    func test_WHEN_execute_GIVEN_validContactDirectoryStoreOperationAndContact_THEN_itShouldHaveTheDirectoryStoreOperationAddTheContact() async {
        sut.set(param: Stub.validContact)
        
        try? await sut.execute()
        
        XCTAssertTrue(contactDirectoryStoreOperationMock.addCalled)
        XCTAssertEqual(contactDirectoryStoreOperationMock.addedContact, Stub.validContact, "Should add the correct contact")
    }
    
    func test_WHEN_execute_GIVEN_noContact_THEN_itShouldThrowMissingContactError() async {
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultAddContactUseCase.Error, DefaultAddContactUseCase.Error.missingContact, "Should throw missingContact error")
        }
    }
    
    func test_WHEN_execute_GIVEN_ContactDirectoryStoreOperationThrowsError_THEN_itShouldThrowDataIntegrityError() async {
        sut.set(param: Stub.validContact)
        contactDirectoryStoreOperationMock.errorToThrow = Error.anyError
        
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultAddContactUseCase.Error, DefaultAddContactUseCase.Error.dataIntegrityError, "Should throw dataIntegrityError error")
        }
    }
}
