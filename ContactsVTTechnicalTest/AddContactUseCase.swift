//
//  AddContactUseCase.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

protocol AddContactUseCase {
    func set(param: Contact)
    func execute() async throws
}

class DefaultAddContactUseCase: AddContactUseCase {
    
    enum Error: Swift.Error {
        case missingContact
        case dataIntegrityError
    }
    let contactDirectory: ContactDirectoryStoreOperation
    var contact: Contact?
    
    init(contactDirectory: ContactDirectoryStoreOperation) {
        self.contactDirectory = contactDirectory
    }
    
    func set(param: Contact) {
        self.contact = param
    }
    
    func execute() async throws {
        guard let contact = self.contact else {
            throw Error.missingContact
        }
        do {
            try await contactDirectory.add(contact: contact)
        } catch {
            throw Error.dataIntegrityError
        }
    }
}
