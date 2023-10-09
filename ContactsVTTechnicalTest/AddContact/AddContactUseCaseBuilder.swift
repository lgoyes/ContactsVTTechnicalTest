//
//  AddContactUseCaseBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public class AddContactUseCaseBuilder {
    public static func build() -> AddContactUseCase {
        let contactDirectory = DependencyContainer.getContactDirectory()
        let useCase = DefaultAddContactUseCase(contactDirectory: contactDirectory)
        return useCase
    }
}
