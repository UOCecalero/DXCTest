//
//  UIViewController+Extensions.swift
//  DXCFilmFounder
//
//  Created by Eduard Calero on 20/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit

extension UIViewController {

    static func generatedIntanceViewController<T: UIViewController>(storyBoardName: String? = nil) -> T {
        let nameViewController: String = String(describing: T.self)

        let storyboard = UIStoryboard(
            name: storyBoardName ?? nameViewController,
            bundle: Bundle.main
        )

        guard let viewController: T = storyboard.instantiateViewController(withIdentifier: nameViewController) as? T else {
            fatalError("Storyboard full screen error not has been initialized")
        }

        return viewController
    }
}
