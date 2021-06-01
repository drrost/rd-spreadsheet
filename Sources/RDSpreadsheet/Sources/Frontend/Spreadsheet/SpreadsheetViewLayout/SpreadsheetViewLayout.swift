//
//  SpreadsheetViewLayout.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import UIKit

class SpreadsheetViewLayout: UICollectionViewLayout {

    var layoutCalculator: SpreadsheetLayoutCalclulator!

    override func prepare() {

        guard let collectionView = collectionView else {
            return
        }
        if collectionView.numberOfSections == 0 {
            return
        }

        layoutCalculator.update(collectionView.contentOffset)
    }

    override var collectionViewContentSize: CGSize {
        layoutCalculator.contentSize
    }

    override func layoutAttributesForItem(
        at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        layoutCalculator.layoutAttributes[indexPath.section][indexPath.row]
    }

    override func layoutAttributesForElements(
        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        layoutCalculator.layoutAttributes.flatMap {
            $0.filter { rect.intersects($0.frame) }
        }
    }

    override func shouldInvalidateLayout(
        forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
