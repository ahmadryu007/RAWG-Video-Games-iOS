//
//  GameInteractor.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class GameInteractor {
    weak var presenter: GameInteractorOutputInterface?
}

extension GameInteractor: GameInteractorInterface {
    func fetchGameDetailBy(id: Int) {
        let request = URLRequest(url: URL(string: "\(Constant.gameUrl)/\(id)?key=\(Constant.apiKey)")!)
        let task = URLSession.shared.dataTask(with: request) { data, response , error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let gameDetail = try decoder.decode(GameDetail.self, from: data)
                    self.presenter?.fetchGameDetailSuccess(detail: gameDetail)
                } catch let error {
                    print(String(describing: error))
                    self.presenter?.fetchGameDetailFail(error: error.localizedDescription)
                }
                
            } else if let error = error {
                self.presenter?.fetchGameDetailFail(error: error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
