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
    private var newsStroe: NewsStoreProtocol?
    
    private var sortedNewsList: [NewsModel]?
    var provider: Provider?
    
    init(view: NewsListView, newsService: NewsServiceProtocol) {
        self.newsService = newsService
        self.newsListView = view
        
        self.newsStroe = NewsStore()
    }
    
    @objc func update() {
        
//        newsStroe?.clear()
        newsListView?.startLoading()

        
        if let storedNews = newsStroe?.getNews() {
            self.showNewsList(newsList: storedNews)
        }
        
        newsService.getNewsTitlesList()
            .onSuccess {[weak self] (newsList) in
                
                self?.sortedNewsList = newsList.sorted(by: { (firstData, secondData) -> Bool in
                    return firstData.date > secondData.date
                })
                
                self?.newsStroe?.set(news: self!.sortedNewsList!)

                self?.showNewsList(newsList: self!.sortedNewsList!)
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
        let id = sortedNewsList![index].id
        provider?.openNews(withId: id)
    }
    
}
