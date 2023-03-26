//
//  FavoriteInteractor.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation
import UIKit.UIApplication
import CoreData

final class FavoriteInteractor {
    weak var presenter: FavoriteInteractorOuputInterface?
}

extension FavoriteInteractor: FavoriteInteractorInterface {
    func fetchFavoriteGames() {
        var favorites: [Game] = []
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGames")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            result.forEach{ favorite in
                var game = Game()
                game.id = favorite.value(forKey: "id") as? Int
                game.name = favorite.value(forKey: "name") as? String
                game.backgroundImage = favorite.value(forKey: "backgroundImage") as? String
                game.rating = favorite.value(forKey: "rating") as? Double
                game.released = favorite.value(forKey: "released") as? String
                
                favorites.append(game)
            }
        } catch let err{
            print(err)
        }
        
        self.presenter?.loadFavoriteGameSuccess(games: favorites)
    }
}
