//
//  PhotoVC.swift
//  Photo
//
//  Created by  Shadow on 10.12.17.
//  Copyright © 2017  Shadow. All rights reserved.
//

import UIKit
import Alamofire


class PhotoVC: UIViewController, TagListViewDelegate {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scrollViewTags: UIScrollView!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var imgSelectedPhoto: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var BtnAddSavedTags: UIButton!
    @IBOutlet weak var btnCopyToClipboard: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagListView.delegate = self
        
        setupCGIElement(object: BtnAddSavedTags)
        setupCGIElement(object: btnCopyToClipboard)
        setupCGIElement(object: btnBack)
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let image = selectedImage {
            imgSelectedPhoto.image = image
        }
        
        if scrollViewTags.subviews.count > 0 { tagListView.removeAllTags() }
        
        /// предварительно загрузить из базы локальные тэги
        load { (success) in
        }
        
        sendPhotoToServer()
    }
    
    func expandScroll (){
        scrollViewTags.contentSize.height = CGFloat (tagListView.rows + 5) * tagListView.tagViewHeight + CGFloat (tagListView.rows + 5) * CGFloat (tagListView.paddingY)
    }
    
    
    
    func sendPhotoToServer (){
        
        spinner.startAnimating()
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        
        manager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(photoData!, withName: "file", fileName: "image.jpg", mimeType: "image/jpg")
                print ("multipartdata will send rigth now")
        },
            to: postJSONURL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    print ("encodingResult = success!")
                    
                    upload.uploadProgress { _ in
                        self.progressBar.setProgress(Float(upload.uploadProgress.fractionCompleted), animated: true)
                    }
                    upload.responseJSON { response in
                        print ("responseJSON!")
                        if let result = response.result.value {
                            let JSON = result as! NSDictionary
                            let values = JSON["tags"] as! NSArray
                            self.spinner.stopAnimating()
                            self.addToView(tags: values as! [String])
                        }
                    }
                case .failure(let encodingError):
                    if encodingError._code == NSURLErrorTimedOut {
                        showAchtung(view: self, message: "TIME IS OUT!!!")
                        self.spinner.stopAnimating()
                        break
                    } else {
                        showAchtung(view: self, message: "Error! \n \(encodingError)")
                    }
                    
                }
        })
    }
    
    
    
    
    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
    }
    
    
    
    
    func addToView (tags: [String]){
        tagListView.textFont = UIFont.systemFont(ofSize: 16)
        tags.forEach { tag in
            tagListView.addTag(tag)
        }
        expandScroll ()
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onBackBtnTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onAddLocalTagsTapped(_ sender: UIButton) {

        var arrStrTags = [String]()
        /// закинуть их из массива на вьюху
        for idx in localTags {
                arrStrTags.append(idx.text!)
        }
        addToView(tags: arrStrTags)
        
        expandScroll ()
    }
    
    
    
    @IBAction func onCopyToClipboardTap(_ sender: UIButton) {
        tagsAtClipBoard = ""
        tagsInClipboard.removeAll()
        
        tagListView.tagViews.forEach { tag in
            tagsInClipboard.append(tag.currentTitle!)
        }
        
        
            for idx in 0..<tagsInClipboard.count {
                if idx != tagsInClipboard.count-1 {tagsAtClipBoard += tagsInClipboard[idx] + ", "} else  {tagsAtClipBoard += tagsInClipboard[idx]}
            }
            
            print ("tagsAtClipBoard = \(tagsAtClipBoard)")
            let pasteboard = UIPasteboard.general
            pasteboard.string = tagsAtClipBoard
    }
    
    
}
