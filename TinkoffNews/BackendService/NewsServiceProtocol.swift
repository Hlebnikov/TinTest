//
//  NewsServiceProtocol.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 29.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation


protocol NewsServiceProtocol {
    func getNewsTitlesList() -> Request<[NewsModel]>
    func getDetails(forNewsWithId id: String) -> Request<NewsModel>
}
