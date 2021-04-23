//
//  FilmTableViewCell.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var item: MovieEntity?

    static let reuseIdentif = "MovieTableViewCell"

    
    var titulo: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        return label
    }()

    var pais: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 1
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        return label
    }()

    var puntuacion: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "SFProText-Bold", size: 22)
        label.numberOfLines = 2
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        

        addSubview(titulo)
        addSubview(pais)
        addSubview(puntuacion)
    
        setupView()
    }

    func configrue(with item: MovieEntity) {
        self.item = item
        setupCell()
    }

}

extension MovieTableViewCell {
    
    fileprivate func setupCell() {
        
        self.titulo.text = item?.name
        let paisValue: NSMutableAttributedString = NSMutableAttributedString()
            paisValue.append(NSAttributedString(attributedString: "Country: ".attributedWith(font: UIFont(name: "SFProText-Bold", size: 14))))
            paisValue.append(NSAttributedString(string: item?.originCountry?.first ?? "" ))

        self.pais.attributedText =  paisValue
        self.puntuacion.text = ""
        if let puntuacion = item?.voteAverage {
            self.puntuacion.text = "\u{2606} \(puntuacion)"
        }


    }
    
    fileprivate func setupView(){
        
        NSLayoutConstraint.activate([

            titulo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            titulo.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            titulo.bottomAnchor.constraint(equalTo: pais.topAnchor, constant: -5),
            titulo.trailingAnchor.constraint(equalTo: puntuacion.leadingAnchor, constant: -4),
            titulo.heightAnchor.constraint(equalToConstant: 22),


            puntuacion.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            puntuacion.heightAnchor.constraint(equalToConstant: 44),
            puntuacion.widthAnchor.constraint(equalToConstant: 70),
            puntuacion.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),

            pais.leadingAnchor.constraint(equalTo: titulo.leadingAnchor, constant: 0),
            pais.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            pais.widthAnchor.constraint(equalTo: titulo.widthAnchor),
            pais.heightAnchor.constraint(equalToConstant: 16)

        ])
        
    }

}
