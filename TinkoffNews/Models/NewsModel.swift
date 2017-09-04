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
    private var newsFetchRequest: NSFetchRequest<News> {
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        let predicate = NSPredicate(format: "%K == %@", "id", id)
        fetchRequest.predicate = predicate
        return fetchRequest
    }
    
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.context
    }
    
    func save() {
        if exists() {
            updateIfNeeded()
            return
        }
        createNew()
    }
    
    private func createNew() {
        if let entityDescription = CoreDataManager.shared.entityForName(string: "News") {
            let managedObject = News(entity: entityDescription, insertInto: context)
            
            managedObject.id = self.id
            managedObject.title = self.title
            managedObject.text = self.text
            managedObject.date = self.date as NSDate
        }
    }
    
    private func exists() -> Bool {
        do{
            if let _ = try context.fetch(newsFetchRequest).first {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    private func updateIfNeeded() {
        do{
            if let result = try context.fetch(newsFetchRequest).first {
                if result.text == nil && self.text != nil {
                    result.text = text
                    CoreDataManager.shared.saveContext()
                }
            }
        } catch {
            print(error)
        }
    }

    mutating func fetch() {
        do {
            if let result = try context.fetch(newsFetchRequest).first {
                self.id = result.id ?? ""
                self.title = result.title ?? ""
                self.text = result.text
                self.date = result.date as Date? ?? Date()
            }
        } catch {
            print(error)
        }
    }
    
    func delete() {
        do {
            let results = try context.fetch(newsFetchRequest)
            for result in results {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}
