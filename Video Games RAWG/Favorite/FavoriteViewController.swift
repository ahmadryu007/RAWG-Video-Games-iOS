//
//  FavoriteViewController.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit

final class FavoriteViewController: UIViewController {

    var presenter: FavoritePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FavoriteViewController: FavoriteViewInterface {
    
}
