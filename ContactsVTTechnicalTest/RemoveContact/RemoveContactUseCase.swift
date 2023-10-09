//
//  RemoveContactUseCase.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public protocol RemoveContactUseCase {
    func set(param: Contact)
    func execute() async throws
}

class DefaultRemoveContactUseCase: RemoveContactUseCase {
    
    enum Error: Swift.Error {
        case missingContact
        case dataIntegrityError
    }
    let contactDirectory: ContactDirectoryRemoveOperation
    var contact: Contact?
    
    init(contactDirectory: ContactDirectoryRemoveOperation) {
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
            try await contactDirectory.remove(contact: contact)
        } catch {
            throw Error.dataIntegrityError
        }
    }
}
