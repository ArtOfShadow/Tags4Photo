//
//  DesignConfig.swift
//  Photo
//
//  Created by  Shadow on 11.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit



func setupCGIElement (object: AnyObject){
    let radius: CGFloat = 10
    let borderColor: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let borderWidth: CGFloat = 1
    
    object.layer.cornerRadius = radius
    object.layer.borderColor = borderColor
    object.layer.borderWidth = borderWidth
    object.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}


