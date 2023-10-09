//
//  UpdateContactUseCase.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public protocol UpdateContactUseCase {
    func set(param: Contact)
    func execute() async throws
}

class DefaultUpdateContactUseCase: UpdateContactUseCase {
    
    enum Error: Swift.Error {
        case missingContact
        case dataIntegrityError
    }
    let contactDirectory: ContactDirectoryUpdateOperation
    var contact: Contact?
    
    init(contactDirectory: ContactDirectoryUpdateOperation) {
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
            try await contactDirectory.update(contact: contact)
        } catch {
            throw Error.dataIntegrityError
        }
    }
}
