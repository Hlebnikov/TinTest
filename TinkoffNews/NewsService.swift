//
//  NewsService.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 29.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class NewsService: NewsServiceProtocol {
        
    func getNewsTitlesList() -> Request<[NewsTitleModel]> {
        return GetNewsTitlesRequest()
    }
    
    func getDetails(forNewsWithId id: String) -> Request<NewsModel> {
        return GetDetails(id: id)
    }
}
