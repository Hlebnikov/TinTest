//
//  GetNewsTitlesRequest.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class GetNewsTitlesRequest: Request<[NewsTitleModel]> {
    override init() {
        super.init()
        self.url = "https://api.tinkoff.ru/v1/news"
    }
    
    override func map(_ data: Data) -> [NewsTitleModel] {
        var out = [NewsTitleModel]()
        guard
            let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any],
            let resultCode = json["resultCode"] as? String,
            resultCode == "OK",
            let payload = json["payload"] as? [[String: Any]]
            else { return out }
        
        out = payload.map({ (rawModel) -> NewsTitleModel in
            let title = rawModel["text"] as! String
            let id = rawModel["id"] as! String
            let date = Date(timeIntervalSince1970: TimeInterval((rawModel["publicationDate"] as! [String: Int])["milliseconds"]! / 1000))
            return NewsTitleModel(id: id, title: title, date: date)
        })
        
        return out
    }
}
