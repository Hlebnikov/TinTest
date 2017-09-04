//
//  OneNewsView.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 30.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

protocol OneNewsView {
    var presenter: OneNewsPresenter? { get set }
    
    func fill(info: NewsModel)
}
