//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 4/4/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "NewsApp")
        
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    func addArticle(publicationDate: String, title: String, desc: String, imageURL: String) {
        
        for article in getAllArticles() {
            if article.title == title {
                return
            }
        }
        
        let newArticle = Article(context: viewContext)
        
        newArticle.title = title
        newArticle.descriptionOfArticle = desc
        newArticle.imageURL = imageURL
        newArticle.publicationDate = publicationDate
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllArticles() -> [Article] {
        let request = NSFetchRequest<Article>(entityName: "Article")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteArticles(article: Article) {
        viewContext.delete(article)
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
