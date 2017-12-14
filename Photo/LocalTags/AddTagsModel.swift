//
//  AddTagsModel.swift
//  Photo
//
//  Created by  Shadow on 10.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit
import CoreData

//var tags: [NSManagedObject] = []
//
//func saveTags(name: String) {
//    
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//    let managedContext = appDelegate.persistentContainer.viewContext
//    let entity = NSEntityDescription.entity(forEntityName: "Tags",  in: managedContext)!
//    let tag = NSManagedObject(entity: entity, insertInto: managedContext)
//    tag.setValue(name, forKeyPath: "text")
//    
//    do {
//        try managedContext.save()
//        tags.append(tag)
//    } catch let error as NSError {
//        print("Could not save. \(error), \(error.userInfo)")
//    }
//}
//
//
//func loadTags(){
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//    
//    let managedContext = appDelegate.persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tags")
//    do {
//        tags = try managedContext.fetch(fetchRequest)
//    } catch let error as NSError {
//        print("Could not fetch. \(error), \(error.userInfo)")
//    }
//}
//
//














