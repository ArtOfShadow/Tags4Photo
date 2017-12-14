//
//  AddTagsVC.swift
//  Photo
//
//  Created by  Shadow on 10.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit
import CoreData



let appDelegate = UIApplication.shared.delegate as? AppDelegate


class LocalTagsVC: UIViewController, UITextFieldDelegate, TagListViewDelegate {

    
    
    @IBOutlet weak var tagTexField: UITextField!
    @IBOutlet weak var listOfTags: TagListView!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load { (success) in
            print("Successfully load \(localTags.count) tags!")
            if localTags.count > 0 {
                // 1. Добавить таг из базы на экран
                // 2. Добавить таг из базы в массив тагов
                localTags.forEach { idx in
                    tagsPresentedAtView.append(idx.text!)
                    listOfTags.addTag(idx.text!)
                }
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTexField.delegate = self
        listOfTags.delegate =  self

        
        
        
        setupCGIElement (object: addBtn)
        setupCGIElement (object: backBtn)
        setupCGIElement (object: tagTexField)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -30
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector (didTapView))
        
        self.view.addGestureRecognizer(tapRecognizer)
        
        scroll.contentSize = CGSize (width: view.frame.width, height: view.frame.height)
    }
    
    
    
    @objc func didTapView(){
        self.view.endEditing(true)
    }
    
    
    
    
  
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onBackBtnTap(_ sender: UIButton) {
        // 1. удалить из базы старые
        remove()
        
        // 2. сохранить таги и выйти
        if tagsPresentedAtView.count > 0 {
            tagsPresentedAtView.forEach { tag in
                save(tag: tag, completion: { (success) in
                })
            }
        }
        
        tagsPresentedAtView.removeAll()
        dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if tagTexField.isFirstResponder {
            tagTexField.resignFirstResponder()
            
            addNewTag()
            
        }
        return true
    }
    
    // если текст не пустой,
    // то добавить таг в таглист (проверить на существование такого же тага)
    func addNewTag(){
        if !(tagTexField.text?.isEmpty)! {
            
            let newTag = tagTexField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if let addingTag = newTag {
                
                let capitalized = addingTag.capitalized
                let newString = "#" + capitalized.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    ///если в массиеве тагов на экране не содержится такой строки
                  if !tagsPresentedAtView.contains (newString) {
                    /// то вывести таг на экран
                    listOfTags.addTag(newString)
                    tagsPresentedAtView.append(newString)
                    print("new count of tagsPresentedAtView = \(tagsPresentedAtView)")
                    tagTexField.text = ""
                    } else { showAchtung (view: self, message: "Tag whith the same name is already exist!")}

            }
        } else { showAchtung (view: self, message: "The TAG can't be empty!")}
    }
    
    
    
    
    @IBAction func onAddBtnTap(_ sender: UIButton) {
        addNewTag()
    }
    
    
    
    
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
    }
    
    //
    //    // MARK: TagListViewDelegate
    //    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
    //        print("Tag pressed: \(title), \(sender)")
    //        tagView.isSelected = !tagView.isSelected
    //    }
    //
    
    
    
        func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
            print("Tag Remove pressed: \(title), \(sender)")
            tagsPresentedAtView.remove(at: tagsPresentedAtView.index(of: (title))!)
            print("new count of tagsPresentedAtView = \(tagsPresentedAtView)")
            sender.removeTagView(tagView)
        }
    
}
















