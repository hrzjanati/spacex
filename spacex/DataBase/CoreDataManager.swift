//
//  CoreDataManager.swift
//  spacex
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 9/5/22.
//

import Foundation
import CoreData
import SwiftUI

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    private var viewContext = PersistenceController.shared.container.viewContext
    
    func addIDInCoreData(id : UUID) {
        let bookMarkDB = BookMark(context: self.viewContext)
        bookMarkDB.idUUID = id
        saveContext()
    }
    
    func fetchBookMarkID() -> [BookMark] {
        var result = [BookMark]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"BookMark")
        do {
            if let all = try viewContext.fetch(request) as? [BookMark] {
                result = all
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }
    
    /// Retrieve all records of  given DataBase Table class
    /// - Parameters:
    ///   - entity: Model
    ///   - predicate: qury
    ///   - sortDescriptor: sort Model
    /// - Returns: objectes from table
    func retrieveAll<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptor
        do {
            let values = try viewContext.fetch(request)
            return values
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

}

extension CoreDataManager {
    // MARK: - SAVE
  private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
