//
//  DataReversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

protocol DataReversionStrategy {
    func revert<T: Decodable>(_ data: Data) -> T?
}
