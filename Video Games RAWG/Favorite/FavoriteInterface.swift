//
//  FavoriteInterface.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

protocol FavoriteRouterInterface: AnyObject {
    func goToDetail(game: Game)
}

protocol FavoritePresenterInterface: AnyObject {
    var games: [Game] { get }
    func loadFavoriteGame()
    func selectAt(index: Int)
}

protocol FavoriteInteractorOuputInterface: AnyObject {
    func loadFavoriteGameSuccess(games: [Game])
    func loadFavoriteGameFail(error: String)
}

protocol FavoriteInteractorInterface: AnyObject {
    func fetchFavoriteGames()
}

protocol FavoriteViewInterface: AnyObject {
    func reloadData()
    func showError(message: String)
}
