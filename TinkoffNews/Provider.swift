//
//  Provider.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 30.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation
import UIKit

class Provider {
    
    private var navigationController: UINavigationController!
    private var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openNews(withId id: String) {
        let oneNewsVC = storyboard.instantiateViewController(withIdentifier: "newsDetails") as! OneNewsViewController
        oneNewsVC.presenter = OneNewsPresenter(view: oneNewsVC, newsService: NewsService())
        oneNewsVC.presenter?.newsId = id
        navigationController.show(oneNewsVC, sender: nil)
    }
}
