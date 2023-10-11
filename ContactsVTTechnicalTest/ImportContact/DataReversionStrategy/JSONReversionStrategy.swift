//
//  JSONReversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation

class JSONReversionStrategy: DataReversionStrategy {
    let decoder = JSONDecoder()
    
    func revert<T>(_ data: Data) -> T? where T : Decodable {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            debugPrint("Error al decodificar JSON: \(error)")
            return nil
        }
    }
}
