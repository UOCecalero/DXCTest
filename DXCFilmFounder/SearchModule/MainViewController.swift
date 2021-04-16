//
//  MainViewController.swift
//  DXCFilmFounder
//
//  Created by Edu Calero on 19/07/2019.
//  Copyright © 2019 Lynx Developers. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?

    var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentif)
        return tv
    }()
    
//    var searchController: UISearchController = {
//
//        let sc = UISearchController(searchResultsController: nil)
//        sc.searchBar.placeholder = "Busca..."
////        searchController.obscuresBackgroundDuringPresentation = true
//        return sc
//    }()
    
//    var currentQuery: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

        configure()
        setUpView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }

    fileprivate func configure() {
        setUpTable()
        setUpNavItem()
    }

    fileprivate func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
    }

    fileprivate func setUpNavItem(){
        navigationItem.title = "Películas"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]


        


    }

    //    fileprivate func setUpSearchBar {
    //
    //                self.definesPresentationContext = true
    //                navigationItem.searchController = searchController
    //                searchController.searchResultsUpdater = self
    //
    //    }

    func setUpView() {

        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            tableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            ])
    }
}

extension MainViewController: MainViewProtocol {
    func refresh() {
        tableView.reloadData()
    }

    func showSpinner() {
        //TODO: Show spinner
    }


    func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let item = presenter?.itemsArray[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell
        else { return MovieTableViewCell() }

        cell.configrue(with: item)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let movieModel = presenter?.itemsArray[indexPath.row] else { return }
        presenter?.didSelectRow(indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

//extension MainViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {return}
//
//        guard text != "" else {return}
//        currentQuery = text
//        self.presenter?.getFilmsCollection(text)
//        print(text)
//    }
//
//
//}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("CONTENTSIZE: \(scrollView.contentSize.height)")
        print("CONTENTOFFSETY: \(scrollView.contentOffset.y)")
        print("FRAME HEIGHT: \(scrollView.frame.size.height)")
            
            if ( (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.frame.size.height){
                
            print("SCROLLS")
            
//            guard let currentQuery = currentQuery else { return }
//            guard currentQuery != "" else { return }
//            
//            presenter?.getMoreFilms(currentQuery)
            
        }
        
    }
    
    
}
