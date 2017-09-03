//
//  News.swift
//  TinkoffNews
//
//  Created by Aleksandr X on 02.09.17.
//  Copyright © 2017 Khlebnikov. All rights reserved.
//

import Foundation
import CoreData

protocol Cashable {
    mutating func fetch()
    func save()
    func delete()
}

struct NewsModel {
    var id: String
    var title: String
    var date: Date
    var text: String?

}

extension NewsModel: Cashable {
    func save() {
        let context = CoreDataManager.shared.context
        let entityDescription = CoreDataManager.shared.entityForName(string: "News")
        let predicate = NSPredicate(format: "%K == %@", "id", id)
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        fetchRequest.predicate = predicate
        let queue = DispatchQueue(label: "save", qos: .default)
        queue.sync {
            do{
                if let result = try context.fetch(fetchRequest).first {
                    context.delete(result)
                }
            } catch {
                print(error)
            }
        }
        
        let managedObject = NSManagedObject(entity: entityDescription!, insertInto: context)
        
        managedObject.setValue(self.id, forKey: "id")
        managedObject.setValue(self.title, forKey: "title")
        managedObject.setValue(self.text, forKey: "text")
        managedObject.setValue(self.date, forKey: "date")

    }

    mutating func fetch() {
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        let predicate = NSPredicate(format: "%K == %@", "id", id)
        fetchRequest.predicate = predicate
        let context = CoreDataManager.shared.context
        do {
            if let result = try context.fetch(fetchRequest).first {
                self.title = result.title ?? ""
                self.text = result.text ?? ""
                self.date = result.date as Date? ?? Date()
            }
        } catch {
            print(error)
        }
    }
    
    func delete() {
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        let predicate = NSPredicate(format: "%K == %@", "id", id)
        fetchRequest.predicate = predicate
        let context = CoreDataManager.shared.context
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                CoreDataManager.shared.context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}
