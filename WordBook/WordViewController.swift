//
//  WordViewController.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit

class WordViewController: UIViewController, UISearchBarDelegate {
    
    let center = NSNotificationCenter.defaultCenter()
    let defaults = NSUserDefaults.standardUserDefaults()
    var defaultWordList = WordList.SharedInstance

    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .Alert)
    
    var displayWord: Word? {
        didSet {
            refreshUI()
        }
    }
    
    
    // MARK: IBOutlets
    
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var defLabel: UILabel!

    @IBAction func addToWordList(sender: AnyObject) {
        
        var status = false
        searchBar.resignFirstResponder()
        
        if displayWord != nil {
            status = defaultWordList.addWord(displayWord!)
        }
        
        if status == true {
            alert.message = "Added"
        } else {
            alert.message = "Add Failed"
        }
        presentViewController(alert, animated: true, completion: nil)
    }

    
    
    @IBAction func lookUpSystemDictionary(sender: AnyObject) {
        let referenceViewController = UIReferenceLibraryViewController(term: displayWord?.word ?? "")
        presentViewController(referenceViewController, animated: true, completion: nil)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            displayWord = Word(word: searchText, autoSave: false)
        }
        
    }
    
    @IBAction func panGesture(sender: UIPanGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
    
    var wcn: NSObjectProtocol?
    var dlc: NSObjectProtocol?
    
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        center.removeObserver(wcn!)
//        center.removeObserver(dlc!)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) in
        }))
        
        if let wlvc = lastViewController as? WordListViewController{
            displayWord = wlvc.selectedWord
        }
        
        wcn = center.addObserverForName(Constants.NotificationNames.DefaultWordListChanged, object: nil, queue: nil) { (notification) in
            self.defaultWordList = WordList.SharedInstance
        }
        

    }
    

    
    // MARK: Custom Methods
    
    private func refreshUI() {
        
        wordLabel?.text = displayWord?.word
        
        center.addObserverForName(Constants.NotificationNames.wordSearchedNotification, object: displayWord, queue: NSOperationQueue.mainQueue()) { (notification) in
            self.defLabel?.text = self.displayWord?.def
        }
        
        
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let nvc = segue.destinationViewController as? UINavigationController {
            if let dvc = nvc.visibleViewController as? WebBrowsingViewController {
                switch segue.identifier! {
                case Constants.SegueNames.baiduDictionaryWordSearch: dvc.loadType = WordSearchType.BaiduDictionaryWordSearch
                case Constants.SegueNames.googleWordSearch: dvc.loadType = WordSearchType.GoogleSearch
                case Constants.SegueNames.wikipediaWordSearch: dvc.loadType = WordSearchType.WikipediaSearch
                default: break
                }
                dvc.wordViewController = self
            }
        }
    }
    
    
    
    // MARK: As modal View controller
    
    var lastViewController: UIViewController?
    
    @IBAction func goBack(sender: AnyObject) {
        
        if let lvc = lastViewController as? WordListViewController {
            lvc.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    
    
    
    
}
