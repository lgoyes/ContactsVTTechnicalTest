//
//  UpdateContactUseCaseBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public class UpdateContactUseCaseBuilder {
    public static func build() -> UpdateContactUseCase {
        let contactDirectory = DependencyContainer.getContactDirectory()
        let useCase = DefaultUpdateContactUseCase(contactDirectory: contactDirectory)
        return useCase
    }
}
