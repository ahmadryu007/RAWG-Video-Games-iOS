//
//  GameInterface.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

protocol GameRouterInterface: AnyObject {
    
}

protocol GamePresenterInterface: AnyObject {
    var game: Game { get }
    func loadDetailGame()
    func addToFavorite()
    func removeFromFavorite()
}

protocol GameInteractorOutputInterface: AnyObject {
    func fetchGameDetailSuccess(detail: GameDetail)
    func fetchGameDetailFail(error: String)
    func fetchFavoriteGamesSuccess(favorites: [Game])
}

protocol GameInteractorInterface: AnyObject {
    func fetchGameDetailBy(id: Int)
    func fetchFavoriteGames()
    func addToFavorite(game: Game)
    func removeFromFavorite(game: Game)
}

protocol GameViewInterface: AnyObject {
    func setFavoriteState(isFavorite: Bool)
    func bind(detail: GameDetail)
    func showError(message: String)
}
