//
//  HomeInterface.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

protocol HomeRouterInterface: AnyObject {
    func goToDetail(game: Game)
}

protocol HomePresenterInterface: AnyObject {
    var games: [Game] { get }
    func loadGames()
    func searchGame(query: String)
    func selectAt(index: Int)
}

protocol HomeInteractorInterface: AnyObject {
    func fetchGames(query: String?, loadUrl: String?)
}

protocol HomeInteractorOutputInterface: AnyObject {
    func fetchGamesSuccess(games: Games)
    func fetchGamesFail(error: String)
}

protocol HomeViewInterface: AnyObject {
    func showLoading()
    func showError(text: String)
    func reloadData()
}
