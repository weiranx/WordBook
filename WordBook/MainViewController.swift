//
//  MainViewController.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let center = NSNotificationCenter.defaultCenter()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var defaultList = WordList.SharedInstance
    
    @IBOutlet var viewOne: UIView!
    @IBOutlet var viewTwo: UIView!


    @IBOutlet var todayTaskLabel: UILabel!
    
    var dwc: NSObjectProtocol?
    
    override func viewDidLoad() {
        var count = defaultList.wordStack.count ?? 0
    
        dwc = center.addObserverForName(Constants.NotificationNames.DefaultWordListChanged, object: nil, queue: nil) { (notification) in
            self.defaultList = WordList.SharedInstance
            count = self.defaultList.wordStack.count ?? 0
            self.todayTaskLabel?.text = "You have \(count) words in the word list"
        }
        
        todayTaskLabel?.text = "You have \(count) words in the word list"
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let animationble = defaults.objectForKey(Constants.DefaultsKey.allowAnimationKey) as? Bool {
            if animationble == false {

            } else {
                Animate.fadeInAnimationStack(withViewStack: [viewOne, viewTwo], inReferenceView: nil, forTimeInSeconds: 0.2)
            }
        }  else {
               Animate.fadeInAnimationStack(withViewStack: [viewOne, viewTwo], inReferenceView: nil, forTimeInSeconds: 0.2)
        }

    }
    
    
    var sourceType: UIImagePickerControllerSourceType = .Camera
    
    @IBAction func addWordsFromPhotos(sender: AnyObject) {
        
        
        
        let alert = UIAlertController(title: "From which media source?", message: nil, preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { (alertAction) in
            self.sourceType = .Camera
            self.presentMediaController()
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: { (alertAction) in
            self.sourceType = .PhotoLibrary
            self.presentMediaController()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (alertAction) in

        }))

        presentViewController(alert, animated: true, completion: nil)

    }
    
    func presentMediaController() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePicker.sourceType = sourceType
            presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Avaliable", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    let url = "https://api.projectoxford.ai/vision/v1.0/ocr?language=en&detectOrientation=true"
    
    let headers = ["Ocp-Apim-Subscription-Key":"0fde39b9943d45bf9d5fb791d99ce4bd", "Content-Type":"application/octet-stream"]
    var req: Request?

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let ph = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            guard let phData = UIImageJPEGRepresentation(ph,0.6) else {return}


            
            let urlToUse = NSURL(string: url)
            let request = NSMutableURLRequest(URL: urlToUse!)
            request.HTTPMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.HTTPBody = phData
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, res, err)  in
                
                
                let jsonObj = JSON(data: data!)

                print("connection")
                
                for (_,subJson):(String, JSON) in jsonObj["regions"] {
                    for (_,subJson):(String, JSON)in subJson["lines"] {
                        for (_,subJson):(String, JSON)in subJson["words"] {
                            if let word = subJson["text"].string {
                            	self.defaultList.addWord(Word(word: word, autoSave: true)!)
                            }
                        }
                    }
                }
                
                
            })
            task.resume()
            
            
        }

        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("didCanceled")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

