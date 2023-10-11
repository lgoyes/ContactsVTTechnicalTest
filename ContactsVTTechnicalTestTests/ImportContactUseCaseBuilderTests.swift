//
//  ImportContactUseCaseBuilderTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ImportContactUseCaseBuilderTests: XCTestCase {
    func test_WHEN_build_GIVEN_validDependencyContainer_THEN_itShouldReturnValidImportContactUseCase() {
        let useCase = ImportContactUseCaseBuilder.build(reversionType: .csv)
        
        XCTAssertTrue(useCase is DefaultImportContactUseCase, "Should return a DefaultImportContactUseCase instance")
    }
}
