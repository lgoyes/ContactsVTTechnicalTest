//
//  CSVConversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation
import CodableCSV

class CSVConversionStrategy: DataConversionStrategy {
    let encoder = CSVEncoder()

    func convert<T>(_ object: T) -> Data? where T : Encodable {
        do {
            let data = try encoder.encode(object)
            return data
        } catch {
            print("Error al convertir el objeto a CSV: \(error)")
        }
        
        return nil
    }
}
