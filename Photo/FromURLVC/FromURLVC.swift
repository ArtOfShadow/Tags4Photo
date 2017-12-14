//
//  FromURLVC.swift
//  Photo
//
//  Created by  Shadow on 11.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit

class FromURLVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldForURL: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var textFieldURL: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCGIElement(object: btnBack)
        setupCGIElement(object: btnSubmit)
        setupCGIElement(object: textFieldURL)
        
        
        textFieldForURL.delegate = self
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -50
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector (didTapView))
        
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    @objc func didTapView(){
        
        self.view.endEditing(true)
        
    }
    
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        
        sendURLFromTextField ()

        return true
    }
    
    
    
    func sendURLFromTextField (){
        if !(textFieldForURL.text?.isEmpty)! {
            if (textFieldForURL.text?.trimmingCharacters(in: .whitespacesAndNewlines)) != nil
            {
                if let strURL = textFieldForURL.text {
                    if let imgURL = URL(string: strURL) {
                    //TODO: проверить на пустую ссылку
                        if let urlContents = try? Data(contentsOf: imgURL) {
                            if let image = UIImage(data: urlContents){
                                selectedImage = image
                                textFieldForURL.resignFirstResponder()
                                photoData = urlContents
                            
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "ShowPhotoFromURL", sender: self)
                                }
                        } else { showAchtung(view: self, message: "Uncorrect picture") }
                    } else {
                        showAchtung(view: self, message: "Enter correct url. Or picture is unaccessible")
                    }
                    }else {
                        showAchtung(view: self, message: "Enter correct url.. Or picture is unaccessible")
                    }
            }
        } else {
            showAchtung (view: self, message: "The url can't be empty!")
        }
    }
    }
    
    
    
    @IBAction func onSendBtnTap(_ sender: UIButton) {
        sendURLFromTextField ()
    }
    
    
    @IBAction func onBackBtnTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
