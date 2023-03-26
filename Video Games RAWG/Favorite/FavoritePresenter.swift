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
    
    init(view: FavoriteViewInterface, interactor: FavoriteInteractorInterface, router: FavoriteRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FavoritePresenter: FavoriteInteractorOuputInterface {
    
}
