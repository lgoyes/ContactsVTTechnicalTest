//
//  DelayedContactDirectoryBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

class DelayedContactDirectoryBuilder {
    static func build() -> ContactDirectoryProtocol {
        let directory = ContactDirectoryBuilder.build()
        return ContactDirectoryDelayedDecorator(decoratedDirectory: directory)
    }
}
