//
//  WebBrowsingViewController.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit


enum WordSearchType {
    case GoogleSearch
    case BaiduDictionaryWordSearch
    case WikipediaSearch
    case SystemDictionarySearch
}

extension String {
    func URLEncodedString() -> String? {
        let customAllowedSet =  NSCharacterSet.URLQueryAllowedCharacterSet()
        let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString
    }
    static func queryStringFromParameters(parameters: Dictionary<String,String>) -> String? {
        if (parameters.count == 0)
        {
            return nil
        }
        var queryString : String? = nil
        for (key, value) in parameters {
            if let encodedKey = key.URLEncodedString() {
                if let encodedValue = value.URLEncodedString() {
                    if queryString == nil
                    {
                        queryString = "?"
                    }
                    else
                    {
                        queryString! += "&"
                    }
                    queryString! += encodedKey + "=" + encodedValue
                }
            }
        }
        return queryString
    }
}

class WebBrowsingViewController: UIViewController, UIWebViewDelegate {

    var wordViewController: WordViewController!
    
    var loadType: WordSearchType?
    

    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet var webView: UIWebView! {
        didSet {
            refreshUI()
            webView.delegate = self
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadingIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshUI()
        loadingIndicator.startAnimating()
    }
    
    private func refreshUI() {
        var baseURL = NSURL()
        if loadType != nil {
            switch loadType! {
            case .GoogleSearch: baseURL = NSURL(string: "https://www.google.com/#q=")!
            case .BaiduDictionaryWordSearch: baseURL = NSURL(string: "http://dict.baidu.com/s?wd=")!
            case .WikipediaSearch: baseURL = NSURL(string: "https://en.wikipedia.org/wiki/")!
            default:
                break
            }


            if var word = wordViewController!.displayWord?.word {
                word = word.URLEncodedString()!
                
                let url = NSURL(string: "\(baseURL)\(word)")
                let request = NSURLRequest(URL: url!)
                
                webView.loadRequest(request)

            }
        }
    }
    
    
    @IBAction func dismissSelf(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

 
}
