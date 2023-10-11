//
//  DefaultExportContactUseCaseTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DefaultExportContactUseCaseTests: XCTestCase {
    
    private class DataConversionStrategyMock: DataConversionStrategy {
        
        var output: Data?
        var convertCalled = false
        
        func convert<T>(_ object: T) -> Data? where T : Encodable {
            convertCalled = true
            return output
        }
    }
    
    private struct Stub {
        static let validContact = Contact(name: try! ContactName(name: "John", lastname: "Doe"), phoneNumber: try! ContactPhoneNumber(phoneNumber: "1234567890"), emailAddress: try! ContactEmailAddress(emailAddress: "john@example.com"))
    }
    
    private var sut: DefaultExportContactUseCase!
    private var dataConversionStrategyMock: DataConversionStrategyMock!
    
    override func setUp() {
        super.setUp()
        dataConversionStrategyMock = DataConversionStrategyMock()
        sut = DefaultExportContactUseCase(dataConversionStrategy: dataConversionStrategyMock)
    }
    
    override func tearDown() {
        sut = nil
        dataConversionStrategyMock = nil
        super.tearDown()
    }
    
    func test_WHEN_setConversionType_GIVEN_validConversionType_THEN_itShouldSetConversionType() {
        let conversionType: ConversionType = .json
        
        sut.set(conversionType: conversionType)
        
        XCTAssertEqual(sut.conversionType, conversionType, "Should set the conversion type")
    }
    
    func test_WHEN_setContact_GIVEN_validContact_THEN_itShouldSetContact() {
        let contact = Stub.validContact
        
        sut.set(contact: contact)
        
        XCTAssertEqual(sut.contact, contact, "Should set the contact")
    }
    
    func test_WHEN_execute_GIVEN_validDataConversionStrategyAndContact_THEN_itShouldHaveTheConversionStrategyConvertTheData() async {
        sut.set(conversionType: .json)
        sut.set(contact: Stub.validContact)
        
        dataConversionStrategyMock.output = Data()
        
        try? await sut.execute()
        
        XCTAssertTrue(dataConversionStrategyMock.convertCalled)
        XCTAssertNotNil(try! sut.getOutput(), "Should set the data")
    }
    
    func test_WHEN_getOutput_GIVEN_useCaseNotYetExecuted_THEN_itShouldThrowNotYetExecutedError() {
        XCTAssertThrowsError(try sut.getOutput()) { error in
            XCTAssertEqual(error as? DefaultExportContactUseCase.Error, DefaultExportContactUseCase.Error.notYetExecuted, "Should throw notYetExecuted error")
        }
    }
    
    func test_WHEN_execute_GIVEN_noContact_THEN_itShouldThrowMissingContactError() async {
        sut.set(conversionType: .json)
        
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultExportContactUseCase.Error, DefaultExportContactUseCase.Error.missingContact, "Should throw missingContact error")
        }
    }
}
