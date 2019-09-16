//
//  CoreDataBooks.swift
//  Google Books
//
//  Created by Lo Howard on 9/14/19.
//  Copyright © 2019 Lo Howard. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataBooks {
    
    static let shared = CoreDataBooks()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //lazy - late init - doesn't actually initialize the object until it is called
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Books")
        
        container.loadPersistentStores(completionHandler: { (storeDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
    }()
    
    func save(_ volumeInfo: VolumeInfo, image: UIImage) {
        
        checkBooks(volumeInfo)
        
        let entity = NSEntityDescription.entity(forEntityName: "BooksCD", in: context)!
        let coreBooks = BooksCD(entity: entity, insertInto: context)
        
        coreBooks.setValue(volumeInfo.title, forKey: "title")
        coreBooks.setValue(volumeInfo.authors.first, forKey: "authors")
        coreBooks.setValue(volumeInfo.volumeInfoDescription, forKey: "bookDescription")
        coreBooks.setValue(volumeInfo.averageRating, forKey: "averageRating")
        coreBooks.setValue(image.pngData()!, forKey: "image")
        
        saveContext()
        print("Book saved \(volumeInfo.title)")
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() -> [BooksCD] {
        let fetchRequest = NSFetchRequest<BooksCD>(entityName: "BooksCD")
        
        var books = [BooksCD]()
        
        do {
            books = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't Fetch Books: \(error.localizedDescription)")
        }
        
        print("Loaded \(books.count)")
        
        return books
    }
    
    func delete(_ books: BooksCD) {
        context.delete(books)
        print("Deleted books \(String(describing: books.title))")
        saveContext()
    }
    
    func checkBooks(_ volumeInfo: VolumeInfo) {
        let coreBooks = load().removeDuplicates()
        
        for books in coreBooks {
            if volumeInfo.title == books.title {
                delete(books)
                return
            }
        }
    }
}
