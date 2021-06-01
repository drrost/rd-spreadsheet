//
//  SpreadsheetLayoutCalclulator.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import UIKit

class SpreadsheetLayoutCalclulator {

    private let font = UIFont.systemFont(ofSize: 14.0)

    var layoutAttributes = [[UICollectionViewLayoutAttributes]]()
    var itemsSize = [CGSize]()
    var contentSize: CGSize = .zero

    let data: [[String]]
    var columnWidths: [CGFloat] = [CGFloat]()

    // MARK: - Init

    init(_ data: [[String]]) {
        self.data = data
        updateLongest()
    }

    // MARK: - Public

    func update(_ contentOffset: CGPoint) {

        if layoutAttributes.count != numberOfRows() {
            updateLayoutAttributes(contentOffset)
            return
        }

        for item in 0 ..< numberOfColumns() {

            let attributes = layoutAttributes[0][item]
            var frame = attributes.frame
            frame.origin.y = contentOffset.y
            attributes.frame = frame
        }

        for section in 0 ..< numberOfRows() {

            let attributes = layoutAttributes[section][0]
            var frame = attributes.frame
            frame.origin.x = contentOffset.x
            attributes.frame = frame
        }
    }

    // MARK: - Private

    func updateLayoutAttributes(_ contentOffset: CGPoint) {

        if itemsSize.count != numberOfColumns() {
            calculateItemSizes()
        }

        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0

        layoutAttributes = []

        for section in 0 ..< numberOfRows() {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []

            for index in 0 ..< numberOfColumns() {

                let itemSize = itemsSize[index]
                let frame = CGRect(
                    x: xOffset, y: yOffset,
                    width: itemSize.width, height: itemSize.height).integral

                let indexPath = IndexPath(item: index, section: section)
                let attributes =
                    UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame

                if section == 0 && index == 0 {
                    attributes.zIndex = 1024
                } else if section == 0 || index == 0 {
                    attributes.zIndex = 1023
                }

                if section == 0 {
                    var frame = attributes.frame
                    frame.origin.y = contentOffset.y
                    attributes.frame = frame
                }
                if index == 0 {
                    var frame = attributes.frame
                    frame.origin.x = contentOffset.x
                    attributes.frame = frame
                }

                sectionAttributes.append(attributes)

                xOffset += itemSize.width
                column += 1

                if column == numberOfColumns() {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }

                    column = 0
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }

            layoutAttributes.append(sectionAttributes)
        }

        if let attributes = layoutAttributes.last?.last {
            contentSize = CGSize(width: contentWidth, height: attributes.frame.maxY)
        }
    }

    private func calculateItemSizes() {
        itemsSize = (0 ..< numberOfColumns()).map { sizeForItemWithColumnIndex($0) }
    }

    private func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {

        switch columnIndex {
        case 0:
            return CGSize(width: width(of: "MMM-99"), height: 30)
        default:
            return CGSize(width: columnWidths[columnIndex], height: 30)
        }
    }

    private func width(of text: String) -> CGFloat {
        let size: CGSize = text.size(withAttributes: [.font: font])
        let width: CGFloat = size.width + 16
        return width
    }

    private func numberOfColumns() -> Int {
        if data.count > 0 {
            return data[0].count
        }
        return 0
    }

    private func numberOfRows() -> Int {
        data.count
    }

    // MARK: -

    private func updateLongest() {

        columnWidths = []

        for j in 0 ..< data[0].count {

            var longest: CGFloat = 0.0
            for i in 0 ..< data.count {
                let value = width(of: data[i][j])
                if longest < value {
                    longest = value
                }
            }
            columnWidths.append(longest + 16)
        }
    }
}
