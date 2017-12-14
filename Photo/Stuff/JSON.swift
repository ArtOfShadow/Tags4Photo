//
//  POSTRequest.swift
//  Photo
//
//  Created by  Shadow on 26.11.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import Foundation

struct GetJSON: Codable {
    let status: Int?
    //let tags: [String]?
    let tags: [Int:String]?
}
