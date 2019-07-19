//
//  DetailViewController.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
    var film: Film?{
        didSet{
            configView()
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
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    var overview: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        
    }
    

}

extension DetailViewController: DetailViewProtocol {
   
    
    func setUpView() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(portada)
        view.addSubview(titulo)
        view.addSubview(overview)
        //        addSubview(rating)
        
        NSLayoutConstraint.activate([
        
        portada.heightAnchor.constraint(equalToConstant: 200),
        portada.widthAnchor.constraint(equalToConstant: 200/2),
        portada.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        portada.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
        
        titulo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        titulo.heightAnchor.constraint(equalToConstant: 50),
        titulo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        titulo.topAnchor.constraint(equalTo: portada.bottomAnchor, constant: 20),
        
        overview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        overview.topAnchor.constraint(equalTo: view.topAnchor, constant: 270),
        overview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
        overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        
        ])
        
    }
    
    func configView(){
        
        
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}
