//
//  GetDetails.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class GetDetailsRequest: Request<NewsModel> {
    var id: String
    init(id: String) {
        self.id = id
        super.init()
        
        self.url = Constants.baseUrl.rawValue + "/news_content?id=\(self.id)"
    }
    
    override func map(_ data: Data) -> NewsModel {
        guard
            let json = try! JSONSerialization.jsonObject(with: data) as? [String: Any],
            let resultCode = json["resultCode"] as? String,
            resultCode == "OK",
            let payload = json["payload"] as? [String: Any],
            let titleJson = payload["title"] as? [String: Any],
            let id = titleJson["id"] as? String,
            let title = titleJson["text"] as? String,
            let content = payload["content"] as? String,
            let publicationDate = titleJson["publicationDate"] as? [String: Int],
            let milliseconds = publicationDate["milliseconds"] else {
                print("Error parsing NewsModel data on get details request")
                return NewsModel(id: "", title: "", date: Date(), text: "")
        }

        let date = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
        return NewsModel(id: id, title: title, date: date, text: content)
    }
}
