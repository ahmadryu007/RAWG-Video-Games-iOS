//
//  FavoriteViewController.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit

final class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoritePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "GameTableViewCell", bundle: Bundle(for: GameTableViewCell.self)),
            forCellReuseIdentifier: "GameTableViewCell"
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadFavoriteGame()
    }

}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
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

extension FavoriteViewController: FavoriteViewInterface {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            self?.present(alert, animated: true)
        }
    }
}
