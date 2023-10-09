//
//  CSVReversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation
import CodableCSV

class CSVReversionStrategy: DataReversionStrategy {
    let decoder = CSVDecoder()

    func revert<T>(_ data: Data) -> T? where T : Decodable {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error al decodificar JSON: \(error)")
            return nil
        }
    }
}
