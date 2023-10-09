//
//  DataConversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

protocol DataConversionStrategy {
    func convert<T: Encodable>(_ object: T) -> Data?
}
