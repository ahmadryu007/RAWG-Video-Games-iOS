//
//  HomePresenter.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class HomePresenter: HomePresenterInterface {
    private weak var view: HomeViewInterface?
    private let interactor: HomeInteractorInterface
    private let router: HomeRouterInterface
    
    var games: [Game] = []
    private var nextUrl: String?
    
    init(view: HomeViewInterface, interactor: HomeInteractorInterface, router: HomeRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loadGames() {
        view?.showLoading()
        interactor.fetchGames(query: nil, loadUrl: nextUrl)
    }
    
    func searchGame(query: String) {
        nextUrl = nil
        games.removeAll()
        interactor.fetchGames(query: query, loadUrl: nil)
    }
    
    func selectAt(index: Int) {
        router.goToDetail(game: games[index])
    }
}

extension HomePresenter: HomeInteractorOutputInterface {
    func fetchGamesSuccess(games: Games) {
        self.games.append(contentsOf: games.results ?? [])
        self.nextUrl = games.next
        view?.reloadData()
    }
    
    func fetchGamesFail(error: String) {
        view?.showError(text: error)
    }
    
    
}
