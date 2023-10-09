//
//  DataConversionStrategyFactory.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

class DataConversionStrategyFactory {
    let conversionType: ConversionType
    init(conversionType: ConversionType) {
        self.conversionType = conversionType
    }
    
    func getConversionStrategy() -> DataConversionStrategy {
        let strategy: DataConversionStrategy
        switch conversionType {
        case .csv:
            strategy = CSVConversionStrategy()
        case .json:
            strategy = JSONConversionStrategy()
        }
        return strategy
    }
}
