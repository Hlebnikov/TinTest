//
//  NewsListView.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 27.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

struct NewsViewData {
    var title: String
    var date: String
}

protocol NewsListView {
    var presenter: NewsListPresenter? { get set }
    
    func startLoading()
    func stopLoading()
    func set(titles: [NewsViewData])
}
