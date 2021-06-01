//
//  UIViewController+Extension.swift
//  RDSpreadsheet
//  git@github.com:drrost/rd-spreadsheet.git
//  Created by Rostyslav Druzhchenko on 30.05.2021.
//

import UIKit

extension UIViewController {

    func showToast(_ message : String) {

        if message.count == 0 { return }

        let toastLabel = createLabel()
        toastLabel.text = message
        setupAppearence(toastLabel)
        self.view.addSubview(toastLabel)

        UIView.animate(
            withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

    private func createLabel() -> UILabel {

        let rect = CGRect(x: self.view.frame.size.width/2 - 75,
                          y: self.view.frame.size.height-100,
                          width: 150, height: 35)
        return UILabel(frame: rect)
    }

    private func setupAppearence(_ label: UILabel) {

        let font = UIFont.systemFont(ofSize: 14.0)

        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.textColor = UIColor.white
        label.font = font
        label.textAlignment = .center;
        label.alpha = 1.0
        label.layer.cornerRadius = 10;
        label.clipsToBounds  =  true
    }
}
