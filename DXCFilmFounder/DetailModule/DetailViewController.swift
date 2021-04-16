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
    
    var item: MovieModel?{
        didSet{
            configView()
        }
    }
    
    var scroll: UIScrollView = {
        let sv = UIScrollView()
//        sv.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 50,right: 0)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
        
    }()
    
    var portada: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    var overview: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        setUpView()
        
    }

    func setUpView() {

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        view.addSubview(scroll)
        scroll.addSubview(portada)
        scroll.addSubview(overview)

        NSLayoutConstraint.activate([

        scroll.widthAnchor.constraint(equalTo: view.widthAnchor),
        scroll.heightAnchor.constraint(equalTo: view.heightAnchor),
        scroll.topAnchor.constraint(equalTo: view.topAnchor),
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        portada.heightAnchor.constraint(equalToConstant: 400),
        portada.widthAnchor.constraint(equalToConstant: 400/2),
        portada.centerXAnchor.constraint(equalTo: scroll.centerXAnchor, constant: 0),
        portada.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 50),


        overview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        overview.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 480),
        overview.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: 50),
        overview.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 50),

        ])

    }

    func configView(){

        guard let item = item else {return}

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        navigationItem.title = item.name

        overview.text = item.overview

        if let image = item.backdropPath {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)"){
                if let data = try? Data(contentsOf: url)
                {
                    let image = UIImage(data: data)
                    self.portada.image = image
                }
            }
        }
    }
    

}

extension DetailViewController: DetailViewProtocol {

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
