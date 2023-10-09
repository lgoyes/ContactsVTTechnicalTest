//
//  RemoveContactUseCaseBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public class RemoveContactUseCaseBuilder {
    public static func build() -> RemoveContactUseCase {
        let contactDirectory = DependencyContainer.getContactDirectory()
        let useCase = DefaultRemoveContactUseCase(contactDirectory: contactDirectory)
        return useCase
    }
}
