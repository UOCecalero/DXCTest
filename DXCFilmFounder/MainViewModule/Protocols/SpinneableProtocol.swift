//
//  SpinnerView.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 17/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit


protocol SpinneableProtocol {
    var spinner: UIActivityIndicatorView? { get }
}

extension SpinneableProtocol where Self: UIViewController {

    func startSpinner(){
        guard let spinner = spinner else { return }
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spinner)
        spinner.layer.zPosition = 1
        spinner.startAnimating()

        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalTo: view.heightAnchor),
            spinner.widthAnchor.constraint(equalTo: view.widthAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func stopSpinner(){
        self.spinner?.stopAnimating()
        self.spinner?.removeFromSuperview()
    }
}
