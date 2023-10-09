//
//  ImportContactUseCaseBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public class ImportContactUseCaseBuilder {
    public static func build(reversionType: ReversionType) -> ImportContactUseCase {
        let reversionStrategy = DataReversionStrategyFactory(reversionType: reversionType).getReversionStrategy()
        let useCase = DefaultImportContactUseCase(dataReversionStrategy: reversionStrategy)
        return useCase
    }
}
