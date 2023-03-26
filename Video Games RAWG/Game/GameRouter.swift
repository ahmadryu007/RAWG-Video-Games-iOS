//
//  GameRouter.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class GameRouter: GameRouterInterface {
    var view: GameViewController!
    
    init(game: Game) {
        view = GameViewController(
            nibName: String(describing: GameViewController.self),
            bundle: Bundle(for: GameViewController.self)
        )
        
        let interactor = GameInteractor()
        let presenter = GamePresenter(view: view, interactor: interactor, router: self, game: game)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}
