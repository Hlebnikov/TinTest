//
//  NewsServiceProtocol.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 29.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

struct NewsModel {
    var id: String
    var title: String
    var text: String
}

struct NewsTitleModel {
    var id: String
    var title: String
    var date: Date
}

protocol NewsServiceProtocol {
    func getNewsTitlesList() -> Request<[NewsTitleModel]>
    func getDetails(forNewsWithId id: String) -> Request<NewsModel>
}
