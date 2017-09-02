//
//  GetDetails.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class GetDetails: Request<NewsModel> {
    var id: String
    init(id: String) {
        self.id = id
        super.init()
        
        self.url = "https://api.tinkoff.ru/v1/news_content?id=\(self.id)"
    }
    
    override func map(_ data: Data) -> NewsModel {
        guard
            let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any],
            let resultCode = json["resultCode"] as? String,
            resultCode == "OK",
            let payload = json["payload"] as? [String: Any]
            else {
                return NewsModel(id: "", title: "", text: "")
        }
        
        let titleJson = payload["title"] as! [String: Any]
        let id = titleJson["id"] as! String
        let title = titleJson["text"] as! String
        let content = payload["content"] as! String
        
        return NewsModel(id: id, title: title, text: content)
    }
}
