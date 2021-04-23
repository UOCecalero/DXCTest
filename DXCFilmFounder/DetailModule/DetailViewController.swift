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



    var item: MovieEntity?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        configView()
    }

    func configView(){

        guard let item = item else {return}

        navigationItem.title = item.name

        if let imageData = item.posterImg {
            let image = UIImage(data: imageData)
            self.image.image = image

        } else {
            if let image = item.posterPath,
               let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)") {
                    if let data = try? Data(contentsOf: url)
                    {
                        let image = UIImage(data: data)
                        self.image.image = image
                    }
                }
            }


        let titleValue = NSMutableAttributedString()
            titleValue.append(NSAttributedString(attributedString: "Título original: ".attributedWith(font: UIFont(name: "SFProText-Bold", size: 16))))
            titleValue.append(NSAttributedString(string: item.originalName ?? "" ))
        originalTitleLabel.attributedText = titleValue


        let estrenoValue = NSMutableAttributedString()
            estrenoValue.append(NSAttributedString(attributedString: "Estreno: ".attributedWith(font: UIFont(name: "SFProText-Bold", size: 16))))
            estrenoValue.append(NSAttributedString(string: item.firstAirDate ?? "" ))
        estrenoLabel.attributedText = estrenoValue

        let voVerisonValue = NSMutableAttributedString()
            voVerisonValue.append(NSAttributedString(attributedString: "V.O.: ".attributedWith(font: UIFont(name: "SFProText-Bold", size: 16))))
            voVerisonValue.append(NSAttributedString(string: item.originalLanguage ?? ""))
        originalVersionLabel.attributedText = voVerisonValue

        let countryValue = NSMutableAttributedString()
            countryValue.append(NSAttributedString(attributedString: "País: ".attributedWith(font: UIFont(name: "SFProText-Bold", size: 16))))
            item.originCountry?.forEach {
                countryValue.append(NSAttributedString(string: $0+" " ))
            }
        countryLabel.attributedText = countryValue


        rateLabel.text = "Puntuación \(item.voteAverage)"

        let votesValue = NSMutableAttributedString()
            votesValue.append(NSAttributedString(string: "\(item.voteCount)"))
            votesValue.append(NSAttributedString(attributedString: " votos".attributedWith(font: UIFont(name: "SFProText-Bold", size: 16))))

        votesLabel.attributedText = votesValue
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
