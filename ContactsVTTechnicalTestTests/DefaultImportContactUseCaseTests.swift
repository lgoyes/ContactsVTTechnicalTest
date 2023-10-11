//
//  DefaultImportContactUseCaseTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class DefaultImportContactUseCaseTests: XCTestCase {
    
    private class DataReversionStrategyMock: DataReversionStrategy {
        var output: Decodable?
        var revertCalled = false
        
        func revert<T>(_ data: Data) -> T? where T : Decodable {
            revertCalled = true
            return output as? T
        }
    }
    
    private struct Stub {
        static let validData = Data()
        static let invalidData = Data()
        static let contact = DataContact(name: "Luis", lastname: "Goyes", phone: "0123456789", email: "any@test.com", id: UUID())
    }
    
    private var sut: DefaultImportContactUseCase!
    private var dataReversionStrategyMock: DataReversionStrategyMock!
    
    override func setUp() {
        super.setUp()
        dataReversionStrategyMock = DataReversionStrategyMock()
        sut = DefaultImportContactUseCase(dataReversionStrategy: dataReversionStrategyMock)
    }
    
    override func tearDown() {
        sut = nil
        dataReversionStrategyMock = nil
        super.tearDown()
    }
    
    func test_WHEN_setReversionType_GIVEN_validReversionType_THEN_itShouldSetReversionType() {
        let reversionType: ReversionType = .json
        
        sut.set(reversionType: reversionType)
        
        XCTAssertEqual(sut.reversionType, reversionType, "Should set the reversion type")
    }
    
    func test_WHEN_setData_GIVEN_validData_THEN_itShouldSetData() {
        let data = Stub.validData
        
        sut.set(data: data)
        
        XCTAssertEqual(sut.data, data, "Should set the data")
    }
    
    func test_WHEN_execute_GIVEN_validDataReversionStrategyAndData_THEN_itShouldHaveTheReversionStrategyRevertTheData() async {
        sut.set(reversionType: .json)
        sut.set(data: Stub.validData)
        
        dataReversionStrategyMock.output = Stub.contact
        
        try? await sut.execute()
        
        XCTAssertTrue(dataReversionStrategyMock.revertCalled)
        XCTAssertNotNil(try! sut.getOutput(), "Should set the contact")
    }
    
    func test_WHEN_getOutput_GIVEN_useCaseNotYetExecuted_THEN_itShouldThrowNotYetExecutedError() {
        XCTAssertThrowsError(try sut.getOutput()) { error in
            XCTAssertEqual(error as? DefaultImportContactUseCase.Error, DefaultImportContactUseCase.Error.notYetExecuted, "Should throw notYetExecuted error")
        }
    }
    
    func test_WHEN_execute_GIVEN_MissingData_THEN_itShouldThrowMissingDataError() async {
        sut.set(reversionType: .json)
        
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultImportContactUseCase.Error, DefaultImportContactUseCase.Error.missingData, "Should throw missingData error")
        }
    }
    
    func test_WHEN_execute_GIVEN_someDataThatCannotBeDecodedAsDataContact_THEN_itShouldThrowDataIntegrityError() async {
        sut.set(reversionType: .json)
        sut.set(data: Stub.invalidData)
        dataReversionStrategyMock.output = nil
        
        do {
            try await sut.execute()
        } catch {
            XCTAssertEqual(error as? DefaultImportContactUseCase.Error, DefaultImportContactUseCase.Error.dataIntegrityError, "Should throw dataIntegrityError error")
        }
    }
}
