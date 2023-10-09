//
//  DataContactMapper.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

class DataContactMapper {
    enum Error: Swift.Error {
        case invalidFormat(String)
    }
    
    private let contact: Contact
    init(contact: Contact) {
        self.contact = contact
    }
    
    func map() -> DataContact {
        let number = contact.getPhoneNumber()
        let email = contact.getEmailAddress()
        let name = contact.getName()
        let lastname = contact.getLastname()
        let id = contact.id
        return DataContact(name: name, lastname: lastname, phone: number, email: email, id: id)
    }
}
