//
//  DefaultListContactsUseCaseTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DefaultListContactsUseCaseTests: XCTestCase {

    private class ContactDirectoryListOperationMock: ContactDirectoryListOperation {
        var listCalled = false
        var resultToReturn: [Contact] = []
        var errorToThrow: Error?

        func list() async throws -> [Contact] {
            listCalled = true
            if let error = errorToThrow {
                throw error
            }
            return resultToReturn
        }
    }

    private struct Stub {
        static let contact1 = Contact(name: try! ContactName(name: "John", lastname: "Doe"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"))
        static let contact2 = Contact(name: try! ContactName(name: "Jane", lastname: "Smith"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "9876543210"), emailAddress: try! ContactEmailAddress(emailAddress: "jane@example.com"))

        static let validContacts: [Contact] = [contact1, contact2]
    }

    private var sut: DefaultListContactsUseCase!
    private var contactDirectoryListOperationMock: ContactDirectoryListOperationMock!

    override func setUp() {
        super.setUp()
        contactDirectoryListOperationMock = ContactDirectoryListOperationMock()
        sut = DefaultListContactsUseCase(contactDirectory: contactDirectoryListOperationMock)
    }

    override func tearDown() {
        sut = nil
        contactDirectoryListOperationMock = nil
        super.tearDown()
    }

    func test_WHEN_execute_GIVEN_ContactDirectoryListOperationReturnsValidContacts_THEN_itShouldReturnValidContacts() async {
        contactDirectoryListOperationMock.resultToReturn = Stub.validContacts

        try? await sut.execute()
        let result = sut.getData()

        XCTAssertTrue(contactDirectoryListOperationMock.listCalled)
        XCTAssertEqual(result, Stub.validContacts, "Should return valid contacts")
    }

    func test_WHEN_execute_GIVEN_ContactDirectoryListOperationThrowsError_THEN_itShouldThrowDataIntegrityError() async {
        contactDirectoryListOperationMock.errorToThrow = DefaultListContactsUseCase.Error.dataIntegrityError

        do {
            try await sut.execute()
        } catch {
            XCTAssertTrue(contactDirectoryListOperationMock.listCalled)
            XCTAssertEqual(error as? DefaultListContactsUseCase.Error, DefaultListContactsUseCase.Error.dataIntegrityError, "Should throw dataIntegrityError error")
        }
    }
}
