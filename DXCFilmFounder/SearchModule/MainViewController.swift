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
        tv.separatorStyle = .none
        tv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tv.register(FilmTableViewCell.self, forCellReuseIdentifier: "FilmTableViewCell")
        return tv
    }()
    
    var searchController: UISearchController = {
        
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Busca..."
//        searchController.obscuresBackgroundDuringPresentation = true
        return sc
    }()
    
    var currentQuery: String?

    var filmsArray: [Film]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
        
        //UITableViewConfig
        tableView.delegate = self
        tableView.dataSource = self

        
        //NavItem Config
        navigationItem.title = "Películas"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
        //UISearchController Config
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    
        setUpView()


    }
    

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
    
    func setTable(_ films: [Film]) {
        filmsArray = films
        tableView.reloadData()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func addRows(_ films: [Film]) {
        
        filmsArray?.append(contentsOf: films)
        tableView.reloadData()
//        tableView.numberOfRows(inSection: 0)
        
//        guard let currentRows = filmsArray?.count else {return}
//        filmsArray?.append(contentsOf: films)
//
//        var indexPaths: [IndexPath] = []
//        for index in currentRows...(currentRows+films.count){
//            indexPaths.append(IndexPath(row: index, section: 0))
//        }
//
//        tableView.insertRows(at: indexPaths, with: .none)
        
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
        
        let film = filmsArray?[indexPath.row]
        let celda = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as! FilmTableViewCell
        celda.film = film
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let film = filmsArray?[indexPath.row] else {return}
        presenter?.goToDetail(with: film)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}


extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        
        guard text != "" else {return}
        currentQuery = text
        self.presenter?.getFilmsCollection(text)
        print(text)
    }
    

}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            if ( (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.frame.size.height){
            
            guard let currentQuery = currentQuery else {return}
            guard currentQuery != "" else {return}
            
            presenter?.getMoreFilms(currentQuery)
            
        }
        
    }
    
    
}
