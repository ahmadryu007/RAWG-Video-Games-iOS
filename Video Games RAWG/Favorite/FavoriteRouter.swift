//
//  FavoriteRouter.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation

final class FavoriteRouter: FavoriteRouterInterface {
    
    let view: FavoriteViewController
    
    init() {
        view = FavoriteViewController(
            nibName: String(describing: FavoriteViewController.self),
            bundle: Bundle(for: HomeViewController.self)
        )
        
        let interactor = FavoriteInteractor()
        let presenter = FavoritePresenter(view: view, interactor: interactor, router: self)
        view.presenter = presenter
        interactor.presenter = presenter
    }
}
