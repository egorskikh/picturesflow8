//
//  TabBarController.swift
//  picturesflow8
//
//  Created by Егор Горских on 18.03.2021.
//

import UIKit

public class TabBarController: UITabBarController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
    
    
    private func setupNavigationController() {
        let randomPhVС = RandomPhCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        viewControllers = [
            UITabBarController.generateNavigationController(rootVC: randomPhVС,
                                                            title: "Random",
                                                            systemImage: "eyeglasses")
        ]
    }
    
    
}

private extension UITabBarController {
    
    static func generateNavigationController(rootVC: UIViewController,
                                             title: String,
                                             systemImage: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: systemImage)
        
        return navigationVC
    }
    
}

