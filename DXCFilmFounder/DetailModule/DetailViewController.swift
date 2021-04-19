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
    
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var estrenoLabel: UILabel!
    @IBOutlet weak var originalVersionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!



    var item: MovieModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        configView()
        
        
    }

    func configView(){

        guard let item = item else {return}

        navigationItem.title = item.name

        if let image = item.posterPath {
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)"){
                if let data = try? Data(contentsOf: url)
                {
                    let image = UIImage(data: data)
                    self.image.image = image
                }
            }
        }

        originalTitleLabel.text = "Título original: \(item.originalName ?? "")"
        estrenoLabel.text = "Estreno: \(item.firstAirDate ?? "")"
        originalVersionLabel.text = "V.O.: \(item.originalLanguage ?? "")"
        countryLabel.text = "País de orígen: \(item.originCountry ?? [])"
        rateLabel.text = "Puntuación \(item.voteAverage ?? 0.0)"
        votesLabel.text = "\(item.voteCount ?? 0) votos"
        descriptionLabel.text = "\(item.overview ?? "")"

    }
    

}

extension DetailViewController: DetailViewProtocol {

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
