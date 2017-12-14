//
//  FromURLModel.swift
//  Photo
//
//  Created by  Shadow on 11.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit

func showAchtung (view: UIViewController, message: String){
    let alert = UIAlertController(title: "Achtung!", message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Ok!", style: .default)
    
    alert.addAction(cancelAction)
    view.present(alert, animated: true, completion: nil)
}

