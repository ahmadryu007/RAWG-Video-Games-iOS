//
//  HomeViewController.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {

    var presenter: HomePresenterInterface!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadGames()
    
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(
            UINib(nibName: "GameTableViewCell", bundle: Bundle(for: GameTableViewCell.self)),
            forCellReuseIdentifier: "GameTableViewCell"
        )
        
        setupCombine()
    }

    @IBAction func aboutButtonTapped(_ sender: Any) {
        let aboutViewController = AboutViewController(
            nibName: String(describing: AboutViewController.self),
            bundle: Bundle(for: AboutViewController.self)
        )
        
        present(aboutViewController, animated: true)
    }
}

extension HomeViewController {
    private func setupCombine() {
        NotificationCenter.default.publisher(for:
                                                UISearchTextField.textDidChangeNotification,
                                             object: searchBar.searchTextField)
        .map {
            ($0.object as! UISearchTextField).text
        }
        .sink { [weak self] value in
            guard let self = self, let value = value, value.count % 3 == 0  else { return }
            self.presenter.searchGame(query: value)
        }
        .store(in: &cancellables)
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
