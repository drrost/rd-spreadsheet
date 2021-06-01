//
//  SpreadsheetVC.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import UIKit

import ExtensionsUIKit

public class SpreadsheetVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var dataSource: SpreadsheetDatasource!

    var dataService: IDataService!

    public static func create(_ dataService: IDataService) -> SpreadsheetVC {

        let vc: SpreadsheetVC = SpreadsheetVC.instantiate("Spreadsheet", "SpreadsheetVC", Bundle.module)
        vc.dataService = dataService

        return vc
    }

    // MARK: - View Controller

    public override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = SpreadsheetDatasource(collectionView, dataService)
        dataSource.update()

        NotificationCenter.default.addObserver(
            self, selector: #selector(copied),
            name: Notification.Name(ContentCollectionViewCell.copiedNotification), object: nil)
    }

    // MARK: - Private

    @objc
    private func copied(_ notification: Notification) {
        showToast("Copied")
    }
}
