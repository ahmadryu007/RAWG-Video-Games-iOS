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
}

protocol GameInteractorOutputInterface: AnyObject {
    func fetchGameDetailSuccess(detail: GameDetail)
    func fetchGameDetailFail(error: String)
}

protocol GameInteractorInterface: AnyObject {
    func fetchGameDetailBy(id: Int)
}

protocol GameViewInterface: AnyObject {
    func bind(detail: GameDetail)
    func showError(message: String)
}
