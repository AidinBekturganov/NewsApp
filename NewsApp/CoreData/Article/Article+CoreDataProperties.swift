//
//  Article+CoreDataProperties.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 4/4/24.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var publicationDate: String?
    @NSManaged public var descriptionOfArticle: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var authorOfArticle: String?

}

extension Article : Identifiable {

}
