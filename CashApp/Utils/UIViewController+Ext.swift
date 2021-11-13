//
//  UIViewController+Ext.swift
//  CashApp
//
//  Created by Ahmet Yusuf Yuksek on 11/2/21.
//

import UIKit

// MARK: - Push Custom Alert
extension UIViewController {
    func presentCustomAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = CashAppAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
}
