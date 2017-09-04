//
//  GetNewsTitlesRequest.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class GetNewsTitlesRequest: Request<[NewsModel]> {
    override init() {
        super.init()
        self.url = Constants.baseUrl.rawValue + "/news"
    }
    
    override func map(_ data: Data) -> [NewsModel] {
        var out = [NewsModel]()
        guard
            let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any],
            let resultCode = json["resultCode"] as? String,
            resultCode == "OK",
            let payload = json["payload"] as? [[String: Any]]
            else { return out }
        
        out = payload.map({ (rawModel) -> NewsModel in
            guard
                let title = rawModel["text"] as? String,
                let id = rawModel["id"] as? String,
                let publicationDate = rawModel["publicationDate"] as? [String: Int],
                let milliseconds = publicationDate["milliseconds"] else {
                    print("Parsing error on get news titles request")
                    return NewsModel(id: "Err", title: "Err", date: Date(), text: nil)
            }
            
            let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
            return NewsModel(id: id, title: title, date: date, text: nil)
        })
        
        return out
    }
}
