//
//  ToDoItems.swift
//  Todo
//
//  Created by Drole on 10/05/21.
//

import Foundation
import CoreData

class ToDoItems: NSManagedObject,Identifiable {
    @NSManaged var name: String?
    @NSManaged var createdAt: Date?
}

extension ToDoItems {
    static func getAllToDoItems() -> NSFetchRequest<ToDoItems> {
    let request : NSFetchRequest<ToDoItems> =
        ToDoItems.fetchRequest() as!
        NSFetchRequest<ToDoItems>
        
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        
        request.sortDescriptors = [sort]
        
        return request
    }
}
