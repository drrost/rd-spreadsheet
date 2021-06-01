//
//  DataService.swift
//  RDSpreadsheet
//  git@github.com:drrost/rd-spreadsheet.git
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import Foundation

public protocol IService {}

public protocol IDataService: IService {

    func getData() -> TableInfo
}
