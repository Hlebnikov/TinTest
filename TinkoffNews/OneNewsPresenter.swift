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
    private var newsStore: NewsStoreProtocol?
    private var news: NewsModel!
    
    init(view: OneNewsView, newsService: NewsServiceProtocol, newsStore: NewsStoreProtocol, news: NewsModel) {
        self.view = view
        self.newsService = newsService
        self.news = news
        self.newsStore = newsStore
    }
    
    func reload() {
        news.fetch()
        if news.text != nil {
            self.view.fill(info: news)
        } else {
            newsService
                .getDetails(forNewsWithId: news.id)
                .onSuccess { (news) in
                    OperationQueue.main.addOperation {
                        self.view.fill(info: news)
                    }
                    news.save()
                }.resume()
        }
    }
}
