//
//  WordListViewPreviewEnabledController.swift
//  
//
//  Created by Weiran Xiong on 5/1/16.
//
//

import UIKit

extension WordListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        showViewController(viewControllerToCommit, sender: self)
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRowAtPoint(location) else {return nil}
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else {return nil}
        if let previewController = storyboard?.instantiateViewControllerWithIdentifier("WordViewController") as? WordViewController {
            
            let word = Word(word: (cell.textLabel?.text)!, autoSave: false)
            selectedWord = word
            
            previewingContext.sourceRect = cell.frame
            
            print("view controller: \(self)")
            previewController.lastViewController = self
            
            return previewController
            
        }
        return nil
}
}