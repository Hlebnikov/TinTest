//
//  NewsListPresenter.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 27.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class NewsListPresenter {
    private let newsService: NewsServiceProtocol!
    private var newsListView: NewsListView?
    
    private var sortedNewsList: [NewsTitleModel]?
    var provider: Provider?
    
    init(view: NewsListView, newsService: NewsServiceProtocol) {
        self.newsService = newsService
        self.newsListView = view        
    }
    
    @objc func update() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        newsListView?.startLoading()
        newsService.getNewsTitlesList()
            .onSuccess {[weak self] (newsList) in
                self?.sortedNewsList = newsList.sorted(by: { (firstData, secondData) -> Bool in
                    return firstData.date > secondData.date
                })
                if let listCellsModels = self?.sortedNewsList!.map({ NewsViewData(title: $0.title, date: dateFormatter.string(from:$0.date))}) {
                    self?.newsListView?.stopLoading()
                    OperationQueue.main.addOperation {
                        self?.newsListView?.set(titles: listCellsModels)
                    }
                }
            }.resume()
    }
    
    func selectNews(withIndex index: Int) {
        let id = sortedNewsList![index].id
        provider?.openNews(withId: id)
    }
    
    func newsModel(withId id: Int) -> NewsTitleModel {
        return NewsTitleModel(id: "10", title: "news", date: Date())
    }
}
