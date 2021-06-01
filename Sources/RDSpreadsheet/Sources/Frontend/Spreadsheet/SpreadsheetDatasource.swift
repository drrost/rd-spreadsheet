//
//  SpreadsheetDatasource.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 25.05.2021.
//

import UIKit

class SpreadsheetDatasource: NSObject, UICollectionViewDelegate,
                             UICollectionViewDataSource {

    let collectionView: UICollectionView
    let dataService: IDataService
    var data = [[String]]()

    init(_ collectionView: UICollectionView,
         _ dataService: IDataService) {

        self.collectionView = collectionView
        self.dataService = dataService
        super.init()

        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }

    func update() {
        let tableInfo = dataService.getData()

        if let layout = collectionView.collectionViewLayout as? SpreadsheetViewLayout {
            data = convertTableInfo(tableInfo)
            layout.layoutCalculator = SpreadsheetLayoutCalclulator(data)
        }

        collectionView.reloadData()
    }

    // MARK: - Private

    private func registerCell() {
        collectionView.register(
            UINib(nibName: "ContentCollectionViewCell", bundle: Bundle.module),
                forCellWithReuseIdentifier: "ContentCollectionViewCell")
    }

    // MARK: - UICollectionView

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        data[0].count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = contentCell(for: indexPath)
        cell.backgroundColor = color(for: indexPath.section)
        cell.contentLabel.text = data[indexPath.section][indexPath.row]
        cell.contentLabel.textAlignment = alignment(for: indexPath)

        return cell
    }

    // MARK: - Private

    private func contentCell(for indexPath: IndexPath) -> ContentCollectionViewCell {

        collectionView.dequeueReusableCell(
            withReuseIdentifier: "ContentCollectionViewCell",
            for: indexPath) as! ContentCollectionViewCell
    }

    private func color(for section: Int) -> UIColor {
        section % 2 != 0 ? UIColor(white: 242/255.0, alpha: 1.0) : UIColor.white
    }

    private func alignment(for indexPath: IndexPath) -> NSTextAlignment {
        indexPath.row == 0 || indexPath.section == 0 ? .center : .left
    }

    private func convertTableInfo(_ tableInfo: TableInfo) -> [[String]] {

        var result = [[String]]()
        var header = [String]()
        header.append("")
        header.append(contentsOf: tableInfo.columns.map { $0.name })
        result.append(header)

        for (i, line) in tableInfo.data.enumerated() {
            var row = [String]()
            row.append("\(i + 1)")
            row.append(contentsOf: line)
            result.append(row)
        }

        return result
    }
}
