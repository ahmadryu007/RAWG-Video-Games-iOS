//
//  HomeViewController.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit

final class HomeViewController: UIViewController {

    var presenter: HomePresenterInterface!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadGames()
        searchBar.delegate = self
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(
            UINib(nibName: "GameTableViewCell", bundle: Bundle(for: GameTableViewCell.self)),
            forCellReuseIdentifier: "GameTableViewCell"
        )
    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.performSearch(_:)), object: searchBar)
            perform(#selector(self.performSearch(_:)), with: searchBar, afterDelay: 0.5)
    }
    
    @objc func performSearch(_ searchBar: UISearchBar) {
        presenter.searchGame(query: searchBar.text ?? "")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as? GameTableViewCell else {
            return UITableViewCell()
        }
        
        let item = presenter.games[indexPath.row]
        cell.selectionStyle = .none
        cell.bind(data: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectAt(index: indexPath.row)
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter.loadGames()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (presenter.games.count - 1)
    }
}

extension HomeViewController: HomeViewInterface {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.isHidden = false
            self?.activityIndicator.startAnimating()
        }
    }
    
    func showError(text: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
}
