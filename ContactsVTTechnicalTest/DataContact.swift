//
//  DataContact.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

struct DataContact: Codable {
    let name: String
    let lastname: String
    let phone: String
    let email: String
    let id: UUID
}
