//
//  Word.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import Foundation
import Alamofire
import CoreData


class Word {
    
    let center = NSNotificationCenter.defaultCenter()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // MARK: Private Instance
    
    var word: String?
    var def: String?
    var shouldAutoSave: Bool?
    
    // MARK: Init Methods
    init?(word: String, autoSave: Bool) {
        self.word = word
        shouldAutoSave = autoSave
        findMeaningBaidu()
    }
    
    init(word: String, withCustomMeaning inputMeaning: String) {
        self.word = word
        self.def = inputMeaning
    }
    
    // MARK: Instance Methods
    
    private func findMeaningBaidu() {
        
        let to = defaults.objectForKey(Constants.DefaultsKey.definitionLanguageKey) as? String ?? "zh"
    
        let appid = "20160225000013498"
        let key = "Zr8kx_Rhqxpci0bNJ3EI";
        let salt = 21445 + random()
        let query = self.word
        let from = "en";
        let str1 = "\(appid)\(query!)\(salt)\(key)"
        let data = str1.dataUsingEncoding(NSUTF8StringEncoding)!
        let sign = data.md5Hash()
        
        let sendingParameters: [String: AnyObject]? = ["q":query!, "appid":appid, "from":from, "to":to, "sign":sign, "salt":salt]

        request(.GET, "http://api.fanyi.baidu.com/api/trans/vip/translate", parameters: sendingParameters, encoding: .URL, headers: nil).responseJSON { res in
            
            if res.result.value == nil {return}
            
            if let def = res.result.value?["trans_result"]??[0]["dst"] as? String {
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.def = def
                    
                    self.center.postNotificationName(Constants.NotificationNames.wordSearchedNotification, object: self, userInfo: nil)
                    
                    if self.shouldAutoSave == true {
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let context = appDelegate.managedObjectContext
                        
                        
                        let newWord = NSEntityDescription.insertNewObjectForEntityForName("Word", inManagedObjectContext: context)
                        newWord.setValue(self.word, forKey: "word")
                        newWord.setValue(def, forKey: "def")
                        
                        do {
                            try context.save()
                            print("hey")
                        } catch {
                            fatalError()
                        }
                    }
                    
                    
                })
                
            }
        }
    }
    
    private func findMeaning() {
        
        let requestStr = "https://glosbe.com/gapi/translate/"
        
        let format = "json"
        let from = "eng"
        let dest = "eng"
        let phrase = word!
        let pretty = true
        
        let sentData: [String: AnyObject]? = ["format": format, "from": from, "dest": dest, "phrase": phrase, "pretty": pretty]
        
        request(.GET, requestStr, parameters: sentData, encoding: .URL, headers: nil).responseJSON { (res) in
            
            if let resValue = res.result.value {
                
                
                if let tucs = resValue["tuc"] as? NSArray{
                    
                    print(tucs)


                    if tucs.count > 0 {
                        if let resSt = tucs[0]["meanings"]??[0]?["text"] as? String{
                            
                            dispatch_async(dispatch_get_main_queue(), {
                                self.def = resSt
                                
                                self.center.postNotificationName(Constants.NotificationNames.wordSearchedNotification, object: self, userInfo: nil)
                                
                            })
                            
                        }
                    }
                    
                }
            }
            
        }
        
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



}
