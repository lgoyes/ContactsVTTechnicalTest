//
//  ExportContactUseCase.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public protocol ExportContactUseCase {
    func set(conversionType: ConversionType)
    func set(contact: Contact)
    func execute() async throws
    func getOutput() throws -> Data
}

class DefaultExportContactUseCase: ExportContactUseCase {

    enum Error: Swift.Error {
        case missingContact
        case notYetExecuted
        case dataIntegrityError
    }

    var conversionType: ConversionType?
    var contact: Contact?
    var data: Data?
    let dataConversionStrategy: DataConversionStrategy
    
    init(dataConversionStrategy: DataConversionStrategy) {
        self.dataConversionStrategy = dataConversionStrategy
    }
    
    func set(conversionType: ConversionType) {
        self.conversionType = conversionType
    }
    
    func set(contact: Contact) {
        self.contact = contact
    }
    
    func getOutput() throws -> Data {
        guard let data else {
            throw Error.notYetExecuted
        }
        return data
    }
    
    func execute() async throws {
        guard let contact else {
            throw Error.missingContact
        }
        let dataContact = DataContactMapper(contact: contact).map()
        self.data = dataConversionStrategy.convert(dataContact)
    }
}
