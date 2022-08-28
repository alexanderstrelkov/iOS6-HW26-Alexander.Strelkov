//
//  UIVC+UIAler.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 28.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    public func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okButton)
        navigationController?.present(alert, animated: true)
    }
}
