//
//  NewsListPresenter.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 27.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation
import UIKit

class NewsListPresenter {
    private let newsService: NewsServiceProtocol!
    private var newsListView: NewsListView?
    private var newsStore: NewsStoreProtocol?
    
    private var sortedNewsList: [NewsModel]? {
        didSet {
            if sortedNewsList != nil{
                newsStore?.set(news: sortedNewsList!)
                self.showNewsList(newsList: sortedNewsList!)
            }
        }
    }
    var provider: Provider?
    
    init(view: NewsListView, newsService: NewsServiceProtocol) {
        self.newsService = newsService
        self.newsListView = view
        
        self.newsStore = NewsStore()
    }
    
    @objc func update() {
        
//        newsStroe?.clear()
        newsListView?.startLoading()

        
        if let storedNews = newsStore?.getNews() {
            if storedNews.count > 0 {
                self.sortedNewsList = storedNews
            }
        }
        
        newsService.getNewsTitlesList()
            .onSuccess {[weak self] (newsList) in
                self?.sortedNewsList = newsList.sorted(by: { (firstData, secondData) -> Bool in
                    return firstData.date > secondData.date
                })
            }.resume()
    }
    
    private func showNewsList(newsList: [NewsModel]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let listCellsModels = newsList.map({ NewsViewData(title: $0.title,
                                                          date: dateFormatter.string(from:$0.date))})
        self.newsListView?.stopLoading()
        OperationQueue.main.addOperation {
            self.newsListView?.set(titles: listCellsModels)
        }
        
    }

    
    func selectNews(withIndex index: Int) {
        if let sortedNewsList = self.sortedNewsList {
            let news = sortedNewsList[index]
            provider?.openNewsVC(with: news)
        }
    }
    
}
