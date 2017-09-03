//
//  NewsStoreProtocol.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

protocol NewsStoreProtocol {
    func getNews() -> [NewsModel]
    func set(news: [NewsModel])
    func clear()
}
