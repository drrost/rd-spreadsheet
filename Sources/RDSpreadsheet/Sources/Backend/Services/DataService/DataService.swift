//
//  DataService.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import Foundation

public protocol IService {}

public protocol IDataService: IService {

    func getData() -> TableInfo
}
