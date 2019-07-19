//
//  MainViewController.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    var tableView: UITableView = {
        
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tv.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmTableViewCell")
        return tv
    }()
    
    var searchController: UISearchController = {
        
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Busca..."
//        searchController.obscuresBackgroundDuringPresentation = false
        return sc
    }()
    
    var timer: Timer? = nil

    var filmsArray: [Film]? {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableViewConfig
        tableView.delegate = self
        tableView.dataSource = self
        
        //NavItem Config
        navigationItem.title = "Películas"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        //UISearchController Config
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        presenter?.viewDidLoad()
        setUpView()


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: MainViewProtocol {
    
    func setUpView() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([

            
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            ])
        
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
    
}


extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
//        print(text)
        
        self.timer = Timer(timeInterval: 1, repeats: false, block: {_ in
            
            //Aqui se lanza una petición a la API
            
        })
    }

}
