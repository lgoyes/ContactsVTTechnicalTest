//
//  DefaultRemoveContactUseCaseTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DefaultRemoveContactUseCaseTests: XCTestCase {
        
    private class MockContactDirectoryRemoveOperation: ContactDirectoryRemoveOperation {
        var removeWasCalled = false
        var removedContact: Contact?
        var errorToThrow: Error?
        
        func remove(contact: Contact) async throws {
            removedContact = contact
            removeWasCalled = true
            if let errorToThrow {
                throw errorToThrow
            }
        }
    }
    
    private enum Error: Swift.Error {
        case anyError
    }
    
    private var sut: DefaultRemoveContactUseCase!
    private var contactDirectory: MockContactDirectoryRemoveOperation!
    
    override func setUp() {
        super.setUp()
        contactDirectory = MockContactDirectoryRemoveOperation()
        sut = DefaultRemoveContactUseCase(contactDirectory: contactDirectory)
    }
    
    override func tearDown() {
        sut = nil
        contactDirectory = nil
        super.tearDown()
    }
    
    func test_WHEN_execute_GIVEN_someContactProvided_THEN_itShouldCallRemoveInContactDirectory() async throws {
        let name = try! ContactName(name: "Jhon", lastname: "Doe")
        let phoneNumber = try! ContactPhoneNumber(phoneNumber: "0123456789")
        let emailAddress = try! ContactEmailAddress(emailAddress: "test@test.com")
        let contact = Contact(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress)
        
        sut.set(param: contact)
        try await sut.execute()
        
        XCTAssertTrue(contactDirectory.removeWasCalled, "remove(contact:) should be called")
        let contactDirectoryContactMatchesInput = contactDirectory.removedContact == contact
        XCTAssert(contactDirectoryContactMatchesInput, "The provided contact should be passed to the remove method")
    }
    
    func test_WHEN_execute_GIVEN_contactNotProvided_THEN_itShouldThrowMissingContactError() async {
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultRemoveContactUseCase.Error, DefaultRemoveContactUseCase.Error.missingContact, "Should throw missingContact error")
        }
        XCTAssertFalse(contactDirectory.removeWasCalled, "remove(contact:) should not be called")
    }

    func test_WHEN_execute_GIVEN_contactDirectoryThrowsAnyError_THEN_itShouldThrowDataIntegrityError() async {
        contactDirectory.errorToThrow = Error.anyError
        
        let name = try! ContactName(name: "Jhon", lastname: "Doe")
        let phoneNumber = try! ContactPhoneNumber(phoneNumber: "0123456789")
        let emailAddress = try! ContactEmailAddress(emailAddress: "test@test.com")
        let contact = Contact(name: name, phoneNumber: phoneNumber, emailAddress: emailAddress)

        sut.set(param: contact)
        
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultRemoveContactUseCase.Error, DefaultRemoveContactUseCase.Error.dataIntegrityError, "Should throw dataIntegrityError error")
        }
        
        XCTAssertTrue(contactDirectory.removeWasCalled, "remove(contact:) should be called")
        XCTAssertEqual(contactDirectory.removedContact, contact, "The provided contact should be passed to the remove method")
    }
}
