//
//  Contact.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

public protocol ContactNameGettable: Equatable {
    func getFullname() -> String
}

protocol ContactFineNameGettable: Equatable {
    func getName() -> String
    func getLastname() -> String
}

public struct ContactName: ContactNameGettable, ContactFineNameGettable {
    enum Error: Swift.Error {
        case maxLengthExceeded
    }
    
    struct Constant {
        static let maxLength = 20
    }
    
    private let name: String
    private let lastname: String
    
    public init(name: String, lastname: String) throws {
        self.name = name
        self.lastname = lastname
        
        guard getFullname().count <= Constant.maxLength else {
            throw Error.maxLengthExceeded
        }
    }
    
    public func getFullname() -> String {
        "\(name) \(lastname)"
    }
    
    func getName() -> String {
        name
    }
    
    func getLastname() -> String {
        lastname
    }
}

public protocol ContactPhoneNumberGettable: Equatable {
    func getPhoneNumber() -> String
}

public struct ContactPhoneNumber: ContactPhoneNumberGettable {
    enum Error: Swift.Error {
        case invalidLength
        case unexpectedFormat
    }
    
    struct Constant {
        static let expectedLength = 10
    }
    
    private let phoneNumber: String
    
    public init(phoneNumber: String) throws {
        self.phoneNumber = phoneNumber
        
        guard phoneNumber.count == Constant.expectedLength else {
            throw Error.invalidLength
        }
        
        let numbers = CharacterSet.decimalDigits
        let invalidCharacters = phoneNumber.trimmingCharacters(in: numbers)
        
        guard invalidCharacters.isEmpty else {
            throw Error.unexpectedFormat
        }
    }
    public func getPhoneNumber() -> String {
        phoneNumber
    }
}

public protocol ContactEmailAddressGettable: Equatable {
    func getEmailAddress() -> String
}

public struct ContactEmailAddress: ContactEmailAddressGettable {
    enum Error: Swift.Error {
        case invalidFormat
    }
    
    struct Constant {
        static let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    }
    
    private let emailAddress: String
    
    public init(emailAddress: String) throws {
        self.emailAddress = emailAddress
        
        guard let range = emailAddress.range(of: Constant.emailRegex, options: .regularExpression) else {
            throw Error.invalidFormat
        }
        
        let valid = range.lowerBound == emailAddress.startIndex && range.upperBound == emailAddress.endIndex
        if !valid {
            throw Error.invalidFormat
        }
    }
    public func getEmailAddress() -> String {
        emailAddress
    }
}

public struct Contact: ContactNameGettable, ContactPhoneNumberGettable, ContactEmailAddressGettable, ContactFineNameGettable, Identifiable {
    
    public let id: UUID

    private let name: ContactName
    private let phoneNumber: ContactPhoneNumber
    private let emailAddress: ContactEmailAddress
    
    public init(name: ContactName, phoneNumber: ContactPhoneNumber, emailAddress: ContactEmailAddress, id: UUID = UUID()) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.emailAddress = emailAddress
        self.id = id
    }
    
    public func getFullname() -> String {
        name.getFullname()
    }
    
    public func getPhoneNumber() -> String {
        phoneNumber.getPhoneNumber()
    }
    
    public func getEmailAddress() -> String {
        emailAddress.getEmailAddress()
    }
    
    func getName() -> String {
        name.getName()
    }
    
    func getLastname() -> String {
        name.getLastname()
    }
}
