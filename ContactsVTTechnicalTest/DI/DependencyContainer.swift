//
//  DependencyContainer.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

class DependencyContainer {
    private static var contactDirectory: ContactDirectoryProtocol = DelayedContactDirectoryBuilder.build()
    
    static func getContactDirectory() -> ContactDirectoryProtocol {
        contactDirectory
    }
    
    static func setContactDirectory(directory: ContactDirectoryProtocol) {
        contactDirectory = directory
    }
}
