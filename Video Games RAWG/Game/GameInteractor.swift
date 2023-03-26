//
//  GameInteractor.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import Foundation
import UIKit.UIApplication
import CoreData

final class GameInteractor {
    weak var presenter: GameInteractorOutputInterface?
}

extension GameInteractor: GameInteractorInterface {
    func fetchGameDetailBy(id: Int) {
        let request = URLRequest(url: URL(string: "\(Constant.gameUrl)/\(id)?key=\(Constant.apiKey)")!)
        let task = URLSession.shared.dataTask(with: request) { data, response , error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let gameDetail = try decoder.decode(GameDetail.self, from: data)
                    self.presenter?.fetchGameDetailSuccess(detail: gameDetail)
                } catch let error {
                    print(String(describing: error))
                    self.presenter?.fetchGameDetailFail(error: error.localizedDescription)
                }
                
            } else if let error = error {
                self.presenter?.fetchGameDetailFail(error: error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
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
        
        
        self.presenter?.fetchFavoriteGamesSuccess(favorites: favorites)
    }
    
    func addToFavorite(game: Game) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "FavoriteGames", in: managedContext)
        let insert = NSManagedObject(entity: favoriteEntity!, insertInto: managedContext)
        
        insert.setValue(game.id, forKey: "id")
        insert.setValue(game.name, forKey: "name")
        insert.setValue(game.released, forKey: "released")
        insert.setValue(game.rating, forKey: "rating")
        insert.setValue(game.backgroundImage, forKey: "backgroundImage")
        
        do {
            try managedContext.save()
        } catch let err{
            print(err)
        }
    }
    
    func removeFromFavorite(game: Game) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteGames")
        fetchRequest.predicate = NSPredicate(format: "id = %i", game.id ?? 0)
        
        do {
            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
            managedContext.delete(dataToDelete)
            
            try managedContext.save()
        } catch let err{
            print(err)
        }
    }
}
