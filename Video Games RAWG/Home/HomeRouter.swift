//
//  HomeRouter.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class HomeRouter: HomeRouterInterface {
    
    let view: HomeViewController
    
    init() {
        view = HomeViewController(
            nibName: String(describing: HomeViewController.self),
            bundle: Bundle(for: HomeViewController.self)
        )
        
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor, router: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
    func goToDetail(game: Game) {
        view.navigationController?.pushViewController(
            GameRouter(game: game).view,
            animated: true
        )
    }
}
