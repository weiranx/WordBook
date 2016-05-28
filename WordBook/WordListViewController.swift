//
//  WordListViewController.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit

class WordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: Pointer to ns func
    var defaultWordList = WordList.SharedInstance
    let center = NSNotificationCenter.defaultCenter()

    
    // MARK: IBOutlets
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    // MARK: IBActions
    
    @IBAction func back(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // MARK: NSObjectProtocal for dismissal of NSNotifications
    var wcn: NSObjectProtocol?
    var wsn: NSObjectProtocol?
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        wcn = center.addObserverForName(Constants.NotificationNames.DefaultWordListChanged, object: nil, queue: nil) { (notification) in
//            self.tableView.reloadData()
//            self.defaultWordList = WordList.SharedInstance
//
//        }
        wsn = center.addObserverForName(Constants.NotificationNames.wordSearchedNotification, object: nil, queue: nil) { (notification) in
            self.tableView.reloadData()
        }

        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        if traitCollection.forceTouchCapability == .Available{
            registerForPreviewingWithDelegate(self, sourceView: tableView)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//
//        center.removeObserver(wcn!)
        center.removeObserver(wsn!)
    }
    
    
    
    // MARK: TableView Delegate Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultWordList.wordStack.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let rowNum = indexPath.row
        
        let cell = tableView.dequeueReusableCellWithIdentifier("defaultDetailCell")!
        cell.textLabel?.text = defaultWordList.wordStack[rowNum].word
        cell.detailTextLabel?.text = defaultWordList.wordStack[rowNum].def
        
        return cell
    }
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Delete"
    }
    
    
    // MARK: TableView Edit func
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        let word = cell.textLabel?.text
        defaultWordList.deleteWordForDefaultList(Word(word: word!, withCustomMeaning: ""))
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    @IBAction func deleteAllPrompt(sender: AnyObject) {
        let alert = UIAlertController(title: "Are you sure to delete all words from the word list?", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .Destructive, handler: { (alertAction) in
            self.defaultWordList.deleteAllWordsInDefaultList()
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    var selectedWord: Word?
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        let word = Word(word: (cell.textLabel?.text)!, autoSave: false)
        selectedWord = word
        
        performSegueWithIdentifier(Constants.SegueNames.detailWordView, sender: nil)
    }
    
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? UINavigationController {
            if let wvc = nvc.visibleViewController as? WordViewController {
                wvc.lastViewController = self
            }
        }
    }
    
    
}
