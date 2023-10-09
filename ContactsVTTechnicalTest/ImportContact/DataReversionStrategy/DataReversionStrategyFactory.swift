//
//  DataReversionStrategyFactory.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

class DataReversionStrategyFactory {
    let reversionType: ReversionType
    init(reversionType: ReversionType) {
        self.reversionType = reversionType
    }
    
    func getReversionStrategy() -> DataReversionStrategy {
        let strategy: DataReversionStrategy
        switch reversionType {
        case .csv:
            strategy = CSVReversionStrategy()
        case .json:
            strategy = JSONReversionStrategy()
        }
        return strategy
    }
}
