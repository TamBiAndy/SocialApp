//
//  TabBarController.swift
//  SocialApp
//
//  Created by Andy on 04/10/2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        let firstVC = HomeViewController()
        firstVC.tabBarItem.image = UIImage(named: "Home copy", in: Bundle(for: TabBarController.self), compatibleWith: nil)
        firstVC.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -35, right: 0);
        let homeNav = UINavigationController(rootViewController: firstVC)
        homeNav.viewControllers
        
        let secondVC = DiscoverViewController()
        secondVC.tabBarItem.image = UIImage(named: "Category copy", in: Bundle(for: TabBarController.self), compatibleWith: nil)
        secondVC.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -35, right: 0);
        let discoveryNavi = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = NotificationViewController()
        thirdVC.tabBarItem.image = UIImage(named: "Notification copy", in: Bundle(for: TabBarController.self), compatibleWith: nil)
        thirdVC.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -35, right: 0);
        let notiNavi = UINavigationController(rootViewController: thirdVC)
        
        let fourthVC = UserProfileViewController()
        fourthVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile 1"), selectedImage: UIImage(named: "Profile"))
        fourthVC.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: -35, right: 0);
        let userNavi = UINavigationController(rootViewController: fourthVC)
        
        viewControllers = [homeNav, discoveryNavi, notiNavi, userNavi]
        
        if #available(iOS 13.0, *) {
            tabBar.isTranslucent = false
            tabBar.barTintColor = .white
            tabBar.tintColor = .init(hexString: "5151C6")
            tabBar.backgroundColor = .white
            tabBar.unselectedItemTintColor = UIColor(hexString: "BDBDBD")
//            tabBar.standardAppearance = appearance
        } else {
            // Đối với các phiên bản trước iOS 13
            tabBar.barTintColor = .white
            tabBar.tintColor = UIColor(hexString: "5151C6")
            tabBar.unselectedItemTintColor = UIColor(hexString: "BDBDBD")
        }
    }
}
