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
    
    @IBOutlet weak var webView: UIWebView!

    func fill(info: NewsModel) {
        webView.loadHTMLString(info.text!, baseURL: nil)
    }
    
    override func viewDidLoad() {
        presenter?.reload()
    }
}
