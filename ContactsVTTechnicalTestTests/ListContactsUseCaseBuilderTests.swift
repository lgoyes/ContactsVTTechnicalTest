//
//  ListContactsUseCaseBuilderTests.swift
//  ContactsVTTechnicalTestTests
//
//  Created by Luis David Goyes on 11/10/23.
//

import XCTest
@testable import ContactsVTTechnicalTest

final class ListContactsUseCaseBuilderTests: XCTestCase {
    
    func test_WHEN_build_GIVEN_validDependencyContainer_THEN_itShouldReturnValidListContactsUseCase() {
        let useCase = ListContactsUseCaseBuilder.build()
        
        XCTAssertTrue(useCase is DefaultListContactsUseCase, "Should return a DefaultListContactsUseCase instance")
    }
}
