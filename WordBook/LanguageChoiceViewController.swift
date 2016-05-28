//
//  LanguageChoiceViewController.swift
//  WordBook
//
//  Created by Weiran Xiong on 5/1/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit

class LanguageChoiceViewController: UIViewController {

    let defaults = NSUserDefaults.standardUserDefaults()
    let center = NSNotificationCenter.defaultCenter()
    
    var lastViewController: UIViewController?
    
    @IBOutlet var allowAnimationSwitch: UISwitch!
    
    @IBOutlet var mainPrompt: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        center.postNotificationName(Constants.NotificationNames.DefaultLanguageChanged, object: nil)
        
        Animate.fadeInAnimation(withView: mainPrompt, inReferenceView: nil, forTimeInSeconds: 1)
        
        if let previous = defaults.objectForKey(Constants.DefaultsKey.definitionLanguageKey) as? String{
            print("hey")
            switch previous {
                case Constants.LanguageCodes.French: languageChoiceSegmentedController.selectedSegmentIndex = 1
                case Constants.LanguageCodes.Spanish: languageChoiceSegmentedController.selectedSegmentIndex = 2
                case Constants.LanguageCodes.Russian: languageChoiceSegmentedController.selectedSegmentIndex = 3
                case Constants.LanguageCodes.Japanese: languageChoiceSegmentedController.selectedSegmentIndex = 4
            default: languageChoiceSegmentedController.selectedSegmentIndex = 0
            }
        }
        if let allowAnimation = defaults.objectForKey(Constants.DefaultsKey.allowAnimationKey) as? Bool {
            allowAnimationSwitch.on = allowAnimation
        }
        
    }
    
    
    @IBOutlet var languageChoiceSegmentedController: UISegmentedControl!
    
    
    @IBAction func okButton(sender: AnyObject) {
        
        
        
        // Config allow animation
		let index = languageChoiceSegmentedController.selectedSegmentIndex
        _ = languageChoiceSegmentedController.titleForSegmentAtIndex(index)!
        
        var storeChoice = String()
        switch index {
            case 0: storeChoice = Constants.LanguageCodes.Chinese
            case 1: storeChoice = Constants.LanguageCodes.French
            case 2: storeChoice = Constants.LanguageCodes.Spanish
			case 3: storeChoice = Constants.LanguageCodes.Russian
            case 4: storeChoice = Constants.LanguageCodes.Japanese
        default: storeChoice = Constants.LanguageCodes.Chinese
        }
        
        
        defaults.setObject(storeChoice, forKey: Constants.DefaultsKey.definitionLanguageKey)
        
        
        let allowAnimation = allowAnimationSwitch.on
        defaults.setObject(allowAnimation, forKey: Constants.DefaultsKey.allowAnimationKey)
        
        
        
        
        // Prep to dismiss view controller
        if let lvc = lastViewController as? MainViewController {
            lvc.dismissViewControllerAnimated(true, completion: nil)
        }
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
    


}
