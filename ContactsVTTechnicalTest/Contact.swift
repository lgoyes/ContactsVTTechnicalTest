//
//  Contact.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

protocol ContactNameGettable {
    func getFullname() -> String
}

struct ContactName: ContactNameGettable {
    enum Error: Swift.Error {
        case maxLengthExceeded
    }
    
    private struct Constant {
        static let maxLength = 20
    }
    
    private let name: String
    private let lastname: String
    
    init(name: String, lastname: String) throws {
        self.name = name
        self.lastname = lastname
        
        guard getFullname().count <= Constant.maxLength else {
            throw Error.maxLengthExceeded
        }
    }
    
    func getFullname() -> String {
        "\(name) \(lastname)"
    }
}

protocol ContactPhoneNumberGettable {
    func getPhoneNumber() -> String
}

struct ContactPhoneNumber: ContactPhoneNumberGettable {
    enum Error: Swift.Error {
        case invalidLength
        case unexpectedFormat
    }
    
    private struct Constant {
        static let expectedLength = 10
    }
    
    private let phoneNumber: String
    
    init(phoneNumber: String) throws {
        self.phoneNumber = phoneNumber
        
        guard phoneNumber.count == Constant.expectedLength else {
            throw Error.invalidLength
        }
        
        let numbers = CharacterSet.decimalDigits
        let invalidCharacters = phoneNumber.trimmingCharacters(in: numbers.inverted)
        
        guard invalidCharacters.isEmpty else {
            throw Error.unexpectedFormat
        }
    }
    func getPhoneNumber() -> String {
        phoneNumber
    }
}

protocol ContactEmailAddressGettable {
    func getEmailAddress() -> String
}

struct ContactEmailAddress: ContactEmailAddressGettable {
    enum Error: Swift.Error {
        case invalidFormat
    }
    
    private struct Constant {
        static let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    }
    
    private let emailAddress: String
    
    init(emailAddress: String) throws {
        self.emailAddress = emailAddress
        
        guard let range = emailAddress.range(of: Constant.emailRegex, options: .regularExpression) else {
            throw Error.invalidFormat
        }
        
        let valid = range.lowerBound == emailAddress.startIndex && range.upperBound == emailAddress.endIndex
        if !valid {
            throw Error.invalidFormat
        }
    }
    func getEmailAddress() -> String {
        emailAddress
    }
}

struct Contact: ContactNameGettable, ContactPhoneNumberGettable, ContactEmailAddressGettable, Identifiable {
    
    let id: UUID

    private let name: ContactName
    private let phoneNumber: ContactPhoneNumber
    private let emailAddress: ContactEmailAddress
    
    init(name: ContactName, phoneNumber: ContactPhoneNumber, emailAddress: ContactEmailAddress, id: UUID = UUID()) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.id = id
    }
    
    func getFullname() -> String {
        name.getFullname()
    }
    
    func getPhoneNumber() -> String {
        phoneNumber.getPhoneNumber()
    }
    
    func getEmailAddress() -> String {
        emailAddress.getEmailAddress()
    }
}
