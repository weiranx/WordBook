////
////  WordList.swift
////  WordBook
////
////  Created by Weiran Xiong on 4/30/16.
////  Copyright © 2016 Weiran Xiong. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//class WordList: CustomStringConvertible {
//    
//    static var SharedInstance: WordList {
//        get {
//            return WordList.retriveEncodedWordListInNSUserDefaults(withIdentifier: Constants.WordList.SharedWordList) ?? WordList()
//        }
//        set {
//
//            newValue.encodeDataToNSUserDefaults(withIdentifier: Constants.WordList.SharedWordList)
//        }
//    }
//    
//    let defaults = NSUserDefaults.standardUserDefaults()
//    static let defaults = NSUserDefaults.standardUserDefaults()
//    static let center = NSNotificationCenter.defaultCenter()
//    let center = NSNotificationCenter.defaultCenter()
//    
//    
//    var wordStack = [Word]()
//    
//    init() {
//        
//    }
//    
//    init(inputStack: [Word]) {
//        self.wordStack = inputStack
//    }
//    
//    
//    // MARK: Debuggeble Content
//    
//    var description: String {
//        var str = ""
//
//            for word in wordStack {
//                str += "\(word.word!) "
//            }
//        
//        return str
//    }
//    
//    
//    func addWordForDefaultList(wordToAdd: Word) -> Bool {
//        for iterateWord in wordStack {
//            if iterateWord.word == wordToAdd.word {
//                return false
//            }
//        }
//        
//        wordStack.append(wordToAdd)
//        WordList.SharedInstance = self
//        
//        center.postNotificationName(Constants.NotificationNames.DefaultWordListChanged, object: wordToAdd)
//        return true
//    }
//    func deleteWordForDefaultList(wordToDelete: Word) {
//        var index = 0
//        for iterateWord in wordStack {
//            if iterateWord.word == wordToDelete.word {
//                wordStack.removeAtIndex(index)
//            }
//            index = index+1
//        }
//        WordList.SharedInstance = self
//        
//        center.postNotificationName(Constants.NotificationNames.DefaultWordListChanged, object: nil)
//    }
//    
//    
//    func deleteAllWordsInDefaultList() {
//        WordList.SharedInstance = WordList()
//        center.postNotificationName(Constants.NotificationNames.DefaultWordListChanged, object: nil)
//    }
//    
//    func encodeDataToNSUserDefaults(withIdentifier identifier: String){
//        
//        var wordListStringArray = [String]()
//        
//        for word in wordStack {
//            wordListStringArray.append(word.word!)
//        }
//        
//        defaults.setObject(wordListStringArray, forKey: identifier)
//        
//    }
//    
//    class func retriveEncodedWordListInNSUserDefaults(withIdentifier identifer: String) -> WordList? {
//        
//        var returnWordListData = [Word]()
//        
//        if let wordListStringArray = defaults.objectForKey(identifer) as? [String] {
//            for wordString in wordListStringArray {
//                if let word = Word(word: wordString) {
//                    returnWordListData.append(word)
//                } else {
//                    return nil
//                }
//            }
//            return WordList(inputStack: returnWordListData)
//        }
//        return nil
//    }
//    
//    
//    
//    
//    
//}
//
//
//
//
