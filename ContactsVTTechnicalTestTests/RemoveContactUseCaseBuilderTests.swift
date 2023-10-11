//
//  RemoveContactUseCaseBuilderTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class RemoveContactUseCaseBuilderTests: XCTestCase {
    func test_WHEN_build_GIVEN_validDependencyContainer_THEN_itShouldReturnValidRemoveContactUseCase() {
        let useCase = RemoveContactUseCaseBuilder.build()
        
        XCTAssertTrue(useCase is DefaultRemoveContactUseCase, "Should return a DefaultRemoveContactUseCase instance")
    }
}
