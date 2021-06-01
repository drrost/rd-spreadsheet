//
//  Model.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import Foundation

public class TableInfo {

    public let data: [[String]]
    public let name: String
    public let columns: [ColumnInfo]

    public init(_ data: [[String]], _ name: String, _ columns: [ColumnInfo]) {
        self.data = data
        self.name = name
        self.columns = columns
    }
}

public class ColumnInfo {

    public let name: String

    public init(_ name: String) {
        self.name = name
    }
}
