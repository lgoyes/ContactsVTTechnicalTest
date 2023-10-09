//
//  JSONConversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

class JSONConversionStrategy: DataConversionStrategy {
    let encoder = JSONEncoder()
    
    func convert<T>(_ object: T) -> Data? where T : Encodable {
        do {
            let jsonData = try encoder.encode(object)
            return jsonData
        } catch {
            print("Error al convertir el objeto a JSON: \(error)")
        }
        
        return nil
    }
}
