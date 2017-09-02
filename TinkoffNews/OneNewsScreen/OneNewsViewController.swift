//
//  OneNewsViewController.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 30.08.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import UIKit

class OneNewsViewController: UIViewController, OneNewsView {
    
    var presenter: OneNewsPresenter?
    
    @IBOutlet weak var textView: UITextView!

    func fill(info: NewsModel) {
        textView.text = info.text
    }
    
    override func viewDidLoad() {
        presenter?.reload()
    }
}
