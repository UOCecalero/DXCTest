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

    var items = [MovieModel] ()
    var spinner: UIActivityIndicatorView? = UIActivityIndicatorView(frame: .zero)

    var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentif)
        return tv
    }()

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
        tableView.separatorStyle = .singleLine
    }

    fileprivate func setUpNavItem(){
        navigationItem.title = "Películas"
    }

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

    func show(items: [MovieModel]) {
        self.items = items
        tableView.reloadData()
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
        return items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard indexPath.row < items.count,
              let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell
        else { return MovieTableViewCell() }

        let item = items[indexPath.row]
        cell.configrue(with: item)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row < items.count  else { return }
        let movieModel = items[indexPath.row]
        presenter?.didSelectRow(with: movieModel)
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("CONTENTSIZE: \(scrollView.contentSize.height)")
        print("CONTENTOFFSETY: \(scrollView.contentOffset.y)")
        print("FRAME HEIGHT: \(scrollView.frame.size.height)")
            
            if ( (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.frame.size.height){
                
            print("SCROLLS")
            presenter?.scrolldidReachEnd()
        }
        
    }

}

extension MainViewController: Spinneable {

    func showSpinner() {
        self.startSpinner()
    }

    func hideSpinner() {
        self.stopSpinner()
    }
}
