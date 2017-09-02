//
//  NewsTitleTableViewCell.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 27.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import UIKit

protocol NewsTitleView {
    func fill(data: NewsViewData)
}

class NewsTitleTableViewCell: UITableViewCell, NewsTitleView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func fill(data: NewsViewData) {
        titleLabel.text = data.title
        dateLabel.text = data.date
    }
}
