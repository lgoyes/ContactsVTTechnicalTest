//
//  CSVReversionStrategy.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes Garces on 5/10/23.
//

import Foundation
import CodableCSV

class CSVReversionStrategy: DataReversionStrategy {
    let decoder = CSVDecoder {
        $0.encoding = .utf8
        $0.delimiters = Delimiter.Pair(",", "\n")
        $0.headerStrategy = .firstLine
    }

    func revert<T>(_ data: Data) -> T? where T : Decodable {
        do {
            let results = try decoder.decode([T].self, from: data)
            if results.isEmpty {
                return nil
            }
            return results.first!
        } catch {
            debugPrint("Error al decodificar CSV: \(error)")
            return nil
        }
    }
}
