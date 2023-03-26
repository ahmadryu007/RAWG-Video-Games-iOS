//
//  ViewController.swift
//  Video Games RAWG
//
//  Created by klikdokter on 26/03/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let homeViewController = HomeRouter().view
        let favoriteViewController = FavoriteRouter().view
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        
        viewControllers = [homeViewController, favoriteViewController]
        tabBar.backgroundColor = .white
    }


}

