//
//  LocalTagsExt.swift
//  Photo
//
//  Created by  Shadow on 13.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit
import CoreData





func save (tag: String, completion: (_ complete: Bool)->()) {
    guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
    let setup = Tags (context: managedContext)
    setup.text = tag
    do {
        try managedContext.save()
        print("Successfully saved data")
        completion(true)
    } catch {
        debugPrint("could't save! Error : \(error.localizedDescription)")
        completion(false)
    }
}




extension LocalTagsVC {

    func load (completion: (_ complete: Bool)->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchResult = NSFetchRequest<Tags>(entityName: "Tags")
        
        do {
            localTags = try managedContext.fetch(fetchResult)
            completion(true)
        } catch {
            debugPrint("Could'nt fetch. \(error.localizedDescription)")
            completion(false)
        }
    }

    
    func remove () {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        localTags.forEach { idx in
            managedContext.delete(idx)
            do {
                try managedContext.save()
            } catch {
                debugPrint("Could'nt fetch. \(error.localizedDescription)")
            }
        }
    }
    
}
    


