//
//  ListContactsUseCase.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

public protocol ListContactsUseCase {
    func execute() async throws
    func getData() -> [Contact]
}

class DefaultListContactsUseCase: ListContactsUseCase {
    enum Error: Swift.Error {
        case dataIntegrityError
    }
    
    let contactDirectory: ContactDirectoryListOperation
    var result: [Contact]
    
    init(contactDirectory: ContactDirectoryListOperation) {
        self.contactDirectory = contactDirectory
        self.result = []
    }
    
    func execute() async throws {
        result = []
        do {
            result = try await contactDirectory.list()
        } catch {
            print("Directory error")
            throw Error.dataIntegrityError
        }
    }
    
    func getData() -> [Contact] {
        return result
    }
}
