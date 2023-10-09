//
//  ImportContactUseCase.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public protocol ImportContactUseCase {
    func set(reversionType: ReversionType)
    func set(data: Data)
    func execute() async throws
    func getOutput() throws -> Contact
}

class DefaultImportContactUseCase: ImportContactUseCase {

    enum Error: Swift.Error {
        case missingData
        case dataIntegrityError
        case notYetExecuted
    }

    var reversionType: ReversionType?
    var contact: Contact?
    var data: Data?
    let dataReversionStrategy: DataReversionStrategy
    
    init(dataReversionStrategy: DataReversionStrategy) {
        self.dataReversionStrategy = dataReversionStrategy
    }
    
    func set(reversionType: ReversionType) {
        self.reversionType = reversionType
    }
    
    func set(data: Data) {
        self.data = data
    }
    
    func getOutput() throws -> Contact {
        guard let contact else {
            throw Error.notYetExecuted
        }
        return contact
    }
    
    func execute() async throws {
        guard let data else {
            throw Error.missingData
        }
        let dataContact: DataContact? = dataReversionStrategy.revert(data)
        guard let dataContact else {
            throw Error.dataIntegrityError
        }
        contact = try ContactMapper(dataContact: dataContact).map()
    }
}
