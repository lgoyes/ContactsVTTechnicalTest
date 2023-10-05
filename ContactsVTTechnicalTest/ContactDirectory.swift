//
//  ContactDirectory.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

protocol ContactDirectoryStoreOperation {
    func add(contact: Contact) async throws
}

protocol ContactDirectoryRemoveOperation {
    func remove(contact: Contact) async throws
}

protocol ContactDirectoryListOperation {
    func list() async throws -> [Contact]
}

protocol ContactDirectoryUpdateOperation {
    func update(contact: Contact) async throws
}

typealias ContactDirectoryProtocol = ContactDirectoryStoreOperation & ContactDirectoryRemoveOperation & ContactDirectoryListOperation & ContactDirectoryUpdateOperation

class ContactDirectory: ContactDirectoryProtocol {
    enum Error: Swift.Error {
        case nonExistingContact
    }
    
    private let sharedInstance = ContactDirectory()
    
    var contacts: [UUID: Contact] = [:]
    
    func add(contact: Contact) async throws {
        contacts[contact.id] = contact
    }
    
    func remove(contact: Contact) async throws {
        if contacts[contact.id] != nil {
            throw Error.nonExistingContact
        }
        contacts.removeValue(forKey: contact.id)
    }
    
    func list() async throws -> [Contact] {
        return Array(contacts.values)
    }
    
    func update(contact: Contact) async throws {
        contacts[contact.id] = contact
    }
    
    func getInstance() -> ContactDirectoryProtocol {
        sharedInstance
    }
}

class ContactDirectoryDelayedDecorator: ContactDirectoryProtocol {
    private struct Constant {
        static let delay: UInt64 = 100 * 1_000_000 // 100 ms = 100,000,000 ns
    }
    private let decoratedDirectory: ContactDirectoryProtocol
    init(decoratedDirectory: ContactDirectoryProtocol) {
        self.decoratedDirectory = decoratedDirectory
    }
    
    func add(contact: Contact) async throws {
        try await Task.sleep(nanoseconds: Constant.delay)
        try await self.decoratedDirectory.add(contact: contact)
    }
    
    func remove(contact: Contact) async throws {
        try await Task.sleep(nanoseconds: Constant.delay)
        try await self.decoratedDirectory.remove(contact: contact)
    }
    
    func list() async throws -> [Contact] {
        try await Task.sleep(nanoseconds: Constant.delay)
        return try await self.decoratedDirectory.list()
    }
    
    func update(contact: Contact) async throws {
        try await Task.sleep(nanoseconds: Constant.delay)
        try await self.decoratedDirectory.update(contact: contact)
    }
}
