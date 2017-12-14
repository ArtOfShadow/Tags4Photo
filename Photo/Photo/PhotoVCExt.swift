//
//  PhotoVCExt.swift
//  Photo
//
//  Created by  Shadow on 14.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import Foundation
import CoreData

extension PhotoVC {
    func load (completion: (_ complete: Bool)->()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchResult = NSFetchRequest<Tags>(entityName: "Tags")
        
        do {
            localTags = try managedContext.fetch(fetchResult)
            completion(true)
            print("loaded \(localTags.count) tags!")
        } catch {
            debugPrint("Could'nt fetch. \(error.localizedDescription)")
            completion(false)
        }
    }

}
