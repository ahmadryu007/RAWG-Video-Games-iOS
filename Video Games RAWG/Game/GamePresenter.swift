//
//  GamePresenter.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class GamePresenter: GamePresenterInterface {
    private weak var view: GameViewInterface?
    private let interactor: GameInteractorInterface
    private let router: GameRouterInterface
    let game: Game
    
    init(view: GameViewInterface, interactor: GameInteractorInterface, router: GameRouterInterface, game: Game) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.game = game
    }
    
    func loadDetailGame() {
        interactor.fetchGameDetailBy(id: game.id ?? 0)
        interactor.fetchFavoriteGames()
    }
    
    func addToFavorite() {
        DispatchQueue.main.async {
            self.interactor.addToFavorite(game: self.game)
        }
    }
    
    func removeFromFavorite() {
        DispatchQueue.main.async {
            self.interactor.removeFromFavorite(game: self.game)
        }
    }
}

extension GamePresenter: GameInteractorOutputInterface {
    func fetchGameDetailSuccess(detail: GameDetail) {
        view?.bind(detail: detail)
    }
    
    func fetchGameDetailFail(error: String) {
        view?.showError(message: error)
    }
    
    func fetchFavoriteGamesSuccess(favorites: [Game]) {
        view?.setFavoriteState(isFavorite: favorites.contains(
            where: { entity in
                entity.id == game.id
            })
        )
    }
}
