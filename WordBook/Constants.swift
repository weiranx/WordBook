//
//  Constants.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit

struct Constants {
    
    struct Colors {
        static var standardBackgroundColors = UIColor(red: 40, green: 165, blue: 255, alpha: 1)
    }
    
    struct NotificationNames {
        static var wordSearchedNotification = "wordSearchedNotification"
        static var DefaultWordListChanged = "DefaultWordListChanged"
        static var DataEncoded = "DataEncoded"
        static var DefaultLanguageChanged = "DefaultLanguageChanged"
    }
    
    struct SegueNames {
        static let wikipediaWordSearch = "WikipediaWordSearch"
        static let baiduDictionaryWordSearch = "BaiduDictionaryWordSearch"
        static let googleWordSearch = "GoogleWordSearch"
        static let detailWordView = "DetailWordView"
    }
    struct WordList {
        static let SharedWordList = "SharedWordList"
    }
    struct LanguageCodes {
        static var Chinese = "zh"
        static var English = "en"
        static var Japanese = "jp"
        static var Spanish = "spa"
        static var French = "fra"
        static var Russian = "ru"
    }
    struct DefaultsKey {
    	static var definitionLanguageKey = "definitionLanguageKey"
        static var allowAnimationKey = "allowAnimationKey"
    }
}