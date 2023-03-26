//
//  FavoritePresenter.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class FavoritePresenter: FavoritePresenterInterface {
    private weak var view: FavoriteViewInterface?
    private let interactor: FavoriteInteractorInterface
    private let router: FavoriteRouterInterface
    var games: [Game] = []
    
    init(view: FavoriteViewInterface, interactor: FavoriteInteractorInterface, router: FavoriteRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadFavoriteGame() {
        interactor.fetchFavoriteGames()
    }
    
    func selectAt(index: Int) {
        router.goToDetail(game: games[index])
    }
}

extension FavoritePresenter: FavoriteInteractorOuputInterface {
    func loadFavoriteGameSuccess(games: [Game]) {
        self.games = games
        view?.reloadData()
    }
    
    func loadFavoriteGameFail(error: String) {
        view?.showError(message: error)
    }
}
