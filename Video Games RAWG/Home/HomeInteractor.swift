//
//  HomeInteractor.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class HomeInteractor {
    weak var presenter: HomeInteractorOutputInterface?
    
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchGames(query: String?, loadUrl: String?) {
        
        var gamesUrl = URL(string: Constant.gameUrl)!
        if let loadUrl = loadUrl {
            gamesUrl = URL(string: loadUrl)!
        } else {
            var queryItems: [URLQueryItem] = []
            if let query = query {
                queryItems.append(URLQueryItem(name: "search", value: query))
            }
            
            queryItems.append(URLQueryItem(name: "key", value: Constant.apiKey))
            queryItems.append(URLQueryItem(name: "page", value: "1"))
            queryItems.append(URLQueryItem(name: "page_size", value: "7"))
            gamesUrl.append(queryItems: queryItems)
        }
        
        let request = URLRequest(url: gamesUrl)
        let task = URLSession.shared.dataTask(with: request) { data, response , error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let games = try decoder.decode(Games.self, from: data)
                    self.presenter?.fetchGamesSuccess(games: games)
                } catch let error {
                    print(String(describing: error))
                    self.presenter?.fetchGamesFail(error: error.localizedDescription)
                }
                
            } else if let error = error {
                self.presenter?.fetchGamesFail(error: error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
