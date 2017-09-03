//
//  NewsStore.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation
import CoreData

class NewsStore: NewsStoreProtocol {
    func set(news: [NewsModel]) {
        for oneNews in news {
            oneNews.save()
        }
    }
    
    func clear() {
        let models = getNews()
        
        for model in models {
            model.delete()
        }
    }

    func getNews() -> [NewsModel] {
        var news = [NewsModel]()
        let request = NSFetchRequest<News>(entityName: "News")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            let results = try CoreDataManager.shared.context.fetch(request)
            news = results.map({ (coreDataNews) -> NewsModel in
                return NewsModel(id: coreDataNews.id!,
                                 title: coreDataNews.title!,
                                 date: coreDataNews.date! as Date,
                                 text: coreDataNews.text)
            })
        } catch {
            print(error)
        }
        return news
    }
}
