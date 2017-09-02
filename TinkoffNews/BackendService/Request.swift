//
//  Request.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation

class Request<ResponseType> {
    var url: String?
    var onSuccessBlock: ((ResponseType) -> ())?
    var onErrorBlock: ((Error) -> ())?
    
    func map(_ data: Data) -> ResponseType? {
        assertionFailure("Need to override")
        return nil
    }
}

extension Request {
    final func resume() {
        guard let url = URL(string: self.url ?? "") else {
            print("Url \(self.url ?? "n/a") is not valid")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                self.onSuccessBlock?(self.map(data)!)
            }
            
            if let error = error {
                self.onErrorBlock?(error)
            }
            }.resume()
    }
    
    final func onSuccess(_ block: @escaping (_ response: ResponseType) -> ()) -> Self {
        self.onSuccessBlock = block
        return self
    }
    
    final func onError(_ block: @escaping (_ error: Error) -> ()) -> Self {
        self.onErrorBlock = block
        return self
    }
}
