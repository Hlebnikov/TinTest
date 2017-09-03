//
//  OneNewsPresenter.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 30.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class OneNewsPresenter {
    private var view: OneNewsView!
    private var newsService: NewsServiceProtocol!
    
    var newsId: String?
    
    init(view: OneNewsView, newsService: NewsServiceProtocol, newsId: String) {
        self.view = view
        self.newsService = newsService
        self.newsId = newsId
    }
    
    func reload() {
        guard let newsId = newsId else {return}
        
        newsService
            .getDetails(forNewsWithId: newsId)
            .onSuccess { (news) in
            OperationQueue.main.addOperation {
                self.view.fill(info: news)
            }
        }.resume()

    }
}
