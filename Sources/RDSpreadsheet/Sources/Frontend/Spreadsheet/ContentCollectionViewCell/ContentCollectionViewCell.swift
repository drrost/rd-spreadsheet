//
//  ContentCollectionViewCell.swift
//  RDSpreadsheet
//
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {

    static let copiedNotification = "ContentCollectionViewCellCopied"

    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let recognizer = UILongPressGestureRecognizer(
            target: self, action: #selector(longTapPressed))
        contentView.addGestureRecognizer(recognizer)
    }

    @objc
    func longTapPressed(_ sender: UILongPressGestureRecognizer) {

        NotificationCenter.default.post(
            name: Notification.Name(Self.copiedNotification)
            , object: contentLabel.text)

        UIPasteboard.general.string = contentLabel.text
    }
}
