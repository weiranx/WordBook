//
//  WordListCoreData.swift
//  WordBook
//
//  Created by Weiran Xiong on 5/28/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit
import CoreData

class WordList {
    
    static var SharedInstance = WordList()
    
    
    private func writeToCD() {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3), dispatch_get_main_queue()) { 
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            
            let word = self.wordStack.last!
            
            let newWord = NSEntityDescription.insertNewObjectForEntityForName("Word", inManagedObjectContext: context)
            newWord.setValue(word.word!, forKey: "word")
            if word.def != nil {
                newWord.setValue(word.def!, forKey: "def")
            } else {
                newWord.setValue("", forKey: "def")
            }
            
            do {
                try context.save()
                print("hey")
            } catch {
                fatalError()
            }
        }
    }
    
    
    
    var wordStack: [Word]
    
    init() {
        wordStack = []
    }
    
    init(inputStack: [Word]) {
        wordStack = inputStack
    }
    
    let center = NSNotificationCenter.defaultCenter()
    func listChanged() {
        center.postNotification(NSNotification(name: Constants.NotificationNames.DefaultWordListChanged, object: nil))
    }
    
    func addWord(word: Word) -> Bool{
        if redundencyCheck(word.word!) {
            wordStack += [word]
            if word.shouldAutoSave != true {
                writeToCD()
            }
            listChanged()
            return true
        } else {
            return false
        }
    }
    func addWordInit(word: Word) {
        if redundencyCheck(word.word!) {
            listChanged()
            wordStack += [word]
        }
    }
    

    func deleteWordForDefaultList(wordToDelete: Word) {
            var index = 0
            for iterateWord in wordStack {
                if iterateWord.word == wordToDelete.word {
                    wordStack.removeAtIndex(index)
                    
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    let context = appDelegate.managedObjectContext
                    
                    let req = NSFetchRequest(entityName: "Word")
                    do {
                        let res = try context.executeFetchRequest(req)
                        if res.count > 0 {
                            for item in res as! [NSManagedObject] {
                                let word = item.valueForKey("word") as! String
                                if word == wordToDelete.word! {
                                    listChanged()
                                
                                    context.deleteObject(item)
                                }
                            }
                        }
                    } catch {
                        fatalError()
                    }
                    
                    
                }
                index = index+1
            }

   }
    func redundencyCheck(word: String) -> Bool {

        for storedWord in wordStack {
            if word == storedWord.word {
                return false
            }
        }
        return true
    }
    
    
        func deleteAllWordsInDefaultList() {
            wordStack.removeAll()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            
            let req = NSFetchRequest(entityName: "Word")
            do {
                let res = try context.executeFetchRequest(req)
                if res.count > 0 {
                    for item in res as! [NSManagedObject] {
                        listChanged()
                        context.deleteObject(item)
                    }
                }
            } catch {
                fatalError()
            }
        }
    
    
}