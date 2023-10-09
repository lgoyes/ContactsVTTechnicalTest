//
//  ExportContactUseCaseBuilder.swift
//  ContactsVTTechnicalTest
//
//  Created by Luis David Goyes on 9/10/23.
//

import Foundation

public class ExportContactUseCaseBuilder {
    public static func build(conversionType: ConversionType) -> ExportContactUseCase {
        let dataConversionStrategy = DataConversionStrategyFactory(conversionType: conversionType).getConversionStrategy()
        let useCase = DefaultExportContactUseCase(dataConversionStrategy: dataConversionStrategy)
        return useCase
    }
}
