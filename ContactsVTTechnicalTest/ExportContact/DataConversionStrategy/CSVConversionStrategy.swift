//
//  CSVConversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation
import CodableCSV

class CSVConversionStrategy: DataConversionStrategy {
    var encoder: CSVEncoder = {
        var configuration = CSVEncoder.Configuration()
        configuration.encoding = .utf8
        configuration.delimiters = (",", "\n")
        configuration.bomStrategy = .never
        configuration.bufferingStrategy = .keepAll
        let encoder = CSVEncoder(configuration: configuration)
        return encoder
    }()
    
    func convert<T>(_ object: T) -> Data? where T : Encodable {
        guard let headers = PropertyNamesExtractor(value: object).getPropertyNames() else {
            return nil
        }
        
        encoder.headers = headers
        do {
            let data = try encoder.encode([object], into: Data.self)
            return data
        } catch {
            debugPrint("Error al convertir el objeto a CSV: \(error)")
        }
        
        return nil
    }
}

class PropertyNamesExtractor {
    let value: Encodable
    let encoder = JSONEncoder()
    
    init(value: Encodable) {
        self.value = value
    }
    func getPropertyNames() -> [String]?{
        do {
            let data = try encoder.encode(value)
            
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return Array(jsonObject.keys)
            }
        } catch {
            debugPrint("Error: \(error)")
        }
        
        return nil
    }
}
