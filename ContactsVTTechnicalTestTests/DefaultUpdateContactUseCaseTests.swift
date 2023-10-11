//
//  DefaultUpdateContactUseCaseTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DefaultUpdateContactUseCaseTests: XCTestCase {

    private class ContactDirectoryUpdateOperationMock: ContactDirectoryUpdateOperation {
        var updateCalled = false
        var errorToThrow: Error?

        func update(contact: Contact) async throws {
            updateCalled = true
            if let error = errorToThrow {
                throw error
            }
        }
    }

    private struct Stub {
        static let validContact = Contact(name: try! ContactName(name: "John", lastname: "Doe"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"))
    }

    private var sut: DefaultUpdateContactUseCase!
    private var contactDirectoryUpdateOperationMock: ContactDirectoryUpdateOperationMock!

    override func setUp() {
        super.setUp()
        contactDirectoryUpdateOperationMock = ContactDirectoryUpdateOperationMock()
        sut = DefaultUpdateContactUseCase(contactDirectory: contactDirectoryUpdateOperationMock)
    }

    override func tearDown() {
        sut = nil
        contactDirectoryUpdateOperationMock = nil
        super.tearDown()
    }

    func test_WHEN_execute_GIVEN_ValidContact_THEN_itShouldUpdateContact() async {
        sut.set(param: Stub.validContact)

        try? await sut.execute()

        XCTAssertTrue(contactDirectoryUpdateOperationMock.updateCalled)
    }

    func test_WHEN_execute_GIVEN_MissingContact_THEN_itShouldThrowMissingContactError() async {
        do {
            try await sut.execute()
        } catch {
            XCTAssertFalse(contactDirectoryUpdateOperationMock.updateCalled)
            XCTAssertEqual(error as? DefaultUpdateContactUseCase.Error, DefaultUpdateContactUseCase.Error.missingContact, "Should throw missingContact error")
        }
    }

    func test_WHEN_execute_GIVEN_ContactDirectoryUpdateOperationThrowsError_THEN_itShouldThrowDataIntegrityError() async {
        sut.set(param: Stub.validContact)
        contactDirectoryUpdateOperationMock.errorToThrow = DefaultUpdateContactUseCase.Error.dataIntegrityError

        do {
            try await sut.execute()
        } catch {
            XCTAssertTrue(contactDirectoryUpdateOperationMock.updateCalled)
            XCTAssertEqual(error as? DefaultUpdateContactUseCase.Error, DefaultUpdateContactUseCase.Error.dataIntegrityError, "Should throw dataIntegrityError error")
        }
    }
}
