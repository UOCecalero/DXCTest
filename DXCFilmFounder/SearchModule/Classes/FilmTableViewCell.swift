//
//  FilmTableViewCell.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    var film: Film? {
        didSet{
            guard film != nil else {return}
            setupCell()
        }
    }
    
    var portada: UIImageView = {
        
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var titulo: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    var overview: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    //Falta rating

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(portada)
        addSubview(titulo)
        addSubview(overview)
//        addSubview(rating)
    
        setupView()
    }
    
    private func setupCell() {
        
        self.titulo.text = film?.title
        self.overview.text = film?.overview
        
        if let poster = film?.poster_path {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)"){
                if let data = try? Data(contentsOf: url)
                {
                    let image = UIImage(data: data)
                    self.portada.image = image
                }
            }
        }
 
    }
    
    private func setupView(){
        
        NSLayoutConstraint.activate([
            
            portada.heightAnchor.constraint(equalToConstant: 200),
            portada.widthAnchor.constraint(equalToConstant: 200/2),
            portada.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            portada.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        
            titulo.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            titulo.heightAnchor.constraint(equalToConstant: 50),
            titulo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            titulo.topAnchor.constraint(equalTo: portada.bottomAnchor, constant: 20),
        
            overview.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            overview.topAnchor.constraint(equalTo: topAnchor, constant: 270),
            overview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            overview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50)
           
            
        
        ])
        
    }

}
