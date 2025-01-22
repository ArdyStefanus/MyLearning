//
//  HomeTabBarController.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 21/01/25.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabbar()
    }
    
    func setupTabbar() {
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        let tabHomeItem = UITabBarItem(title: "Beranda", image: #imageLiteral(resourceName: "tabbar beranda"), selectedImage: #imageLiteral(resourceName: "tabbar beranda selected"))
        let tabAkunFavorit = UITabBarItem(title: "Favorit", image: #imageLiteral(resourceName: "tabbar favorite"), selectedImage: #imageLiteral(resourceName: "tabbar favorite selected"))
        let tabAkunItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "tabbar akun"), selectedImage: #imageLiteral(resourceName: "tabbar akun selected"))
        self.tabBar.tintColor = #colorLiteral(red: 0.9179999828, green: 0.125, blue: 0.2119999975, alpha: 1)
        
        self.viewControllers = [
            createNavController(for: TabListGimVC(), tabbarItem: tabHomeItem),
            createNavController(for: TabFavoritVC(), tabbarItem: tabAkunFavorit),
            createNavController(for: TabAkunVC(), tabbarItem: tabAkunItem)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, tabbarItem: UITabBarItem) -> UIViewController {
        // if want to change the view become root in the future, use below
        //        let navController = UINavigationController(rootViewController: rootViewController)
        let navController = rootViewController
        navController.tabBarItem = tabbarItem
        return navController
    }
}
