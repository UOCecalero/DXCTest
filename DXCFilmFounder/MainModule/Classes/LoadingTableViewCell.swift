//
//  LoadingTableViewCell.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 25/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    let activityIndicator = UIActivityIndicatorView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            ])
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
