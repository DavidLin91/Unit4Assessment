//
//  FlashCardsTBC.swift
//  Unit4Assessment
//
//  Created by David Lin on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class FlashCardsTBC: UITabBarController {
    
    private lazy var flashCardsVC: FlashCardsVC = {
        let viewController = FlashCardsVC()
        viewController.tabBarItem  = UITabBarItem(title: "Flash Cards", image: UIImage(systemName: "doc.plaintext"), tag: 0)
        return viewController
    }()
    
    private lazy var createVC: CreateVC = {
        let viewController = CreateVC()
        viewController.tabBarItem  = UITabBarItem(title: "Create", image: UIImage(systemName: "pencil.tip.crop.circle"), tag: 0)
        return viewController
    }()
    
    private lazy var searchVC: SearchVC = {
        let viewController = SearchVC()
        viewController.tabBarItem  = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: flashCardsVC),
        UINavigationController(rootViewController: createVC),
        UINavigationController(rootViewController: searchVC)]
    }
    

}
