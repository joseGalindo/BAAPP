//
//  Helper.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 27/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showError(message: String, action: UIAlertAction?) {
        let alertc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertc.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
        if let act = action {
            alertc.addAction(act)
        }
        self.present(alertc, animated: true, completion: nil)
    }
}
