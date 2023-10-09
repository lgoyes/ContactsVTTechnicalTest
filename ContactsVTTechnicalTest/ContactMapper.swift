//
//  ContactMapper.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

class ContactMapper {
    enum Error: Swift.Error {
        case invalidFormat(String)
    }
    
    private let dataContact: DataContact
    init(dataContact: DataContact) {
        self.dataContact = dataContact
    }
    
    func map() throws -> Contact {
        do {
            let number = try ContactPhoneNumber(phoneNumber: dataContact.phone)
            let name = try ContactName(name: dataContact.name, lastname: dataContact.lastname)
            let email = try ContactEmailAddress(emailAddress: dataContact.email)
            let contact = Contact(name: name, phoneNumber: number, emailAddress: email, id: dataContact.id)
            return contact
        } catch {
            throw Error.invalidFormat(error.localizedDescription)
        }
    }
}
