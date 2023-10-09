//
//  ListContactsUseCaseBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public class ListContactsUseCaseBuilder {
    public static func build() -> ListContactsUseCase {
        let contactDirectory = DependencyContainer.getContactDirectory()
        let useCase = DefaultListContactsUseCase(contactDirectory: contactDirectory)
        return useCase
    }
}
