//
//  ViewController.swift
//  Photo
//
//  Created by  Shadow on 26.11.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit
import Alamofire



class MainVC: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    
    @IBOutlet weak var textFromClipBoard: UITextField!
    
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnURL: UIButton!
    @IBOutlet weak var btnTags: UIButton!
    
    

    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGallery.frame.origin.x = -500
        btnURL.frame.origin.x = 500
        btnTags.frame.origin.x = -500
        

        setupCGIElement(object: btnGallery)
        setupCGIElement(object: btnURL)
        setupCGIElement(object: btnTags)
        
    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 0.7) {
            self.btnGallery.frame.origin.x = self.view.frame.origin.x
        }

        UIView.animate(withDuration: 0.7) {
            self.btnURL.frame.origin.x = self.view.frame.origin.x
        }
        
        UIView.animate(withDuration: 0.7) {
            self.btnTags.frame.origin.x = self.view.frame.origin.x
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        btnGallery.frame.origin.x = -500
        btnURL.frame.origin.x = 500
        btnTags.frame.origin.x = -500
    }
    
    
    
    @IBAction func onSelectFromLibraryTapped(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageFromPC = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        photoData = UIImageJPEGRepresentation(imageFromPC, 1)
        
        let newURL = info [UIImagePickerControllerImageURL]
        
        photoLocalURL = String (describing: newURL)
        
        selectedImage = imageFromPC
        
        
        guard let fileUrl = info[UIImagePickerControllerImageURL] as? URL else { return }
        
        self.dismiss(animated: true, completion: {
        self.performSegue(withIdentifier: "ShowPhoto", sender: self)
        })
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
} // global end


