//
//  Animate.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit

class Animate {
    
    static func fadeInAnimation(withView animateView: UIView, inReferenceView referenceView: UIView?, forTimeInSeconds animationDuration: Double) {
        
        let targetX = animateView.frame.origin.x
        
        animateView.frame.origin.x -= 100
        animateView.alpha = 0
        
        UIView.animateWithDuration(animationDuration) {
            animateView.frame.origin.x = targetX
            animateView.alpha = 1
        }
        
    }
    
    static func fadeInAnimationStack(withViewStack animateViewStack: [UIView], inReferenceView referenceView: UIView?, forTimeInSeconds animationDuration: Double) {
        
        for animateView in animateViewStack {
            
            let index = animateViewStack.indexOf(animateView)!
            
            let targetX = animateView.frame.origin.x
            
            animateView.frame.origin.x -= 100
            animateView.alpha = 0
            
            UIView.animateWithDuration(animationDuration, delay: Double(index)*animationDuration, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                animateView.frame.origin.x = targetX
                animateView.alpha = 1
                }, completion: nil)
            
        }
        
    }
    
    static func shakeAnimation(withViewStack animateView: UIView, inRefernceView referenceView: UIView?, forTimeInSeconds animationDuration: Double) {
        
        let shakeTimes: Double = 20
        
        let originalPosition = animateView.frame.origin.x
        let leftPosition = originalPosition - 50
        let rightPosition = originalPosition + 50
        
        let animationTime = animationDuration/shakeTimes
        
        for var i:Double = 0; i<shakeTimes; i += 1 {

            UIView.animateWithDuration(animationTime, delay: animationTime*i, options: .CurveLinear, animations: {
                
                if i % 2 == 0 {
                    animateView.frame.origin.x = leftPosition
                } else {
                    animateView.frame.origin.x = rightPosition
                }
                
                
            }, completion: nil)
            
            

            
        }
        UIView.animateWithDuration(animationTime, delay: animationDuration, options: .CurveLinear, animations: {
            animateView.frame.origin.x = originalPosition
            }, completion: nil)
        
        
    }
    
    
    
    
}